//
//  ContentView.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import SwiftUI

struct GameView: View {
  @ObservedObject var game:ShapeSetGame
  
  var body: some View {
    VStack{
      Text("Set!").font(.largeTitle).foregroundColor(.black)
      AspectVGrid(items:game.cards, aspectRatio: 2/3){ card in
        CardView(card: card).padding(6)
          .onTapGesture { game.choose(card) }
      }
      .padding(.horizontal)
      cardPiles
    }
  }
  var cardPiles: some View{
    HStack{
      CardPile(items: game.deck)
      Spacer()
      CardPile(items: game.descardedCards)
    }
    .padding(.horizontal)
  }
  var controls: some View{
    HStack{
      if game.deckCount > 0 {
        Button{game.dealNewCards()}label:{Text("Deal 3 More Cards")}
          .buttonStyle(.borderedProminent)
      }
        Button{game.startNewGame()}label:{Text("New Game")}
          .buttonStyle(.bordered)
    }
  }
}

struct CardPile:View{
  var items: [ShapeSetGame.Card]
  var body: some View{
    ZStack{
      ForEach(items.reversed()){card in
        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
          .frame(width: 60, height: 90, alignment: .center)
      }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = ShapeSetGame()
    GameView(game:game)
  }
}

