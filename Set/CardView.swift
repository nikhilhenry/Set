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
    let cardStyle = card.cardStyle
    ZStack{
      let shapeCount = cardStyle.contentNumber.rawValue
      RoundedRectangle(cornerRadius: 20).strokeBorder()
      VStack{
        ForEach(0..<shapeCount,id:\.self){ index in
          createCardContent()
        }
      }
      .padding()
      .foregroundColor(cardStyle.getContentColor())
    }
  }
  
  private func createCardContent()-> some View{
    ZStack{
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
