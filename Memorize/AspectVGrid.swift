//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Abhijeet Kumar  on 03/07/23.
//

import SwiftUI

struct AspectVGrid<Item, ItemView> : View where ItemView: View, Item:Identifiable {
    var items: [Item]
    var aspectRatio:CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        var width:CGFloat = 80
        LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
            ForEach(items) { card in
                content(card).aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
}

