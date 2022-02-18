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
//      let matchStatus = checkMatch(within: selectedCards)
    }
  }
  
  private func checkMatch(within cards:[Card]) -> Bool{
    
    var cardStyles:[CardStyle] = []
    cards.forEach{ card in
      cardStyles.append(card.cardStyle)
    }
    
    return Set(cardStyles.map({$0.contentNumber})).satisfySetRequirement
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
  associatedtype CardContent
  associatedtype CardShading
  associatedtype CardColor
  var contentNumber:ContentNumber { get }
  var cardContent:CardContent { get }
  var cardShading:CardShading { get }
  var cardColor:CardColor {get}
}
