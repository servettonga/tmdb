//
//  SavedView.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import SwiftUI

struct SavedView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Saved")
                    .font(.largeTitle)
                Text("Coming soon...")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Saved")
        }
    }
}

#Preview {
    SavedView()
}
