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
}
