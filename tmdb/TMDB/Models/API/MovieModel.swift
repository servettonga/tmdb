//
//  MovieModel.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import Foundation

// MARK: - API Response
struct MoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

// MARK: - Main Movie Model
struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let genreIds: [Int]?
    let adult: Bool
    let originalLanguage: String
    let video: Bool?
}

// MARK: - Detailed Movie Model
struct MovieDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let adult: Bool
    let originalLanguage: String
    let video: Bool
    let budget: Int?
    let revenue: Int?
    let runtime: Int?
    let status: String?
    let tagline: String?
    let homepage: String?
    let imdbId: String?
    let originCountry: [String]?

    // Nested objects
    let genres: [Genre]?
    let belongsToCollection: MovieCollection?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let spokenLanguages: [SpokenLanguage]?
}

// MARK: - Supporting models
struct MovieCollection: Codable, Identifiable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
}

struct ProductionCompany: Codable, Identifiable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String?
}

struct ProductionCountry: Codable {
    let iso31661: String
    let name: String
}

struct SpokenLanguage: Codable {
    let iso6391: String
    let name: String
    let englishName: String
}

// MARK: Extensions
extension Movie: Equatable {
    var genreNames: String {
        guard let genreIds = genreIds, !genreIds.isEmpty else { return "Unknown" }
        let names = APIService.shared.getGenreNames(for: genreIds)
        return names.isEmpty ? "Unknown" : names.joined(separator: ", ")
    }

    func posterURL(using apiService: APIService = .shared, size: APIConfig.ImageSize = .w500) -> URL? {
        guard let posterPath = posterPath else { return nil }
        return APIService.posterURL(path: posterPath, size: size)
    }

    func backdropURL(using apiService: APIService = .shared, size: APIConfig.ImageSize = .w1280) -> URL? {
        guard let backdropPath = backdropPath else { return nil }
        return APIService.backdropURL(path: backdropPath, size: size)
    }

    var fullPosterURL: URL? {
        return posterURL()
    }

    var fullBackdropURL: URL? {
        return backdropURL()
    }

    var formattedReleaseDate: String {
        guard let releaseDate = releaseDate, !releaseDate.isEmpty else { return "TBA" }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        if let date = formatter.date(from: releaseDate) {
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }

        return releaseDate
    }

    var formattedVoteAverage: String {
        return String(format: "%.1f", voteAverage)
    }

    var ratingText: String {
        return String(format: "%.1f", voteAverage)
    }

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MovieDetail {
    var genreNames: String {
        guard let genres = genres, !genres.isEmpty else { return "Unknown" }
        return genres.map { $0.name }.joined(separator: ", ")
    }

    func posterURL(using apiService: APIService = .shared, size: APIConfig.ImageSize = .w500) -> URL? {
        guard let posterPath = posterPath else { return nil }
        return APIService.posterURL(path: posterPath, size: size)
    }

    func backdropURL(using apiService: APIService = .shared, size: APIConfig.ImageSize = .w1280) -> URL? {
        guard let backdropPath = backdropPath else { return nil }
        return APIService.backdropURL(path: backdropPath, size: size)
    }

    var fullPosterURL: URL? {
        return posterURL()
    }

    var fullBackdropURL: URL? {
        return backdropURL()
    }

    var formattedRuntime: String? {
        guard let runtime = runtime else { return nil }
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }

    var formattedBudget: String? {
        guard let budget = budget, budget > 0 else { return nil }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: budget))
    }

    var formattedReleaseDate: String {
        guard let releaseDate = releaseDate, !releaseDate.isEmpty else { return "TBA" }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        if let date = formatter.date(from: releaseDate) {
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }

        return releaseDate
    }

    var formattedVoteAverage: String {
        return String(format: "%.1f", voteAverage)
    }

    var formattedPopularity: String {
        return String(format: "%.1f", popularity)
    }
}
