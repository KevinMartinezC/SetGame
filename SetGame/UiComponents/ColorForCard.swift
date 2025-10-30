import SwiftUI

func colorForCard(_ cardColor: CardColor) -> Color {
    switch cardColor {
    case .red:
        return .red
    case .green:
        return .green
    case .purple:
        return .purple
    }
}