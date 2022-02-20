//
//  SetGame.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import Foundation

struct SetGame<CardStyle:SetCardStyle>{
  private (set) var cards:[Card] = []
  private var deck:[Card] = []
  private var selectedCardIndices:[Int]{
    get { cards.indices.filter{cards[$0].isSelected} }
    set { cards.indices.forEach{cards[$0].isSelected = newValue.contains($0)} }
  }
  private var setFound:Bool? = .none
  var deckCount:Int{deck.filter{!$0.isDealt}.count}
  
  init(createUniqueCardStyles:()->[CardStyle]){
    //  create cards for deck
    createUniqueCardStyles().enumerated()
      .forEach{deck.append(Card(id:$0,cardStyle:$1))}
    //  deal 12 cards from deck
    deck.first(12).indices.forEach { cards.append(deck[$0]); deck[$0].isDealt = true }
  }
  
  mutating func choose(_ card:Card){
    
    if selectedCardIndices.count > 3 {return}
    if setFound == true {
      setFound = false
      let choosenIndex = cards.firstIndex(where: {$0.id == card.id})!
      if selectedCardIndices.contains(choosenIndex){
        replaceCards()
        return
      }
      else{
        replaceCards()
      }
    }
    else if setFound == false{
      // remove matched status
      selectedCardIndices.forEach{cards[$0].cardStatus = .none}
      // deselect those cardds
      selectedCardIndices = []
      setFound = .none
    }
    
    let choosenIndex = cards.firstIndex(where: {$0.id == card.id})!
    
    //  deselect the card if already chosen
    if let selectedIndex = selectedCardIndices.firstIndex(of: choosenIndex){
      selectedCardIndices.remove(at: selectedIndex)
      return
    }
    
    selectedCardIndices.append(choosenIndex)
    
    if selectedCardIndices.count == 3 {
      setFound = selectedCardIndices.map{cards[$0].cardStyle}.satisfiesSetRequirement
      setFound! ? selectedCardIndices.forEach{cards[$0].cardStatus = .isMatched} : selectedCardIndices.forEach{cards[$0].cardStatus = .isNotMatched}
    }
  }
  
  mutating func dealNewCards(){
    if setFound == true{
      replaceCards()
    }
    else{
    // deal 3 new cards to existing cards set
      deck.filter{!$0.isDealt}[...2].forEach{card in
        deck[card.id].isDealt = true;
        cards.append(card)
      }
    }
  }

  mutating private func replaceCards(){
    if (deck.filter{!$0.isDealt}.count > 0){
      selectedCardIndices.forEach{ index in
        let card = deck.filter{!$0.isDealt}[0]
        // deal that card
        deck[card.id].isDealt = true
        cards[index] = card
      }
    }
    else{
      // remove those three cards
      selectedCardIndices.map{cards[$0]}
      .forEach{ card in
        guard let cardIndex = cards.firstIndex(where: {$0.id == card.id}) else {return}
        cards.remove(at: cardIndex)
      }
    }
  }
  
  enum cardStatusOptions{
    case isMatched
    case isNotMatched
    case none
  }
  
  struct Card:Identifiable {
    let id:Int
    var isDealt = false
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

extension Array where Element:SetCardStyle{
  var satisfiesSetRequirement:Bool{
    guard Set(self.map({$0.contentNumber})).satisfySetRequirement else { return false }
    guard Set(self.map({$0.cardContent})).satisfySetRequirement else { return false }
    guard Set(self.map({$0.cardColor})).satisfySetRequirement else { return false }
    guard Set(self.map({$0.cardShading})).satisfySetRequirement else { return false }
    
    return true
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
