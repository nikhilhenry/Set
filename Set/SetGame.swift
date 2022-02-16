//
//  SetGame.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import Foundation

struct SetGame<CardStyle:SetCardStyle>{
  private (set) var cards:Array<Card> = []
  
  
  init(createUniqueCardStyles:()->[CardStyle]){
    let cardStyles = createUniqueCardStyles()
    cardStyles.enumerated().forEach{cards.append(Card(id:$0,cardStyle:$1))}
  }
  
  
  struct Card:Identifiable {
    var isSelected = false
    let id:Int
    let cardStyle:CardStyle
  }
}


protocol SetCardStyle{
  associatedtype ContentNumber
  associatedtype CardContent
  associatedtype CardShading
  associatedtype CardColor
  var contentNumber:ContentNumber { get }
  var cardContent:CardContent { get }
  var cardShading:CardShading { get }
  var cardColor:CardColor {get}
}
