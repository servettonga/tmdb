//
//  MovieView.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import SwiftUI

struct MovieView: View {
    var body: some View {
        let movieDescription = "Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: \"inception\", the implantation of another person's idea into a target's subconscious."
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Movie Title")
                        .movieDetailTitle()
                    Text("2025")
                        .movieMetadata()
                }
                Text(movieDescription)
                    .movieDescription()
                Spacer()
            }
            .padding(20)
            .navigationTitle("Movies")
        }
    }
}

#Preview {
    MovieView()
}
