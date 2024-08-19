//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Abhijeet Kumar  on 03/06/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
