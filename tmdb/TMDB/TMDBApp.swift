//
//  TMDBApp.swift
//  TMDB
//
//  Created by Servet Hosaf on 10/08/2025.
//

import SwiftUI
import SwiftData

@main
struct TMDBApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onAppear {
                    setupGlobalAppearance()
                }
        }
    }

    private func setupGlobalAppearance() {
        let backgroundColor = UIColor(named: "AppBackground") ?? UIColor.systemBackground

        // Tab Bar
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = backgroundColor
        tabBarAppearance.shadowImage = UIImage()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

        // Navigation Bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = backgroundColor
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        // System UI elements
        UITableView.appearance().backgroundColor = backgroundColor
    }
}
