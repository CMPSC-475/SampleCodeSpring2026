//
//  GameViewMdoel.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/15/26.
//
import Foundation
import SwiftUI


enum GameState {
    case start, playing, ended
}


@Observable
class GameViewModel {
    var gameState : GameState = .start
    var cards : [Card] = []
    var flippedCards : [Card] = []
    var isCheckingMatch = false
    
    
    let columns = 4
    let rows = 4
    
    // Tracking User Stats
    var missed = 0
    var correct = 0
    
    
    init() {
        startNewGame()
    }
    
    // Intents/Handlers
    func startNewGame() {
        // Create pairs of cards
        var newCards: [Card] = []
        let totalPairs = (rows * columns) / 2
        let shapes = Array(CardShape.allCases.prefix(totalPairs))
        
        for shape in shapes {
            newCards.append(Card(shape: shape))
            newCards.append(Card(shape: shape))
        }
        
        // Reset scores
        missed = 0
        correct = 0
        
        //TODO: Reset Timer
        
        // Shuffle the cards
        cards = newCards.shuffled()
        flippedCards = []
        gameState = .start
    }
    
    func cardTapped(_ card : Card ) {
        //TODO: implement logic for this
    }
    
    private func checkForMatch() {
        let firstCard = flippedCards[0]
        let secondCard = flippedCards[1]
        
        if firstCard.shape == secondCard.shape {
                correct += 1
                if let firstIndex = cards.firstIndex(where: { $0.id == firstCard.id }),
                   let secondIndex = cards.firstIndex(where: { $0.id == secondCard.id }) {
                    cards[firstIndex].isMatched = true
                    cards[secondIndex].isMatched = true
                }
                
                flippedCards.removeAll()
                
                // Check if game is complete
                checkGameCompletion()
        } else {
                missed += 1
                if let firstIndex = cards.firstIndex(where: { $0.id == firstCard.id }),
                   let secondIndex = cards.firstIndex(where: { $0.id == secondCard.id }) {
                    cards[firstIndex].isFaceUp = false
                    cards[secondIndex].isFaceUp = false
                }
                
                flippedCards.removeAll()
                isCheckingMatch = false
        }
    }
    
    private func checkGameCompletion() {
        let allMatched = cards.allSatisfy { $0.isMatched }
        if allMatched {
            gameState = .ended
            //TODO: track elapsed time
        }
    }
    
    func updateTimer() {
        //TODO: implement timer update for views to show
    }

}



