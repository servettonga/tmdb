//
//  MovieDetailViewModel.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import Foundation

@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var movie: MovieDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let apiService: APIService

    init(apiService: APIService = .shared) {
        self.apiService = apiService
    }

    func loadMovieDetail(id: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            movie = try await apiService.fetchMovieDetail(id: id)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
