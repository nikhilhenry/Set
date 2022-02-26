//
//  ShapeSetGame.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import SwiftUI

class ShapeSetGame:ObservableObject{
  
  typealias Card = SetGame<CardStyle>.Card
  
  @Published private var model = SetGame<CardStyle>(createUniqueCardStyles: generateUniqueCardStlyes)
  
  var cards: [Card]{
    return model.cards
  }
  
  var deck:[Card]{
    return model.deck.filter{!$0.isDealt}
  }
  
  var descardedCards: [Card]{
    model.deck.filter{$0.isDiscarded}
  }
  
  var deckCount:Int{
    return model.deckCount
  }
  
  //  MARK: - Intent(s)
  func choose(_ card:Card){
    model.choose(card)
  }
  func dealNewCards(){
    model.dealNewCards()
  }
  func startNewGame(){
    model = SetGame<CardStyle>(createUniqueCardStyles: ShapeSetGame.generateUniqueCardStlyes)
  }
  
  //  MARK: - Card Styles
  
  struct CardStyle:SetCardStyle{
    var contentNumber: numberOptions
    var cardContent: contentOptions
    var cardShading: shadingOptions
    var cardColor: colorOptions
    
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
  
  private static func generateUniqueCardStlyes()->[CardStyle]{
    var cardStlyes:[CardStyle] = []
    //  loop through all the enums to generate an CardStyle struct with all enum combinations
    for cardNumber in numberOptions.allCases{
      for cardContent in contentOptions.allCases{
        for cardShading in shadingOptions.allCases{
          for cardColor in colorOptions.allCases{
            cardStlyes
              .append(CardStyle(contentNumber: cardNumber, cardContent: cardContent, cardShading: cardShading, cardColor: cardColor))
          }
        }
      }
    }
    return cardStlyes
  }
  
  // MARK: - Card Style options
  
  enum numberOptions:Int,CaseIterable {
    case one = 1
    case two = 2
    case three = 3
  }
  
  enum colorOptions:CaseIterable{
    case green
    case blue
    case purple
  }
  
  enum contentOptions:CaseIterable{
    case squiggle
    case oval
    case diamond
  }
  
  enum shadingOptions:CaseIterable {
    case striped
    case solid
    case open
  }
}
