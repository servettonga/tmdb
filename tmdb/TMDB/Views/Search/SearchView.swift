//
//  SearchView.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Search")
                    .font(.largeTitle)
                Text("Coming soon...")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchView()
}
