//
//  ContentView.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel:ShapeSetGame
  
  var body: some View {
    VStack{
      Text("Memorize!").font(.largeTitle).foregroundColor(.black)
      ScrollView{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
          ForEach(viewModel.cards){ card in
            CardView(card: card)
              .aspectRatio(2/3, contentMode: .fit)
          }
        }
      }
      .padding(.horizontal)
      .foregroundColor(.red)
    }
  }
}

struct ThemeView: View{
  var themeIcon: String
  var themeTitle: String
  var themeAction: () -> Void
  var body: some View{
    Button(action:{
      themeAction()
    },label:{
      VStack{
        Image(systemName: themeIcon).font(.largeTitle)
        Text(themeTitle)
          .font(.caption)
      }
      .foregroundColor(.blue)
    })
  }
}


struct CardView:View{
  let card:ShapeSetGame.Card
  var body: some View{
    Text("card")
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = ShapeSetGame()
    ContentView(viewModel:game)
  }
}

