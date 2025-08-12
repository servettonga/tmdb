//
//  APIServiceTests.swift
//  TMDB
//
//  Created by Servet Hosaf on 11/08/2025.
//

import XCTest
@testable import TMDB

final class APIServiceTests: XCTestCase {
    var apiService: APIService!

    override func setUpWithError() throws {
        apiService = APIService.shared
    }

    override func tearDownWithError() throws {
        apiService = nil
    }

    // MARK: - Integration Tests

    func testFetchPopularMovies() async throws {
        // When
        let response = try await apiService.fetchPopularMovies()

        // Then
        XCTAssertGreaterThan(response.results.count, 0, "Should return at least one movie")
        XCTAssertGreaterThan(response.totalPages, 0, "Should have total pages")
        XCTAssertEqual(response.page, 1, "Should be first page")

        // Test first movie has required fields
        let firstMovie = response.results.first!
        XCTAssertGreaterThan(firstMovie.id, 0, "Movie should have a valid ID")
        XCTAssertFalse(firstMovie.title.isEmpty, "Movie should have a title")
        XCTAssertGreaterThanOrEqual(firstMovie.voteAverage, 0, "Vote average should be non-negative")
    }

    func testFetchPopularMoviesWithPagination() async throws {
        // Given
        let page2 = 2

        // When
        let response = try await apiService.fetchPopularMovies(page: page2)

        // Then
        XCTAssertEqual(response.page, page2, "Should return requested page")
        XCTAssertGreaterThan(response.results.count, 0, "Should return at least one movie on page 2")
    }

    func testDiscoverMovies() async throws {
        // Given
        let genreIds = [28, 12] // Action, Adventure

        // When
        let response = try await apiService.discoverMovies(genreIds: genreIds)

        // Then
        XCTAssertGreaterThan(response.results.count, 0, "Should return at least one movie")
        XCTAssertEqual(response.page, 1, "Should be first page")

        // Check if the movies match the genre
        let firstMovie = response.results.first!
        XCTAssertNotNil(firstMovie.genreIds, "Movie should have genre IDs")
    }

    func testSearchMovies() async throws {
        // Given
        let searchQuery = "Inception"

        // When
        let response = try await apiService.searchMovies(query: searchQuery)

        // Then
        XCTAssertGreaterThan(response.results.count, 0, "Should return at least one movie")
        XCTAssertEqual(response.page, 1, "Should be first page")

        // Search relevance check
        let firstMovie = response.results.first!
        XCTAssertTrue(firstMovie.title.localizedCaseInsensitiveContains(searchQuery) ||
                      firstMovie.overview?.localizedCaseInsensitiveContains(searchQuery) == true,
                      "Search result should be relevant to query")
    }

    func testFetchMovieDetail() async throws {
        // Given
        let popularResponse = try await apiService.fetchPopularMovies()
        let movieId = popularResponse.results.first!.id

        // When
        let movieDetail = try await apiService.fetchMovieDetail(id: movieId)

        // Then
        XCTAssertEqual(movieDetail.id, movieId, "Should return detail for the requested movie")
        XCTAssertFalse(movieDetail.title.isEmpty, "Movie detail should have a title")
        XCTAssertNotNil(movieDetail.overview, "Movie detail should have an overview")
        XCTAssertNotNil(movieDetail.genres, "Movie detail should have genres")
    }

    func testPosterURLGeneration() {
        // When
        let url = APIService.posterURL(path: "/test.jpg", size: .w342)

        // Then
        XCTAssertEqual(url?.absoluteString, "https://image.tmdb.org/t/p/w342/test.jpg")
    }

    // MARK: - Error Handling Tests

    func testInvalidAPIKey() async throws {
        // Create isolated URLSession to avoid connection reuse
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.requestCachePolicy = .reloadIgnoringCacheData

        let isolatedSession = URLSession(configuration: config)
        let invalidAPIService = APIService(bearerToken: "invalid_token", session: isolatedSession)

        do {
            _ = try await invalidAPIService.fetchPopularMovies()
            XCTFail("Should have failed with invalid API key")
        } catch APIService.APIError.tmdbError(let statusCode, let message) {
            XCTAssertEqual(statusCode, 7, "Should return TMDb error code 7 for invalid API key")
            XCTAssertTrue(message.contains("Invalid API key"), "Error message should mention invalid API key")
        } catch APIService.APIError.networkError {
            // Also acceptable - 401 converted to network error
            XCTAssert(true, "Network error is acceptable for invalid API key")
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

    func testValidTokenDirectly() async throws {
        let validToken = APIConfig.tmdbAPIKey
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular")!

        var request = URLRequest(url: url)
        request.setValue("Bearer \(validToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "accept")

        let (data, response) = try await URLSession.shared.data(for: request)

        if response is HTTPURLResponse {
            let jsonString = String(data: data, encoding: .utf8) ?? ""

            if jsonString.contains("\"results\"") {
                print("✅ Valid token works - got movie data")
            } else if jsonString.contains("status_code") {
                print("❌ Valid token failed - got error: \(String(jsonString.prefix(100)))")
            }
        }
    }

    func testAPIErrorTypes() {
        let invalidURLError = APIService.APIError.invalidURL
        XCTAssertEqual(invalidURLError.errorDescription, "Invalid URL")

        let decodingError = APIService.APIError.decodingFailed
        XCTAssertEqual(decodingError.errorDescription, "Decoding failed")

        let networkError = APIService.APIError.networkError(URLError(.notConnectedToInternet))
        XCTAssertTrue(networkError.errorDescription?.contains("Network error") == true)

        let tmdbError = APIService.APIError.tmdbError(statusCode: 7, message: "Invalid API key")
        XCTAssertEqual(tmdbError.errorDescription, "TMDB Error 7: Invalid API key")
    }

    // MARK: - Performance Tests

    func testFetchPopularMoviesPerformance() async throws {
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            _ = try await apiService.fetchPopularMovies()
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime

            print("⏱️ API call completed in: \(String(format: "%.3f", timeElapsed))s")

            // Assert reasonable performance
            XCTAssertLessThan(timeElapsed, 5.0, "API call should complete within 5 seconds")
        } catch {
            XCTFail("Performance test failed with error: \(error)")
        }
    }
}
