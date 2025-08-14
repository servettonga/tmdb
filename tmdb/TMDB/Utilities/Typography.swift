//
//  Typography.swift
//  TMDB
//
//  Created by Servet Hosaf on 14/08/2025.
//

import SwiftUI

struct Typography {
    // Font weights
    enum Weight {
        case light, regular, medium, semibold, bold

        var fontWeight: Font.Weight {
            switch self {
            case .light: return .light
            case .regular: return .regular
            case .medium: return .medium
            case .semibold: return .semibold
            case .bold: return .bold
            }
        }
    }

    // Font styles
    enum Style {
        case h1, h2, h3, h4, body, caption

        var size: CGFloat {
            switch self {
            case .h1: return 28
            case .h2: return 24
            case .h3: return 18
            case .h4: return 16
            case .body: return 14
            case .caption: return 12
            }
        }

        var weight: Weight {
            switch self {
            case .h1, .h2: return .semibold
            case .h3, .h4, .body, .caption: return .medium
            }
        }

        var font: Font {
            return .system(size: size, weight: weight.fontWeight)
        }
    }
}

// MARK: - Extensions

extension Font {
    static func tmdb(_ style: Typography.Style) -> Font {
        return style.font
    }
}

extension Text {
    func tmdbFont(_ style: Typography.Style) -> some View {
        self.font(.tmdb(style))
    }

    // Headers
    func h1() -> some View {
        self.tmdbFont(.h1)
    }

    func h2() -> some View {
        self.tmdbFont(.h2)
    }

    func h3() -> some View {
        self.tmdbFont(.h3)
    }

    func h4() -> some View {
        self.tmdbFont(.h4)
    }

    func body() -> some View {
        self.tmdbFont(.body)
    }

    func caption() -> some View {
        self.tmdbFont(.caption)
    }

    // Movie specific styles
    func movieTitle() -> some View {
        self.h3()
    }

    func movieDetailTitle() -> some View {
        self.h1()
    }

    func sectionHeader() -> some View {
        self.h2()
    }

    func movieSubtitle() -> some View {
        self.h4()
    }

    func movieDescription() -> some View {
        self.body()
    }

    func movieMetadata() -> some View {
        self.caption()
    }

    // App specific styles
    func sectionTitle() -> some View {
        self.h3()
    }

    func sectionSubtitle() -> some View {
        self.h4()
    }
}

// View Modifiers
extension View {
    func withTypography(_ style: Typography.Style) -> some View {
        self.font(.tmdb(style))
    }
}
