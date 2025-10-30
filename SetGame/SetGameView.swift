//
//  ContentView.swift
//  SetGame
//
//  Created by KevinMartinez on 10/29/25.
//

import SwiftUI

struct SetGameView: View {
    @StateObject private var viewModel: SetGameViewModel = .init()
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 8) {
                HStack {
                    Button("New Game") {
                        viewModel.newGame()
                    }
                    .buttonStyle(.borderedProminent)

                    Spacer()

                    Text("Cards: \(viewModel.game.deck.count)")
                        .font(.headline)

                    Spacer()

                    Button("Deal 3 More") {
                        viewModel.game.dealThreeMore()
                    }
                    .disabled(!viewModel.game.deck.isEmpty)
                    .buttonStyle(.bordered)
                }.padding(.horizontal)

                ScrollView {
                    let cardCount = viewModel.game.cardsInPlay.count
                    let columns = columnsForCardCount(
                        cardCount,
                        geometry: geometry
                    )

                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible(), spacing: 8),
                            count: columns
                        ),
                        spacing: 8
                    ) {

                    }

                }
            }
        }
    }
}

func columnsForCardCount(_ count: Int, geometry: GeometryProxy) -> Int {
    let width = geometry.size.width
    let minCardWidth: CGFloat = 60

    // Calculate optional columns based on card count and available width
    if count <= 12 {
        return width > 800 ? 4 : 3
    } else if count <= 18 {
        return width > 800 ? 6 : 4
    } else if count <= 24 {
        return width > 800 ? 6 : 5
    } else {
        // For many cards, ensure minimun width
        let maxColumns = Int(width / minCardWidth)
        return max(6, min(maxColumns, 9))
    }
}

#Preview {
    SetGameView()
}
