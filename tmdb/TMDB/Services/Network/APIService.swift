//
//  APIClient.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import Foundation

final class APIService: Sendable {
    // Global singleton access
    static let shared = APIService()

    private let baseURL = APIConfig.baseURL
    private let bearerToken: String
    private let session: URLSession

    // Default initializer with API key
    convenience init() {
        self.init(bearerToken: APIConfig.tmdbAPIKey)
    }

    // Injectable initializer for testing or custom configurations
    init(bearerToken: String, session: URLSession = URLSession.shared) {
        self.bearerToken = bearerToken
        self.session = session
    }

    // Error types
    private struct TMDBErrorResponse: Codable {
        let statusCode: Int
        let statusMessage: String
        let success: Bool

        enum CodingKeys: String, CodingKey {
            case statusCode = "status_code"
            case statusMessage = "status_message"
            case success
        }
    }

    enum APIError: Error, LocalizedError {
        case invalidURL
        case decodingFailed
        case noData
        case networkError(Error)
        case tmdbError(statusCode: Int, message: String)

        var errorDescription: String? {
            switch self {
            case .invalidURL: return "Invalid URL"
            case .decodingFailed: return "Decoding failed"
            case .noData: return "No data"
            case .networkError(let underlyingError):
                return "Network error: \(underlyingError.localizedDescription)"
            case .tmdbError(let statusCode, let message): return "TMDB Error \(statusCode): \(message)"
            }
        }
    }

    // Private method to perform network requests
    private func performRequest<T: Codable>(endpoint: String, responseType: T.Type) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }

        // Create request with Bearer token authorization
        var request = URLRequest(url: url)
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "accept")

        do {
            let (data, response) = try await session.data(for: request)

            // Check HTTP status code
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401 {
                    // Parse TMDb error response
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    if let errorResponse = try? decoder.decode(TMDBErrorResponse.self, from: data) {
                        throw APIError.tmdbError(statusCode: errorResponse.statusCode, message: errorResponse.statusMessage)
                    } else {
                        throw APIError.networkError(URLError(.userAuthenticationRequired))
                    }
                } else if httpResponse.statusCode != 200 {
                    throw APIError.networkError(URLError(.badServerResponse))
                }
            }

            // Decode successful response
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let decodedResponse = try decoder.decode(responseType, from: data)
            return decodedResponse
        } catch let apiError as APIError {
            throw apiError
        } catch _ as DecodingError {
            throw APIError.decodingFailed
        } catch {
            throw APIError.networkError(error)
        }
    }

    // Public API methods
    func fetchPopularMovies(page: Int = 1) async throws -> MoviesResponse {
        let endpoint = "\(baseURL)/movie/popular?page=\(page)"
        return try await performRequest(endpoint: endpoint, responseType: MoviesResponse.self)
    }

    func discoverMovies(page: Int = 1, sortBy: String = "popularity.desc", genreIds: [Int] = [],
                        includeAdult: Bool = false) async throws -> MoviesResponse {
        var endpoint = "\(baseURL)/discover/movie?include_adult=\(includeAdult)&include_video=false&language=en-US&page=\(page)&sort_by=\(sortBy)"
        if !genreIds.isEmpty {
            let genreString = genreIds.map { String($0) }.joined(separator: ",")
            endpoint += "&with_genres=\(genreString)"
        }

        return try await performRequest(endpoint: endpoint, responseType: MoviesResponse.self)
    }

    func fetchMovieDetail(id: Int) async throws -> MovieDetail {
        let endpoint = "\(baseURL)/movie/\(id)?language=en-US"
        return try await performRequest(endpoint: endpoint, responseType: MovieDetail.self)
    }

    // Search query with URL encoding
    func searchMovies(query: String, page: Int = 1, includeAdult: Bool = false) async throws -> MoviesResponse {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let endpoint = "\(baseURL)/search/movie?query=\(encodedQuery)&include_adult=\(includeAdult)&language=en-US&page=\(page)"
        return try await performRequest(endpoint: endpoint, responseType: MoviesResponse.self)
    }

    // Computed image URLs
    static func posterURL(path: String, size: APIConfig.ImageSize = .w500) -> URL? {
        guard !path.isEmpty else { return nil }
        let cleanPath = path.hasPrefix("/") ? path : "/\(path)"
        return URL(string: "\(APIConfig.imageBaseURL)/\(size.rawValue)\(cleanPath)")
    }

    static func backdropURL(path: String, size: APIConfig.ImageSize = .w1280) -> URL? {
        guard !path.isEmpty else { return nil }
        let cleanPath = path.hasPrefix("/") ? path : "/\(path)"
        return URL(string: "\(APIConfig.imageBaseURL)/\(size.rawValue)\(cleanPath)")
    }
}
