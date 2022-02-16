//
//  ShapeSetCardStyle.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import SwiftUI

struct ShapeSetGameCardStyle{
  
  enum cardNumbers:Int,CaseIterable {
    case one = 1
    case two = 2
    case three = 3
  }
  
  enum cardColors:CaseIterable{
    case green
    case blue
    case purple
  }
  
  enum cardContents:CaseIterable{
    case squiggle
    case oval
    case diamond
  }
  
  enum cardShadings:CaseIterable {
    case striped
    case solid
    case open
  }
  
  struct CardStyle:SetCardStyle{
    var contentNumber: cardNumbers
    var cardContent: cardContents
    var cardShading: cardShadings
    var cardColor: cardColors
    
    func getContentColor() -> Color{
      switch self.cardColor{
      case .green:
        return Color.green
      case .blue:
        return Color.blue
      case .purple:
        return Color.purple
      }
    }
  }
  
  
  func generateUniqueCardStlyes()->[CardStyle]{
    var cardStlyes:[CardStyle] = []
    for cardNumber in cardNumbers.allCases{
      for cardContent in cardContents.allCases{
        for cardShading in cardShadings.allCases{
          for cardColor in cardColors.allCases{
            cardStlyes
              .append(CardStyle(contentNumber: cardNumber, cardContent: cardContent, cardShading: cardShading, cardColor: cardColor))
          }
        }
      }
    }
    return cardStlyes
  }
}
