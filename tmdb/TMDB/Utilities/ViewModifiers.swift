//
//  ViewModifiers.swift
//  TMDB
//
//  Created by Servet Hosaf on 18/08/2025.
//

import SwiftUI

struct AppBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color("AppBackground"))
    }
}

struct AppListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color("AppBackground"))
            .listRowSeparator(.hidden)
    }
}

extension View {
    // Apply a modifier and return a new view
    func appBackground() -> some View {
        modifier(AppBackgroundModifier())
    }

    func appListRow() -> some View {
        modifier(AppListRowModifier())
    }
}
