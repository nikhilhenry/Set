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
          createCardContent(cardStyle: card.cardStyle).aspectRatio(2/1, contentMode: .fit)
        }
      }
      .padding()
      .foregroundColor(cardStyle.getContentColor())
    }
  }
}


typealias Card = ShapeCardStyles

@ViewBuilder private func createCardContent(cardStyle:Card.CardStyle)-> some View{
  let content = cardStyle.cardContent
  let shading = cardStyle.cardShading
  switch content {
  case .squiggle:
    Rectangle().shade(with: shading)
  case .oval:
    Circle().shade(with:shading)
  case .diamond:
    Diamond().shade(with: shading)
  }
}

extension Shape{
  @ViewBuilder func shade(with shadeOption:Card.shaindOptions) -> some View{
    switch shadeOption{
    case .open:
      self.stroke()
    case .striped:
      self.opacity(0.45)
    case .solid:
      self.fill()
    }
  }
}

