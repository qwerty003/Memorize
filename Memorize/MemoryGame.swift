//
//  MemoryGame.swift
//  Memorize
//
//  Created by Abhijeet Kumar  on 12/06/23.
//

import Foundation


// Create a model class - represents the data structure

struct MemoryGame<CardContent> where CardContent:Equatable {
    private(set) var cards:Array<Card>
    private var alreadyChoosenCardIndex:Int? {
        get { cards.indices.filter({cards[$0].isFaceup}).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceup = ($0==newValue) } }
    }
    
    mutating func choose(_ card:Card) {
        if let choosenIndex=cards.firstIndex(where: {$0.id == card.id}), !cards[choosenIndex].isFaceup, !cards[choosenIndex].isMatched {
            if let previousCardIndex=alreadyChoosenCardIndex {
                if cards[choosenIndex].content == cards[previousCardIndex].content {
                    // Match cards
                    cards[choosenIndex].isMatched = true
                    cards[previousCardIndex].isMatched = true
                }
                cards[choosenIndex].isFaceup = true
            }
            else {
                alreadyChoosenCardIndex = choosenIndex
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content:CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceup:Bool = false
        var isMatched:Bool = false
        var content:CardContent
        var id:Int
    }
}

extension Array {
    var oneAndOnly:Element? {
        if count == 1 {
            return first
        }
        else {
            return nil
        }
    }
}
