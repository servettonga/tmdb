//
//  SeriesView.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import SwiftUI

struct SeriesView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Series")
                    .font(.largeTitle)
                Text("Coming soon...")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Series")
        }
    }
}

#Preview {
    SeriesView()
}
