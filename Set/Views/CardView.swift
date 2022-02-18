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
      let shape = RoundedRectangle(cornerRadius: 10).stroke(lineWidth:3)
      switch card.cardStatus{
      case .isMatched:
        shape.fill(.green)
      case .isNotMatched:
        shape.fill(.red)
      case .none:
        shape.fill(.black)
      }
      if card.isSelected && card.cardStatus == .none{
        shape.fill(.blue)
      }
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


@ViewBuilder private func createCardContent(cardStyle:ShapeCardStyles.CardStyle)-> some View{
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
  @ViewBuilder func shade(with shadeOption:ShapeCardStyles.shadingOptions) -> some View{
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

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let cardStyle = ShapeCardStyles.CardStyle(contentNumber:.one, cardContent: .diamond, cardShading: .solid, cardColor: .purple)
    let card = ShapeSetGame.Card(id: 1, isSelected:true, cardStyle: cardStyle)
    CardView(card: card).aspectRatio(2/3, contentMode: .fit).frame(width: 200, height: 300, alignment: .center)
  }
}
