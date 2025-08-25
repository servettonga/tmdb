//
//  MovieListViewModel.swift
//  TMDB
//
//  Created by Servet Hosaf on 16/08/2025.
//

import Foundation

@MainActor // UI updates should be on the main thread
class MovieListViewModel: ObservableObject {
    // State management for the movie list
    @Published var movies: [Movie] = [] // List of movies fetched from the API
    @Published var isLoading = false // Loading indicator
    @Published var errorMessage: String? // Store error messages to show in alerts
    @Published var selectedCategory: MovieCategory = .popular

    private let apiService: APIService
    private var currentPage = 1
    private var canLoadMore = true

    init(apiService: APIService = .shared) {
        self.apiService = apiService
    }

    func loadMovies(category: MovieCategory = .popular, refresh: Bool = false) async {
        // Reset pagination if refreshing
        if refresh {
            currentPage = 1
            canLoadMore = true
            movies = []
        }

        // Guard against multiple simultaneous loads
        guard !isLoading && canLoadMore else { return }

        isLoading = true
        errorMessage = nil

        do {
            // Apporative API call based on the selected category
            let response: MoviesResponse

            switch category {
            case .nowPlaying: response = try await apiService.fetchNowPlayingMovies(page: currentPage)
            case .popular: response = try await apiService.fetchPopularMovies(page: currentPage)
            case .topRated: response = try await apiService.fetchTopRatedMovies(page: currentPage)
            case .upcoming: response = try await apiService.fetchUpcomingMovies(page: currentPage)
            }

            // Update the movies list based on the response
            if refresh {
                movies = response.results
            } else {
                movies.append(contentsOf: response.results)
            }

            // Update pagination state
            currentPage += 1
            canLoadMore = currentPage <= response.totalPages
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func changeCategory(to category: MovieCategory) async {
        selectedCategory = category
        await loadMovies(category: category, refresh: true)
    }
}
