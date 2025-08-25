//
//  MovieRowView.swift
//  TMDB
//
//  Created by Servet Hosaf on 16/08/2025.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie

    var body: some View {
        HStack {
            // Movie Poster
            AsyncImage(url: movie.fullPosterURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 60, height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            // Movie Details
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .movieTitle()
                    .lineLimit(2)
                Text(movie.formattedReleaseDate)
                    .movieMetadata()
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Text(movie.genreNames)
                    .movieMetadata()
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    Text(movie.formattedVoteAverage)
                        .movieMetadata()
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MovieRowView(movie: .preview)
        .padding()
}
