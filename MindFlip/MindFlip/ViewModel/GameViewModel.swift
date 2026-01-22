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
    var isCheckingMatch = false
    
    var gameStats :GameStats = .init()
    
    var flippedCards: [Card] {
        cards.filter { $0.isFaceUp && !$0.isMatched }
    }
    
    var preferences : Preferences = .init()

    
    // Tracking User Stats
    var missed = 0
    var correct = 0
    
    var elapsedTime : TimeInterval = 0
    var timerStartDate : Date?
    
    
    init() {
        startNewGame()
    }
    
    // Intents/Handlers
    func startNewGame() {
        // Create pairs of cards
        let rows = preferences.difficulty.gridSize
        let columns = preferences.difficulty.gridSize
        var newCards: [Card] = []
        let totalPairs = (rows * columns) / 2
        

        // Reuse shapes if we need more pairs than available shapes
        let availableShapes = Array(CardShape.allCases)
    
        // Create shapes array by cycling through available shapes
        var shapes: [CardShape] = []
        for i in 0..<totalPairs {
            let shapeIndex = i % availableShapes.count
            shapes.append(availableShapes[shapeIndex])
        }
        
        // Create pairs of cards
        for shape in shapes {
            newCards.append(Card(shape: shape))
            newCards.append(Card(shape: shape))
        }
        
        // Reset scores
        missed = 0
        correct = 0
        
        //TODO: Reset Timer
        elapsedTime = 0
        timerStartDate = nil
        
        // Shuffle the cards
        cards = newCards.shuffled()

        gameState = .start
    }
    
    func cardTapped(_ card : Card ) {
        guard !isCheckingMatch,
              let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isFaceUp,
              !cards[index].isMatched else {
            return
        }
        
        // Start the timer on first card tap
        if gameState == .start {
            gameState = .playing
            timerStartDate = Date()
        }
        
        // Flip the card
        cards[index].isFaceUp = true
        
        // Check if we have two cards flipped
        if flippedCards.count == 2 {
            isCheckingMatch = true
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        let firstCard = flippedCards[0]
        let secondCard = flippedCards[1]
        
        if firstCard.shape == secondCard.shape {
            Task {
                try? await Task.sleep(for: .milliseconds(200))
                correct += 1
                if let firstIndex = cards.firstIndex(where: { $0.id == firstCard.id }),
                   let secondIndex = cards.firstIndex(where: { $0.id == secondCard.id }) {
                    cards[firstIndex].isMatched = true
                    cards[secondIndex].isMatched = true
                }
                
                isCheckingMatch = false
                
                // Check if game is complete
                checkGameCompletion()
            }
        } else {
            Task {
                try? await Task.sleep(for: .seconds(1))
                missed += 1
                if let firstIndex = cards.firstIndex(where: { $0.id == firstCard.id }),
                   let secondIndex = cards.firstIndex(where: { $0.id == secondCard.id }) {
                    cards[firstIndex].isFaceUp = false
                    cards[secondIndex].isFaceUp = false
                }
                
                isCheckingMatch = false
            }
        }
    }
    
    private func checkGameCompletion() {
        let allMatched = cards.allSatisfy { $0.isMatched }
        if allMatched {
            guard let timeStartDate = self.timerStartDate else { return }
            gameState = .ended
            elapsedTime = Date().timeIntervalSince(timeStartDate)
            saveGameStats()
        }
        
    }
    
    func updateTimer() {
        guard gameState == .playing, let startDate = timerStartDate else { return }
        elapsedTime = Date().timeIntervalSince(startDate)
    }
    
    
    private func saveGameStats() {
        let timeInSeconds = Int(elapsedTime)
        gameStats.addStat(
            name: "user",
            gameDifficulty: preferences.difficulty,
            missed: missed,
            correct: correct,
            time: timeInSeconds
        )
        gameStats.save()
    }

}



