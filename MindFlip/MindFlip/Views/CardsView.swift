//
//  CardsView.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/14/26.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Back of card
                CardFace(isFront: false)
                    .opacity(card.isFaceUp || card.isMatched ? 0 : 1)
                
                // Front of card
                CardFace(isFront: true, shape: card.shape)
                    .opacity(card.isFaceUp || card.isMatched ? 1 : 0)
            }
            .opacity(card.isMatched ? 0.4 : 1.0)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct CardFace: View {
    let isFront: Bool
    var shape: CardShape?
    
    var body: some View {
        ZStack {
            // Card background
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: isFront ? [.white, Color(white: 0.95)] : [Color(white: 0.9), Color(white: 0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            if isFront, let shape = shape {
                // Front - show shape with gradient
//                shape.view(
//                    color: Color(red: 0.3, green: 0.4, blue: 0.9)
//                )
                Image(systemName: shape.imageName)
                    .scaledToFit()
                    .font(Font.largeTitle.bold())
            } else if !isFront {
                // Back - show pattern
                ZStack {
                    // Outer border
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.46, green: 0.95, blue: 0.80),
                                    Color(red: 0.18, green: 0.84, blue: 0.78)
                                ]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .stroke(
                            Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 0.18),
                            lineWidth: 2
                        )
                }
            }
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.2, green: 0.4, blue: 0.8),
                Color(red: 0.4, green: 0.2, blue: 0.6)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        ScrollView {
            ForEach(CardShape.allCases, id:\.self) { shape in
                Text("\(shape.rawValue)")
                    .font(Font.largeTitle.bold())
                    .foregroundStyle(Color.white)
                HStack {
                    CardView(card: Card(shape: shape, isFaceUp: true))
                        .frame(width: 100, height: 100)
                    
                    CardView(card: Card(shape: shape))
                        .frame(width: 100, height: 100)
                    
                    CardView(card: Card(shape: shape, isFaceUp: true, isMatched: true))
                        .frame(width: 100, height: 100)
                }
                .padding()
            }
        }
    }
}



struct CardsGrid : View {
    //@Environment(GameViewModel.self) var gameViewModel : GameViewModel
    let columns = 4
    let rows = 4
    var body : some View {
        VStack {
            ForEach(0...rows, id: \.self) { row in
                HStack {
                    ForEach(0...columns, id: \.self) { column in
                        CardView(card: Card(shape: .car, isFaceUp: false))
                    }
                }
            }
//            ForEach(0..<gameViewModel.rows, id: \.self) { row in
//                HStack {
//                    ForEach(0..<gameViewModel.columns, id: \.self) { column in
//                        let index = row * gameViewModel.columns + column
//                        if index < gameViewModel.cards.count {
//                            CardView(card: gameViewModel.cards[index])
//                                .onTapGesture {
//                                    gameViewModel.cardTapped(gameViewModel.cards[index])
//                                }
//
//                        }
//                    }
//                }
//            }
        }
    }
}
