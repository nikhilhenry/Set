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
  @Namespace private var dealingNamespace
  
  var body: some View {
    VStack {
      Text("Set!").font(.largeTitle).foregroundColor(.black)
      AspectVGrid(items: game.cards, aspectRatio: 2 / 3) { card in
        if !isDiscarded(card){
          CardView(card: card)
            .matchedGeometryEffect(id: card.id, in: discardingNamespace)
            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            .padding(6)
            .onTapGesture {
              if game.isMatchPresent{
                withAnimation(.easeIn(duration: 0.5)){game.choose(card)}
              }
              else{
                game.choose(card)
              }
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
  
  // the view for discarded cards
  var discardPile: some View{
    ZStack {
      ForEach(game.descardedCards) {card in
        if isDiscarded(card){
          CardView(card: card)
            .matchedGeometryEffect(id: card.id, in: discardingNamespace)
            // Extra-credit 1
            .rotationEffect(Angle(degrees: Double.random(in: -10...10)))
        }
        else{
          Color.clear
        }
      }
    } .frame(width: 60, height: 90, alignment: .center)
  }
  
  // the view for deck of cards
  var deckPile: some View{
    ZStack {
      ForEach(game.deck) {card in
        CardView(card: card)
          .matchedGeometryEffect(id: card.id, in: dealingNamespace)
          // Extra-credit 1
          .rotationEffect(Angle(degrees: Double.random(in: -10...10)))
      }
    } .frame(width: 60, height: 90, alignment: .center)
  }
  
  var cardPiles: some View {
    HStack {
      deckPile
        .onTapGesture {
          withAnimation{game.dealNewCards()}
        }
      Spacer()
      controls
      Spacer()
      discardPile
    }
    .padding(.horizontal)
  }
  var controls: some View {
      Button("New Game"){ game.startNewGame() }
      .buttonStyle(.bordered)
  }
  
  private struct CardConstants {
    static let color = Color.red
    static let aspectRatio: CGFloat = 2 / 3
    static let dealDuration: Double = 0.5
    static let totalDealDuration: Double = 0.01
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
