//
//  MainTabView.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    var body: some View {
        TabView {
            MovieView()
                .tabItem {
                    Image(systemName: "film")
                    Text("Movies")
                }

            SeriesView()
                .tabItem {
                    Image(systemName: "tv")
                    Text("Series")
                }

            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }

            SavedView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Saved")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    MainTabView()
}
