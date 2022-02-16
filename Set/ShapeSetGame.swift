//
//  ShapeSetGame.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import SwiftUI

class ShapeSetGame:ObservableObject{
  
  static private let cardStyles = ShapeSetGameCardStyle()
  
  typealias CardStlyes = ShapeSetGameCardStyle.CardStyle
  
  typealias Card = SetGame<ShapeSetGameCardStyle.CardStyle>.Card
  
  @Published private var model = SetGame<CardStlyes>(createUniqueCardStyles: cardStyles.generateUniqueCardStlyes)
  
  var cards: [Card]{
    return model.cards.shuffled()
  }
  
  
}
