//
//  MovieView.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import SwiftUI

struct MovieView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Movies")
                    .font(.largeTitle)
                Text("Coming soon...")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Movies")
        }
    }
}

#Preview {
    MovieView()
}
