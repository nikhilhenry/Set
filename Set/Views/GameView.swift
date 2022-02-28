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
        CardView(card: card)
          .matchedGeometryEffect(id: card.id, in: discardingNamespace)
          .padding(6)
          .onTapGesture { game.choose(card) }
          .onDisappear {
            withAnimation { discard(card) }
          }
      }
      .padding(.horizontal)
      cardPiles
    }
  }
  
  //  private state used to track discarded cards
  @State private var discarded = Set<Int>()
  
  //  marks the given card as discarded
  private func discard(_ card: ShapeSetGame.Card){
    discarded.insert(card.id)
  }
  
  // returns if the given card has not yet been discarded
  private func isDiscarded(_ card: ShapeSetGame.Card) -> Bool {
    discarded.contains(card.id)
  }
  
  // the view for discarded cards
  var discardPile:some View{
    ZStack {
      ForEach(game.descardedCards.reversed()) {card in
        if isDiscarded(card){
          CardView(card: card)
            .matchedGeometryEffect(id: card.id, in: discardingNamespace)
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
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = ShapeSetGame()
    GameView(game: game)
  }
}
