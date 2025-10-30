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
        self.deck = CardNumber.allCases.flatMap { number in
            CardShape.allCases.flatMap { shape in
                CardShading.allCases.flatMap { shading in
                    CardColor.allCases.map { color in
                        Card(
                            number: number,
                            shape: shape,
                            shading: shading,
                            color: color
                        )
                    }
                }
            }
        }.shuffled()

        self.cardsInPlay = Array(deck.prefix(12))
        self.deck = Array(deck.dropFirst(12))
        self.selectedIndices = []
    }

    mutating func select(at index: Int) {
        guard index >= 0 && index < cardsInPlay.count else { return }
        if selectedIndices.count == 3 {
            if isSelectedSet() {
                if selectedIndices.contains(index) {
                    replaceMatchedCards()
                } else {
                    replaceMatchedCards()
                    selectedIndices = [index]
                }
            } else {
                selectedIndices = [index]
            }
        } else {
            if let existingIndex = selectedIndices.firstIndex(of: index) {
                selectedIndices.remove(at: existingIndex)
            } else {
                selectedIndices.append(index)
            }
        }
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

    func selectionState() -> SelectionState {
        if selectedIndices.count == 3 {
            return isSelectedSet() ? .matchingSet : .nonMatchingSet
        }
        return .partial
    }

    func isSelectedSet() -> Bool {
        guard selectedIndices.count == 3 else { return false }
        let cards = selectedIndices.map { cardsInPlay[$0] }
        return Card.isSet(cards[0], cards[1], cards[2])
    }
}
