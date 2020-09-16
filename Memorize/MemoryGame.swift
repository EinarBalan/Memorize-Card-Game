//
//  MemoryGame.swift
//  Memorize
//
//  Created by Einar Balan on 6/28/20.
//  Copyright © 2020 Einar Balan. All rights reserved.
//

//Model
import Foundation

struct MemoryGame<Content> where Content: Equatable {
    private(set) var cards: [Card]
    private(set) var score = 0
    private var dateOfFirstPick: Date?
    
    private var indexOfOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            //when the index is set flip all other cards face down
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    //generate the cards on the table with generic content
    init(numPairs: Int, cardContentFactory: (Int) -> Content) {
        cards = []
        
        for pairIndex in 0..<numPairs {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(of: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfOnlyFaceUpCard {
                scoreHandler(chosenIndex: chosenIndex, potentialMatchIndex: potentialMatchIndex)
            }
            else {
                indexOfOnlyFaceUpCard = chosenIndex
                dateOfFirstPick = Date()
            }

            cards[chosenIndex].isFaceUp = true
        }
    }
    
    private mutating func scoreHandler(chosenIndex: Int, potentialMatchIndex: Int) {
        let match = cards[chosenIndex].content == cards[potentialMatchIndex].content
        let timeScoreModifier = max(5 - Int(Date().timeIntervalSince(dateOfFirstPick!)), 1)
        cards[chosenIndex].isMatched = match
        cards[potentialMatchIndex].isMatched = match
        if match {
            score += timeScoreModifier
        }
        else {
            if cards[chosenIndex].isSeen || cards[potentialMatchIndex].isSeen {
                score -= timeScoreModifier
            }
            cards[chosenIndex].isSeen = true
            cards[potentialMatchIndex].isSeen = true
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                }
                else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var isSeen = false
        var content: Content
        var id: Int
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        // can be zero which means "no bonus points" for this card
        var bonusTimeLimit: TimeInterval = 6

        // how long this card has ever face up
        private var faceUptime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }

        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0

        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - pastFaceUpTime)
        }

        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }

        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }

        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }

        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }

        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUptime
            lastFaceUpDate = nil
        }
        
    }
    
}
