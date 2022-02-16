//
//  CardView.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import SwiftUI

struct CardView:View{
  let card:ShapeSetGame.Card
  
  var body: some View{
    ZStack{
      RoundedRectangle(cornerRadius: 20).strokeBorder()
      createCardContent().padding()
    }
  }
  
  private func createCardContent()-> some View{
    VStack{
      let content = card.cardStyle.cardContent
      switch content {
      case .rectange:
        Rectangle()
      case .circle:
        Circle()
      case .diamond:
        Capsule()
      }
    }
  }
}
