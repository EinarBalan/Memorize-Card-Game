//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Einar Balan on 6/28/20.
//  Copyright © 2020 Einar Balan. All rights reserved.
//

//ViewModel ContentView -> MemoryGame
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGame: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
            
    var theme: Theme {
        get {
            Theme.currentTheme
        }
        set {
            Theme.currentTheme = newValue
        }
    }
    
    //utility function to populate cards with specific content and create game instance
    private static func createMemoryGame() -> MemoryGame<String> {
        let theme = Theme.currentTheme
        let numPairs = theme.numPairs ?? Int.random(in: 2...8)
        let emojis = theme.emojis.shuffled()
        
        return MemoryGame<String>(numPairs: numPairs) { emojis[$0] }
    }
    
    func new() {
        Theme.setUniqueRandomTheme()
        memoryGame = EmojiMemoryGame.createMemoryGame()
    }
    
    //MARK: Access to model
    
    var cards: [MemoryGame<String>.Card] {
        memoryGame.cards
    }
    
    var score: Int {
        memoryGame.score
    }
    
    //MARK: Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        memoryGame.choose(card)
    }
    
}

