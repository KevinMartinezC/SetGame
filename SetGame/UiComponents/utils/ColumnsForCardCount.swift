//
//  File.swift
//  SetGame
//
//  Created by KevinMartinez on 10/30/25.
//

import SwiftUI

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
