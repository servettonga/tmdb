//
//  GenreModel.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import Foundation

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}
