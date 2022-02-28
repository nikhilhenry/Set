//
//  CardView.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import SwiftUI

struct CardView: View {
  let card: ShapeSetGame.Card
  var isMatched: Bool{
    return card.cardStatus == .isMatched
  }
  var body: some View {
    Group{
      if !card.isDealt {
        RoundedRectangle(cornerRadius: 10).fill(
          LinearGradient(colors: [.pink, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
      } else {
        let cardStyle = card.cardStyle
        ZStack {
          Rectangle().fill(.white)
          let shapeCount = cardStyle.contentNumber.rawValue
          createCardBorder(card: card)
          VStack {
            ForEach(0..<shapeCount, id: \.self) { _ in
              createCardContent(cardStyle: card.cardStyle).aspectRatio(2 / 1, contentMode: .fit)
            }
          }
          .padding()
          .foregroundColor(cardStyle.getContentColor())
        }
      }
    }
    .offset(x: 0, y: isMatched ? -5:0)
    .animation(.easeInOut(duration: 1), value: isMatched)
  }
}

@ViewBuilder private func createCardBorder(card: ShapeSetGame.Card) -> some View {
  let shape = RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
  switch card.cardStatus {
  case .isMatched:
    shape.fill(.green)
  case .isNotMatched:
    shape.fill(.red)
  case .none:
    shape.fill(.black)
  }
  if card.isSelected && card.cardStatus == .none {
    shape.fill(.blue)
  }
}

@ViewBuilder private func createCardContent(cardStyle: ShapeSetGame.CardStyle)-> some View {
  let content = cardStyle.cardContent
  let shading = cardStyle.cardShading
  switch content {
  case .squiggle:
    //  Extra-credit-1
    Squiggle().shade(with: shading)
  case .oval:
    Circle().shade(with: shading)
  case .diamond:
    Diamond().shade(with: shading)
  }
}

extension Shape {
  @ViewBuilder func shade(with shadeOption: ShapeSetGame.ShadingOptions) -> some View {
    switch shadeOption {
    case .open:
      self.stroke()
    //  Extra-credit 2
    case .striped:
      ZStack {
        GeometryReader {geometry in
          StripedPattern(stripeWidth: max(1, Int(geometry.size.width) / 20))
            .mask(self)
        }
        self.stroke()
      }
    case .solid:
      self.fill()
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let cardStyle = ShapeSetGame.CardStyle(
      contentNumber: .one, cardContent: .squiggle, cardShading: .striped, cardColor: .purple)
    let card = ShapeSetGame.Card(id: 1, isSelected: true, cardStyle: cardStyle)
    CardView(card: card).aspectRatio(2 / 3, contentMode: .fit).frame(width: 200, height: 300, alignment: .center)
  }
}
