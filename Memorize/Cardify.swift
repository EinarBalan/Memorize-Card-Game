//
//  Cardify.swift
//  Memorize
//
//  Created by Einar Balan on 7/16/20.
//  Copyright © 2020 Einar Balan. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    var isFaceUp: Bool {
        rotation < 90
    }
    var gradient: Gradient?
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    init(isFaceUp: Bool, gradient: Gradient?) {
        rotation = isFaceUp ? 0 : 180
        self.gradient = gradient
    }
    
    func body(content: Content) -> some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: strokeWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            
            Group {
                if gradient != nil {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(gradient: gradient!, startPoint: .bottomLeading, endPoint: .topTrailing))
                }
                else {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
            .opacity(isFaceUp ? 0 : 1)
            
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    //MARK: Drawing Constants
    private let cornerRadius: CGFloat = 10
    private let strokeWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
    
    func cardify(isFaceUp: Bool, gradient: Gradient?) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, gradient: gradient))
    }
}
