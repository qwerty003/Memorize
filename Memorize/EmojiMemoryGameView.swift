//
//  ContentView.swift
//  Memorize
//
//  Created by Abhijeet Kumar  on 03/06/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game:EmojiMemoryGame
    
    @State private var dealt = Set<Int>()
    
    @Namespace private var dealingNamespace
    
    // Todo: Check MemoryGame<String>.Card -> EmojiMemoryGame.Card later
    private func deal(_ card: MemoryGame<String>.Card) -> Void {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: MemoryGame<String>.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(_ card: MemoryGame<String>.Card) -> Animation {
        var delay:Double = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (2 / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: 0.5).delay(delay)
    }
    
    var body: some View {
        VStack {
            VStack {
                gameBody
                deckBody
                shuffle
            }
        }
        .padding()
        .foregroundColor(.red)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if (isUndealt(card) || (card.isMatched && !card.isFaceup)){
                Color.clear
            } else {
                CardView(card:card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
//                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)) {
                        game.choose(card)
                    }
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
//                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: 60, height: 60)
        .foregroundColor(.red)
        .onTapGesture {
            // deal cards
            for card in game.cards {
                withAnimation(dealAnimation(card)) {
                    deal(card)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
//        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader (content: { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 45)).padding(5).opacity(0.5)
                Text(card.content).font(font(in: geometry.size))
            }.cardify(isFaceup: card.isFaceup)
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * 0.8)
    }
    
    private struct DrawingConstants {
        static let cornerRadius:CGFloat = 10
        static let lineWidth:CGFloat = 3
        static let fontScale:CGFloat = 0.7
    }
}
