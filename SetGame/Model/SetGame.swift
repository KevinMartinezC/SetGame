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

    mutating func dealThreeMore() {
        if selectedIndices.count == 3 && isSelectedSet() {
            replaceMatchedCards()
        } else {
            let cardsToDeal = min(3, deck.count)
            let newCards = deck.prefix(cardsToDeal)
            cardsInPlay.append(contentsOf: newCards)
            deck.removeFirst(cardsToDeal)
        }
    }

    private mutating func replaceMatchedCards() {
        guard selectedIndices.count == 3 && isSelectedSet() else { return }
        let sortedIndices = selectedIndices.sorted(by: >)
        if deck.isEmpty {
            for index in sortedIndices {
                cardsInPlay.remove(at: index)
            }
        } else {
            for index in sortedIndices {
                if !deck.isEmpty {
                    cardsInPlay[index] = deck.removeFirst()
                }
            }
        }
        selectedIndices = []
    }

    func isSelectedSet() -> Bool {
        guard selectedIndices.count == 3 else { return false }
        let cards = selectedIndices.map { cardsInPlay[$0] }
        return Card.isSet(cards[0], cards[1], cards[2])
    }

}
