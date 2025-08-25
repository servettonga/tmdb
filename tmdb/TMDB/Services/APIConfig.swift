//
//  APIConfig.swift
//  TMDB
//
//  Created by Servet Hosaf on 11/08/2025.
//

import Foundation

struct APIConfig {
    // API key
    // Find Secrets.plist and convert XML data to dictionary
    static let tmdbAPIKey: String = {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let plist = NSDictionary(contentsOfFile: path),
           let apiKey = plist["TMDB_API_KEY"] as? String {
            return apiKey
        }
        fatalError("TMDB_API_KEY not found in Secrets.plist")
    }()

    // URLs
    static let baseURL: String = "https://api.themoviedb.org/3"
    static let imageBaseURL: String = "https://image.tmdb.org/t/p"
    static let genreListURL: String = "\(baseURL)/genre/movie/list"

    // Image sizes
    enum ImageSize: String {
        case w154
        case w185
        case w342
        case w500
        case w780
        case original

        // Backgrop image size
        case w300
        case w1280
    }
}
