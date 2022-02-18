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
    
    if selectedCardIndices.count == 3{
//    check for match
//    get all the cards
      var selectedCards:[Card] = []
      selectedCardIndices.forEach({index in
        selectedCards.append(deck[index])
      })
      if checkMatch(within: selectedCards){
        selectedCardIndices.forEach{deck[$0].cardStatus = .isMatched }
      }
      else{
        selectedCardIndices.forEach{deck[$0].cardStatus = .isNotMatched }
      }
      
    }
  }
  
  private func checkMatch(within cards:[Card]) -> Bool{
    
    var cardStyles:[CardStyle] = []
    cards.forEach{ card in
      cardStyles.append(card.cardStyle)
    }
    
    guard Set(cardStyles.map({$0.contentNumber})).satisfySetRequirement else { return false}
    guard Set(cardStyles.map({$0.cardContent})).satisfySetRequirement else { return false}
    guard Set(cardStyles.map({$0.cardColor})).satisfySetRequirement else { return false}
    guard Set(cardStyles.map({$0.cardShading})).satisfySetRequirement else { return false}
    
    return true
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

extension Set{
  var satisfySetRequirement:Bool{
    return count == 1 || count == 3
  }
}


protocol SetCardStyle{
  associatedtype ContentNumber:Hashable
  associatedtype CardContent:Hashable
  associatedtype CardShading:Hashable
  associatedtype CardColor:Hashable
  var contentNumber:ContentNumber { get }
  var cardContent:CardContent { get }
  var cardShading:CardShading { get }
  var cardColor:CardColor {get}
}
