//
//  MovieDetailView.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import SwiftUI

// Initial MovieDetailView implementation to be refactored
struct MovieDetailView: View {
    let movieId: Int
    @StateObject private var viewModel = MovieDetailViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @State private var showImageViewer = false
    @State private var selectedImageURL: URL?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                // Fixed Backdrop Image
                AsyncImage(url: viewModel.movie?.fullBackdropURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: geometry.size.width, height: 400)
                .clipped()
                
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.clear, location: 0.0),
                        .init(color: Color.clear, location: 0.7),
                        .init(color: (colorScheme == .dark ? Color.black : Color("AppBackground")).opacity(0.2), location: 0.85),
                        .init(color: (colorScheme == .dark ? Color.black : Color("AppBackground")).opacity(0.5), location: 0.95),
                        .init(color: (colorScheme == .dark ? Color.black : Color("AppBackground")).opacity(1), location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: geometry.size.width, height: 400)
                
                // Scrollable Content
                ScrollView {
                    VStack(spacing: 0) {
                        // Spacer
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 350)
                        
                        // Gradient
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.clear, location: 0.0),
                                .init(color: (colorScheme == .dark ? Color.black : Color("AppBackground")).opacity(0.1), location: 0.2),
                                .init(color: (colorScheme == .dark ? Color.black : Color("AppBackground")).opacity(0.4), location: 0.4),
                                .init(color: (colorScheme == .dark ? Color.black : Color("AppBackground")).opacity(0.7), location: 0.6),
                                .init(color: (colorScheme == .dark ? Color.black : Color("AppBackground")).opacity(0.95), location: 0.85),
                                .init(color: colorScheme == .dark ? Color.black : Color("AppBackground"), location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 60)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        // Content
                        if let movie = viewModel.movie {
                            VStack(alignment: .leading, spacing: 16) {
                                // Title and Save button
                                HStack {
                                    Text(movie.title)
                                        .movieDetailTitle()
                                        .lineLimit(2)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Button(action: {
                                        // TODO: Implement save function
                                    }) {
                                        Image(systemName: "heart")
                                            .font(.title2)
                                            .foregroundColor(.red)
                                    }
                                }
                                
                                // Basic Info
                                HStack {
                                    Text(movie.formattedReleaseDate)
                                        .movieSubtitle()
                                        .foregroundColor(.secondary)
                                        .padding(.trailing)
                                    HStack(spacing: 4) {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Text(movie.formattedVoteAverage)
                                            .movieSubtitle()
                                            .foregroundColor(.secondary)
                                        Text("(\(movie.voteCount))")
                                            .movieMetadata()
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                // Genres
                                if !movie.genreNames.isEmpty && movie.genreNames != "Unknown" {
                                    Text(movie.genreNames)
                                        .movieSubtitle()
                                        .foregroundColor(.secondary)
                                }
                                
                                // Runtime
                                if let runtime = movie.formattedRuntime {
                                    HStack {
                                        Text("Runtime:")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Text(runtime)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                // Overview
                                if let overview = movie.overview {
                                    Text("Overview")
                                        .h3()
                                        .padding(.top)
                                        .foregroundColor(.primary)
                                    Text(overview)
                                        .movieDescription()
                                        .foregroundColor(.primary)
                                }
                                
                                // Additional content
                                VStack(alignment: .leading, spacing: 12) {
                                    // Poster
                                    if let posterURL = movie.fullPosterURL {
                                        VStack(alignment: .leading, spacing: 12) {
                                            Text("Poster")
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                                .padding(.top)
                                            
                                            HStack {
                                                Button(action: {
                                                    selectedImageURL = posterURL
                                                    showImageViewer = true
                                                }) {
                                                    AsyncImage(url: posterURL) { image in
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                    } placeholder: {
                                                        Rectangle()
                                                            .fill(Color.gray.opacity(0.3))
                                                            .aspectRatio(2/3, contentMode: .fit)
                                                            .overlay(
                                                                ProgressView()
                                                                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                                                            )
                                                    }
                                                    .frame(maxWidth: 150, maxHeight: 225)
                                                    .cornerRadius(12)
                                                    .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                                                    .overlay(
                                                        // Visual indicator
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                                    )
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                            }
                                        }
                                    }
                                    
                                    Text("Additional Info")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .padding(.top)
                                    
                                    Text("Budget: $\(movie.budget ?? 0)")
                                        .foregroundColor(.secondary)
                                    Text("Language: \(movie.originalLanguage)")
                                        .foregroundColor(.secondary)
                                    
                                }
                                .padding(.top, 20)
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 100)
                            .background(colorScheme == .dark ? Color.black : Color("AppBackground"))
                        } else if viewModel.isLoading {
                            VStack {
                                ProgressView("Loading...")
                                    .padding(.top, 50)
                            }
                            .frame(minHeight: geometry.size.height - 300)
                            .background(colorScheme == .dark ? Color.black : Color("AppBackground"))
                        } else if let error = viewModel.errorMessage {
                            VStack {
                                Text("Error: \(error)")
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            .frame(minHeight: geometry.size.height - 300)
                            .background(colorScheme == .dark ? Color.black : Color("AppBackground"))
                        }
                    }
                }
                
                // Back button
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color.black.opacity(0.6))
                        )
                }
                .padding(.top, max(geometry.safeAreaInsets.top + 8, 50))
                .padding(.leading, 20)
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
        .task {
            await viewModel.loadMovieDetail(id: movieId)
        }
        .sheet(isPresented: $showImageViewer) {
            if let imageURL = selectedImageURL {
                NavigationView {
                    ImageViewerView(imageURL: imageURL, isPresented: $showImageViewer)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Close") {
                                    showImageViewer = false
                                }
                            }
                        }
                }
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
            }
        }
    }
}

struct ImageViewerView: View {
    let imageURL: URL
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        isPresented = false // Tap anywhere to close
                    }
            } placeholder: {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
        }
        .statusBarHidden()
    }
}

#Preview {
    NavigationView {
        MovieDetailView(movieId: 1234821)
    }
}
