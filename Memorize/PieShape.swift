//
//  PieShape.swift
//  Memorize
//
//  Created by Einar Balan on 7/5/20.
//  Copyright © 2020 Einar Balan. All rights reserved.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var anticlockwise = true // false = clockwise, true = counterclockwise 
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = .radians(newValue.first)
            endAngle = .radians(newValue.second)
        }
    }
    
    init(startAngle: Angle, endAngle: Angle) {
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        
        path.move(to: start)
        path.addLine(to: start)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: anticlockwise)
        path.addLine(to: center)
        
        return path
    }
    
    
}
