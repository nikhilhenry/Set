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
  private var selectedCardIndices:[Int] = []
  
  init(createUniqueCardStyles:()->[CardStyle]){
//  create cards for deck
    let cardStyles = createUniqueCardStyles()
    cardStyles.enumerated().forEach{deck.append(Card(id:$0,cardStyle:$1))}
    deck.shuffle()
//  deal 12 cards from deck
    deck.first(12).indices.forEach { deck[$0].isDealt = false }
  }
  
  mutating func choose(_ card:Card){
    
    if selectedCardIndices.count >= 3 {return}
    
    let choosenIndex = deck.firstIndex(where: {$0.id == card.id})!
    selectedCardIndices.append(choosenIndex)
    deck[choosenIndex].isSelected = true
}
  
  enum cardStatusOptions{
    case isMatched
    case isNotMatched
    case none
  }
  
  struct Card:Identifiable {
    let id:Int
    var isDealt = true
    var isSelected = false
    var cardStatus:cardStatusOptions = .none
    let cardStyle:CardStyle
  }
}

extension Array{
  func first(_ tillIndex:Int) -> [Element]{
    let upto = tillIndex > self.count ? self.count : tillIndex
      return Array(self[0..<upto])
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
