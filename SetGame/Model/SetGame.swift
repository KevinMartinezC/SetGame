//
//  SetGame.swift
//  SetGame
//
//  Created by KevinMartinez on 10/29/25.
//
import SwiftUI

struct SetGame {
    private(set) var deck: [Card]
    private(set) var cardsInPlay: [Card]
    private(set) var selectedIndices: [Int]

    init() {
        var allCards: [Card] = []
        for number in CardNumber.allCases {
            for shape in CardShape.allCases {
                for shading in CardShading.allCases {
                    for color in CardColor.allCases {
                        allCards.append(
                            Card(
                                number: number,
                                shape: shape,
                                shading: shading,
                                color: color
                            )
                        )
                    }
                }
            }
        }

        allCards.shuffle()
        self.cardsInPlay = Array(allCards.prefix(12))
        self.deck = Array(allCards.dropFirst(12))
        self.selectedIndices = []
    }
}
