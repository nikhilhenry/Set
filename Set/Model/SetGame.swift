//
//  SetGame.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import Foundation

struct SetGame<CardStyle:SetCardStyle>{
  var cards:[Card]{ deck.filter{!$0.isDealt} }
  private var deck:[Card] = []
  
  init(createUniqueCardStyles:()->[CardStyle]){
//  create cards for deck
    let cardStyles = createUniqueCardStyles()
    cardStyles.enumerated().forEach{deck.append(Card(id:$0,cardStyle:$1))}
    deck.shuffle()
//  remove 12 cards from deck
    deck.first(12).indices.forEach { deck[$0].isDealt = false }
  }
  
  mutating func choose(_ card:Card){
    if let choosenIndex = cards.firstIndex(where: {$0.id == card.id}){
      deck[choosenIndex].isSelected.toggle()
    }
}
  
  
  struct Card:Identifiable {
    let id:Int
    var isDealt = true
    var isSelected = false
    let cardStyle:CardStyle
  }
}

extension Array{
  func first(_ tillIndex:Int) -> [Element]{
    Array(self[0..<tillIndex])
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
