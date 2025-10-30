//
//  CardView.swift
//  SetGame
//
//  Created by KevinMartinez on 10/30/25.
//

import SwiftUI

struct CardView: View {
    let card: Card
    let isSelected: Bool
    let selectionState: SelectionState

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        borderColor,
                        lineWidth:
                            borderWidth(for: geometry.size)
                    )
                
                VStack(spacing: geometry.size.height * 0.05) {
                    ForEach(0..<card.number.rawValue , id: \.self){ _ in
                        shapeView(for: card, size: geometry.size)
                    }
                }.padding(geometry.size.width * 0.05)
            }
        }
    }

    private var borderColor: Color {
        if !isSelected {
            return .gray
        }

        switch selectionState {
        case .partial:
            return .blue
        case .matchingSet:
            return .green
        case .nonMatchingSet:
            return .red
        }
    }

    private func borderWidth(for size: CGSize) -> CGFloat {
        if !isSelected {
            return 1
        }

        return min(size.width, size.height) * 0.05
    }
}

@ViewBuilder
func shapeView(for card: Card, size: CGSize) -> some View {
    let shapeColor = colorForCard(card.color)
    let symbolAspectRatio: CGFloat = 2.0
    
    Group {
        switch card.shape {
        case .diamond:
            applyShading(to: Diamond(), card: card, color: shapeColor)
        case .rectangle:
            applyShading(to: Rectangle(), card: card, color: shapeColor)
        case .oval:
            applyShading(to: Capsule(), card: card, color: shapeColor)
        }
    }
    .aspectRatio(symbolAspectRatio, contentMode: .fit)
}

@ViewBuilder
func applyShading(to shape: some Shape, card: Card, color: Color) -> some View {
    switch card.shading {
    case .solid:
        shape.fill(color)
    case .striped:
        shape.fill(color.opacity(0.3))
    case .open:
        shape.stroke(color, lineWidth: 2)
    }
}

#Preview {
    CardView(
        card: Card(
            number: CardNumber.one,
            shape: CardShape.rectangle,
            shading: CardShading.solid,
            color: CardColor.red
        ),
        isSelected: false,
        selectionState: .partial
    )
}
