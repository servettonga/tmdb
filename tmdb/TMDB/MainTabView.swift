//
//  MainTabView.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            MoviesView()
                .tabItem {
                    TabItemImage(imageName: "Movies", isSelected: selectedTab == 0)
                    Text("Movies")
                }
                .tag(0)

            SeriesView()
                .tabItem {
                    TabItemImage(imageName: "Series", isSelected: selectedTab == 1)
                    Text("Series")
                }
                .tag(1)

            SearchView()
                .tabItem {
                    TabItemImage(imageName: "Search", isSelected: selectedTab == 2)
                    Text("Search")
                }
                .tag(2)

            SavedView()
                .tabItem {
                    TabItemImage(imageName: "Saved", isSelected: selectedTab == 3)
                    Text("Saved")
                }
                .tag(3)

            SettingsView()
                .tabItem {
                    TabItemImage(imageName: "Settings", isSelected: selectedTab == 4)
                    Text("Settings")
                }
                .tag(4)
        }
        .appBackground()
    }
}

struct TabItemImage: View {
    let imageName: String
    let isSelected: Bool

    var body: some View {
        Image(isSelected ? "\(imageName)Selected" : imageName)
    }
}

#Preview {
    MainTabView()
}
