//
//  SetGame.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import Foundation

struct SetGame<CardStyle: SetCardStyle> {

  var deckCount: Int {deck.filter {!$0.isDealt}.count}
  var setStatus: CardStatusOptions {
    if selectedCardIndices.count > 0 { return cards[selectedCardIndices[0]].cardStatus} else { return .none}
  }

  private (set) var cards: [Card] = []
  private (set) var deck: [Card] = []
  private var selectedCardIndices: [Int] {
    get { cards.indices.filter {cards[$0].isSelected} }
    set { cards.indices.forEach {cards[$0].isSelected = newValue.contains($0)} }
  }

  init(createUniqueCardStyles:() -> [CardStyle]) {
    // create cards for deck
    createUniqueCardStyles().enumerated().forEach {deck.append(Card(id: $0, cardStyle: $1))}
    // deck.shuffle()
  }

  mutating func choose(_ card: Card) {

    if selectedCardIndices.count > 3 {return}

    switch setStatus {
    case .isMatched:
      let choosenIndex = cards.firstIndex(where: {$0.id == card.id})!
      // do not select a card if choosen card is matched ie already selected
      if selectedCardIndices.contains(choosenIndex) {replaceCards(); return} else {replaceCards()}
    case .isNotMatched:
      // remove matched status
      selectedCardIndices.forEach {cards[$0].cardStatus = .none}
      // deselect those cards
      selectedCardIndices = []
    case .none:
      break
    }

    let choosenIndex = cards.firstIndex(where: {$0.id == card.id})!

    //  deselect the card if already chosen
    if let selectedIndex = selectedCardIndices.firstIndex(of: choosenIndex) {
      selectedCardIndices.remove(at: selectedIndex)
      return
    }

    selectedCardIndices.append(choosenIndex)

    // Check if selected cards make a set
    if selectedCardIndices.count == 3 {
      if selectedCardIndices.map({cards[$0].cardStyle}).satisfiesSetRequirement {
        selectedCardIndices.forEach {cards[$0].cardStatus = .isMatched}
      } else {
        selectedCardIndices.forEach {cards[$0].cardStatus = .isNotMatched}
      }
    }
  }

  mutating func dealNewCards() {
    
//  if no cards have been dealt
    if deck.filter({$0.isDealt}).count == 0{
      // deal 12 cards from deck
      deck.first(12).indices.forEach {deck[$0].isDealt = true; cards.append(deck[$0])}
    }
    
    if setStatus == .isMatched {
      replaceCards()
    } else {
      // deal 3 new cards to existing cards set
      deck.filter {!$0.isDealt}.first(3).forEach {card in
        // deal that card
        dealCard(card.id)
        var card = card; card.isDealt = true
        cards.append(card)
      }
    }
  }

  // Only run if three cards are present
  mutating private func replaceCards() {
    //  discard those cards
    selectedCardIndices.forEach {index in
      deck[index].isDiscarded = true
    }
    selectedCardIndices = []
  }

  private mutating func dealCard(_ id: Int) {
    guard let index = deck.firstIndex(where: {$0.id == id}) else { return }
    deck[index].isDealt = true
  }

  // MARK: Card Struct

  enum CardStatusOptions {
    case isMatched
    case isNotMatched
    case none
  }

  struct Card: Identifiable {
    let id: Int
    var isDealt = false
    var isSelected = false
    var cardStatus: CardStatusOptions = .none
    let cardStyle: CardStyle
    var isDiscarded = false
  }
}

// MARK: Extensions and Protocols

extension Array {
  func first(_ tillIndex: Int) -> [Element] {
    let upto = tillIndex > self.count ? self.count : tillIndex
    return Array(self[0..<upto])
  }
}

extension Set {
  var satisfySetRequirement: Bool {
    return count == 1 || count == 3
  }
}

extension Array where Element: SetCardStyle {
  var satisfiesSetRequirement: Bool {
    guard Set(self.map({$0.contentNumber})).satisfySetRequirement else { return false }
    guard Set(self.map({$0.cardContent})).satisfySetRequirement else { return false }
    guard Set(self.map({$0.cardColor})).satisfySetRequirement else { return false }
    guard Set(self.map({$0.cardShading})).satisfySetRequirement else { return false }

    return true
  }
}

protocol SetCardStyle {
  associatedtype ContentNumber: Hashable
  associatedtype CardContent: Hashable
  associatedtype CardShading: Hashable
  associatedtype CardColor: Hashable
  var contentNumber: ContentNumber { get }
  var cardContent: CardContent { get }
  var cardShading: CardShading { get }
  var cardColor: CardColor {get}
}
