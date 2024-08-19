//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Abhijeet Kumar  on 13/06/23.
//

import Foundation

class EmojiMemoryGame:ObservableObject {
    static var emojis = ["🚝","🚗", "🚘", "🚎", "A", "B", "C", "D"]
    
    @Published private var model:MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: emojis.count) {pairIndex in emojis[pairIndex]}
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: Intent(s)
    
    func choose(_ card:MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
