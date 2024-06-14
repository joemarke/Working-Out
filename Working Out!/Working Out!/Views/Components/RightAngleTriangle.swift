//
//  RightAngleTriangle.swift
//  Working Out!
//
//  Created by Joe Marke on 03/04/2024.
//

import SwiftUI

struct RightAngleTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let startPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    RightAngleTriangle()
}
