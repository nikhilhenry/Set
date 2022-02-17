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
      ScrollView{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
          ForEach(game.cards){ card in
            CardView(card: card)
              .aspectRatio(2/3, contentMode: .fit)
          }
        }
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

