//
//  MovieView.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import SwiftUI

struct MoviesView: View {
    @StateObject private var viewModel = MovieListViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                    // Category Picker
                    CategoryPickerView(viewModel: viewModel)
                    // Movie List
                    MovieListContentView(viewModel: viewModel)
            }
            .navigationTitle("Movies")
            .task {
                if viewModel.movies.isEmpty {
                    await viewModel.loadMovies(category: .popular)
                }
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "An unknown error occurred.")
            }
        }
        .appBackground()
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CategoryPickerView: View {
    @ObservedObject var viewModel: MovieListViewModel

    var body: some View {
        Picker("Category", selection: $viewModel.selectedCategory) {
            ForEach(MovieCategory.allCases, id: \.self) { category in
                Text(category.rawValue).tag(category)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .appBackground()
        .onChange(of: viewModel.selectedCategory) { _, newCategory in
            Task {
                await viewModel.changeCategory(to: newCategory)
            }
        }
    }
}

struct MovieListContentView: View {
    @ObservedObject var viewModel: MovieListViewModel

    var body: some View {
        List {
            ForEach(viewModel.movies) { movie in
                MovieNavigationLink(movie: movie, viewModel: viewModel)
                    .appListRow()
            }

            if viewModel.isLoading {
                LoadingRowView()
                    .appListRow()
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color("AppBackground"))
        .refreshable {
            // Pull to refresh
            await viewModel.loadMovies(category: viewModel.selectedCategory, refresh: true)
        }
    }
}

struct MovieNavigationLink: View {
    let movie: Movie
    @ObservedObject var viewModel: MovieListViewModel

    var body: some View {
        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
            MovieRowView(movie: movie)
        }
        .buttonStyle(.plain)
        .onAppear {
            // Load more movies
            if movie == viewModel.movies.last {
                Task {
                    await viewModel.loadMovies(category: viewModel.selectedCategory)
                }
            }
        }
    }
}

struct LoadingRowView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        .padding(.vertical, 20)
        .appBackground()
    }
}

#Preview {
    MoviesView()
}
