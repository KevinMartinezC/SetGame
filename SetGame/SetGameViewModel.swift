//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by KevinMartinez on 10/30/25.
//

import Combine
import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published var game = SetGame()

    func newGame() {
        game = SetGame()
    }

    func selectCard(card: Card) {
        if let index = game.cardsInPlay.firstIndex(where: { $0.id == card.id })
        {
            game.select(at: index)
        }
    }

    func isSelected(_ card: Card) -> Bool {
        if let index = game.cardsInPlay.firstIndex(where: {
            $0.id == card.id
        }) {
            return game.selectedIndices.contains(index)
        }
        return false
    }
}
