//
//  ContentView.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var game:ShapeSetGame
  
  var body: some View {
    VStack{
      Text("Set!").font(.largeTitle).foregroundColor(.black)
      AspectVGrid(items:game.cards, aspectRatio: 2/3){ card in
        CardView(card: card).padding(4)
      }
      .padding(.horizontal)
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = ShapeSetGame()
    ContentView(game:game)
  }
}

