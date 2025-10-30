//
//  Card.swift
//  SetGame
//
//  Created by KevinMartinez on 10/29/25.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let number: CardNumber
    let shape: CardShape
    let shading: CardShading
    let color: CardColor

    static func isSet(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        let numbersMatch = allSameOrAllDifferent(
            card1.number,
            card2.number,
            card3.number
        )
        let shapesMatch = allSameOrAllDifferent(
            card1.shape,
            card2.shape,
            card3.shape
        )
        let shadingsMatch = allSameOrAllDifferent(
            card1.shading,
            card2.shading,
            card3.shading
        )
        let colorsMatch = allSameOrAllDifferent(
            card1.color,
            card2.color,
            card3.color
        )

        return numbersMatch && shapesMatch && shadingsMatch && colorsMatch
    }

    private static func allSameOrAllDifferent<T: Equatable>(
        _ a: T,
        _ b: T,
        _ c: T
    ) -> Bool {
        (a == b && b == c) || (a != b && b != c && a != c)
    }
}
