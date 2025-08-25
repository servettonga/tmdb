//
//  MockData.swift
//  TMDB
//
//  Created by Servet Hosaf on 16/08/2025.
//

import Foundation

struct MockData {
    // MARK: - Mock Movies
    static let sampleMovie = Movie(
        id: 755898,
        title: "War of the Worlds",
        originalTitle: "War of the Worlds",
        overview: "Will Radford is a top analyst for Homeland Security who tracks potential threats through a mass surveillance program, until one day an attack by an unknown entity leads him to question whether the government is hiding something from him... and from the rest of the world.",
        posterPath: "/yvirUYrva23IudARHn3mMGVxWqM.jpg",
        backdropPath: "/xGu5jTd34DjXGwS7JLmDbgvIQ1U.jpg",
        releaseDate: "2025-07-29",
        voteAverage: 4.3,
        voteCount: 274,
        popularity: 1692.2043,
        genreIds: [878, 53],
        adult: false,
        originalLanguage: "en",
        video: false
    )

    static let sampleMovie2 = Movie(
        id: 519182,
        title: "Despicable Me 4",
        originalTitle: "Despicable Me 4",
        overview: "Gru and Lucy and their girls—Margo, Edith and Agnes—welcome a new baby brother, Gru Jr. But the baby keeps crying and won't stop.",
        posterPath: "/wWba3TaojhK7NdycRhoQpsG0FaH.jpg",
        backdropPath: "/lgkPzcOSnTvjeMnuFzozRO5HHw1.jpg",
        releaseDate: "2024-06-20",
        voteAverage: 7.1,
        voteCount: 2089,
        popularity: 4387.433,
        genreIds: [16, 10751, 35, 28],
        adult: false,
        originalLanguage: "en",
        video: false
    )

    static let sampleMovie3 = Movie(
        id: 533535,
        title: "Deadpool & Wolverine",
        originalTitle: "Deadpool & Wolverine",
        overview: "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him.",
        posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
        backdropPath: "/yDHYTfA3R0jFYba4wWlaDJXBr8v.jpg",
        releaseDate: "2024-07-24",
        voteAverage: 7.7,
        voteCount: 5265,
        popularity: 5632.928,
        genreIds: [28, 35, 878],
        adult: false,
        originalLanguage: "en",
        video: false
    )

    static let sampleMovies = [sampleMovie, sampleMovie2, sampleMovie3]

    // MARK: - Mock Movie Detail
    static let sampleMovieDetail = MovieDetail(
        id: 755898,
        title: "War of the Worlds",
        originalTitle: "War of the Worlds",
        overview: "Will Radford is a top analyst for Homeland Security who tracks potential threats through a mass surveillance program, until one day an attack by an unknown entity leads him to question whether the government is hiding something from him... and from the rest of the world.",
        posterPath: "/yvirUYrva23IudARHn3mMGVxWqM.jpg",
        backdropPath: "/xGu5jTd34DjXGwS7JLmDbgvIQ1U.jpg",
        releaseDate: "2025-07-29",
        voteAverage: 4.3,
        voteCount: 274,
        popularity: 1692.2043,
        adult: false,
        originalLanguage: "en",
        video: false,
        budget: 5,
        revenue: 0,
        runtime: 91,
        status: "Released",
        tagline: "Your data is deadly.",
        homepage: "https://www.amazon.com/gp/video/detail/B0DMF7MXKT",
        imdbId: "tt13186306",
        originCountry: ["US"],
        genres: [
            Genre(id: 878, name: "Science Fiction"),
            Genre(id: 53, name: "Thriller")
        ],
        belongsToCollection: nil,
        productionCompanies: [
            ProductionCompany(id: 33, logoPath: "/6exxhPonOo0M995SAchY0ijpRao.png", name: "Universal Pictures", originCountry: "US"),
            ProductionCompany(id: 109501, logoPath: "/4dtmZKPLHzIALpGbdeSNX6Rw1p3.png", name: "Bazelevs", originCountry: "US")
        ],
        productionCountries: [
            ProductionCountry(iso31661: "US", name: "United States of America")
        ],
        spokenLanguages: [
            SpokenLanguage(iso6391: "en", name: "English", englishName: "English")
        ]
    )

    // MARK: - Mock Genres
    static let sampleGenres = [
        Genre(id: 28, name: "Action"),
        Genre(id: 12, name: "Adventure"),
        Genre(id: 16, name: "Animation"),
        Genre(id: 35, name: "Comedy"),
        Genre(id: 80, name: "Crime"),
        Genre(id: 99, name: "Documentary"),
        Genre(id: 18, name: "Drama"),
        Genre(id: 10751, name: "Family"),
        Genre(id: 14, name: "Fantasy"),
        Genre(id: 36, name: "History"),
        Genre(id: 27, name: "Horror"),
        Genre(id: 10402, name: "Music"),
        Genre(id: 9648, name: "Mystery"),
        Genre(id: 10749, name: "Romance"),
        Genre(id: 878, name: "Science Fiction"),
        Genre(id: 10770, name: "TV Movie"),
        Genre(id: 53, name: "Thriller"),
        Genre(id: 10752, name: "War"),
        Genre(id: 37, name: "Western")
    ]

    // MARK: - Mock Responses
    static let sampleMoviesResponse = MoviesResponse(
        page: 1,
        results: sampleMovies,
        totalPages: 500,
        totalResults: 10000
    )
}

// MARK: - Preview Extensions
extension Movie {
    static let preview = MockData.sampleMovie2
    static let previewList = MockData.sampleMovies
}

extension MovieDetail {
    static let preview = MockData.sampleMovieDetail
}

extension Genre {
    static let preview = MockData.sampleGenres.first!
    static let previewList = MockData.sampleGenres
}

extension MoviesResponse {
    static let preview = MockData.sampleMoviesResponse
}
