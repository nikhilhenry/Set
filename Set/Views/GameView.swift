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
      if game.deckCount > 0 {
        Button{game.dealNewCards()}
        label:{Text("Deal 3 More Cards")}
          .buttonStyle(.borderedProminent)
      }
      Button{game.startNewGame()}
      label:{Text("New Game")}
      .buttonStyle(.bordered)
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = ShapeSetGame()
    GameView(game:game)
  }
}

