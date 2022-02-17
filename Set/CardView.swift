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
          createCardContent().aspectRatio(2/1, contentMode: .fit)
        }
      }
      .padding()
      .foregroundColor(cardStyle.getContentColor())
    }
  }
  
  private func createCardContent()-> some View{
    ZStack{
      let content = card.cardStyle.cardContent
      let shading = card.cardStyle.cardShading
      switch content {
      case .squiggle:
        switch shading{
        case .open:
          Rectangle().stroke()
        case .striped:
          Rectangle().opacity(0.45)
        case .solid:
          Rectangle().fill()
        }
      case .oval:
        switch shading{
        case .open:
          Circle().stroke()
        case .striped:
          Circle().opacity(0.45)
        case .solid:
          Circle().fill()
        }
      case .diamond:
        switch shading{
        case .open:
          Diamond().stroke()
        case .striped:
          Diamond().opacity(0.45)
        case .solid:
          Diamond().fill()
        }
      }
    }
  }
}


