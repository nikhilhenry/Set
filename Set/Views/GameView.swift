//
//  ContentView.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import SwiftUI

struct GameView: View {
  @ObservedObject var game: ShapeSetGame
  
  @Namespace private var discardingNamespace
  
  var body: some View {
    VStack {
      Text("Set!").font(.largeTitle).foregroundColor(.black)
      AspectVGrid(items: game.cards, aspectRatio: 2 / 3) { card in
        if !isDiscarded(card){
          CardView(card: card)
            .matchedGeometryEffect(id: card.id, in: discardingNamespace)
            .padding(6)
            .onTapGesture {
              withAnimation(discardAnimation(for: card)){game.choose(card)}
            }
        }
      }
      .padding(.horizontal)
      cardPiles
    }
  }
  
  // returns if the given card has not yet been discarded
  private func isDiscarded(_ card: ShapeSetGame.Card) -> Bool {
    game.descardedCards.contains {$0.id == card.id}
  }
  
  // delay discarding of cards not all at once
  private func discardAnimation(for card: ShapeSetGame.Card) -> Animation {
    var delay = 0.0
    if let index = game.descardedCards.firstIndex(where: { $0.id == card.id }) {
      delay = Double(index) * (CardConstants.totalDealDuration / Double(game.descardedCards.count))
    }
    return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
  }
  
  // the view for discarded cards
  var discardPile:some View{
    ZStack {
      ForEach(game.descardedCards) {card in
        if isDiscarded(card){
          CardView(card: card)
            .matchedGeometryEffect(id: card.id, in: discardingNamespace)
            .transition(.slide)
        }
        else{
          Color.clear
        }
      }
    } .frame(width: 60, height: 90, alignment: .center)
  }
  
  var cardPiles: some View {
    HStack {
      cardPile(for: game.deck)
        .onTapGesture {game.dealNewCards()}
      Spacer()
      discardPile
    }
    .padding(.horizontal)
  }
  var controls: some View {
    HStack {
      if game.deckCount > 0 {
        Button {game.dealNewCards()}label: {Text("Deal 3 More Cards")}
        .buttonStyle(.borderedProminent)
      }
      Button {game.startNewGame()}label: {Text("New Game")}
      .buttonStyle(.bordered)
    }
  }
  private func cardPile(for items: [ShapeSetGame.Card]) -> some View {
    ZStack {
      ForEach(items.reversed()) {card in
        CardView(card: card).aspectRatio(2 / 3, contentMode: .fit)
          .frame(width: 60, height: 90, alignment: .center)
      }
    }
  }
  
  private struct CardConstants {
    static let color = Color.red
    static let aspectRatio: CGFloat = 2 / 3
    static let dealDuration: Double = 0.5
    static let totalDealDuration: Double = 2
    static let undealtHeight: CGFloat = 90
    static let undealtWidth = undealtHeight * aspectRatio
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = ShapeSetGame()
    GameView(game: game)
  }
}
