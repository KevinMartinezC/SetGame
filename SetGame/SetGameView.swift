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
                    .disabled(viewModel.game.deck.isEmpty)
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
                        ForEach(viewModel.game.cardsInPlay) { card in
                            CardView(
                                card: card,
                                isSelected: viewModel.isSelected(card),
                                selectionState: viewModel.game.selectionState()
                            )
                            .aspectRatio(2 / 3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.selectCard(card: card)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SetGameView()
}
