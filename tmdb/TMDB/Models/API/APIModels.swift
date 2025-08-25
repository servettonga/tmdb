//
//  APIModels.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

enum MovieCategory: String, CaseIterable {
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"

    var endpoint: String {
        switch self {
        case .nowPlaying: return "now_playing"
        case .popular: return "popular"
        case .topRated: return "top_rated"
        case .upcoming: return "upcoming"
        }
    }
}
