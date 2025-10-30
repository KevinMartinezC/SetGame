//
//  ColorForCard.swift
//  SetGame
//
//  Created by KevinMartinez on 10/30/25.
//

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
