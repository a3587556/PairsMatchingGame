//
//  Card.swift
//  MatchPairs
//
//  Created by Howard Yeh on 2014-09-03.
//  Copyright (c) 2014 Howard Yeh. All rights reserved.
//

import UIKit

func == (a: Card, b: Card) -> Bool {
    return a.rank == b.rank && a.suit == b.suit
}

class Card {
    class func random() -> Card {
        let rank = Rank(rawValue: Int(arc4random_uniform(UInt32(Rank.King.rawValue+1))))
        let suit = Suit(rawValue: Int(arc4random_uniform(UInt32(Suit.Spade.rawValue+1))))
        return Card(rank: rank!, suit: suit!)
    }

    // enumerate a full deck of cards
    class func fullDeck() -> [Card] {
        var cards : [Card] = []
        for i in 0..<Suit.Spade.rawValue {
            for j in 0..<Rank.King.rawValue {
                cards.append(Card(rank: Rank(rawValue: j)!, suit: Suit(rawValue: i)!))
            }
        }
        return cards
    }

    enum Rank : Int, Printable {
        case Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King

        var description : String {
            var name : String
            switch self {
            case .Two, .Three, .Four, .Five, .Six, .Seven, .Eight, .Nine, .Ten:
                name = String(self.rawValue+1)
            case .Ace:
                name = "ace"
            case .Jack:
                name = "jack"
            case .Queen:
                name = "queen"
            case .King:
                name = "king"
            }
            return name
        }
    }

    enum Suit : Int, Printable {
        case Heart, Diamond, Club, Spade

        var description : String {
            var name : String
            switch self {
            case .Club:
                name = "clubs"
            case .Diamond:
                name = "diamonds"
            case .Heart:
                name = "hearts"
            case .Spade:
                name = "spades"
            }
            return name
        }
    }

    var suit : Suit
    var rank : Rank

    init(rank: Rank,suit: Suit) {
        self.rank = rank
        self.suit = suit
    }

    func imageName() -> String {
        // wtf: description string doesn't work in test environment
        let rankString = self.rank.description
        let suitString = self.suit.description
        return "\(rankString)_of_\(suitString)"
    }
}