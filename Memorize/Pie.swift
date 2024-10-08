//
//  Pie.swift
//  Memorize
//
//  Created by Abhijeet Kumar  on 05/07/23.
//

import SwiftUI

struct Pie: Shape {
    var startAngle:Angle
    var endAngle:Angle
    var clockWise:Bool = false
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y:rect.midY)
        let radius = min(rect.width, rect.height)/2
        let start = CGPoint(
            x: center.x + CGFloat(cos(startAngle.radians)),
            y: center.y + CGFloat(sin(startAngle.radians))
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockWise)
        p.addLine(to: center)
        return p
    }
}
