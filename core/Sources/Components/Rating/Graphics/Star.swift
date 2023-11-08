//
//  Star.swift
//  SparkCore
//
//  Created by michael.zimmermann on 08.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import UIKit

protocol CGPathShape {
    func cgPath(rect: CGRect) -> CGPath
    var insets: UIEdgeInsets { get }
}

class Star: CGPathShape {
    private let numberOfPoints: Int
    private let vertexSize: CGFloat
    private let cornerRadiusSize: CGFloat
    var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    init(numberOfPoints: Int,
         vertexSize: CGFloat = 0.2,
         cornerRadiusSize: CGFloat = 10.0) {
        self.numberOfPoints = numberOfPoints
        self.vertexSize = vertexSize
        self.cornerRadiusSize = cornerRadiusSize
    }

    func cgPath(rect: CGRect) -> CGPath {
        let path = CGMutablePath()

        self.insets = UIEdgeInsets(top: rect.minY, left: rect.minX, bottom: rect.maxY, right: rect.maxX)

        // the size of each angle step
        let angleStep = ((.pi * 2)  / CGFloat(self.numberOfPoints))

        let initialOffset: CGFloat = -.pi/2

        // the start angle, the first star vertex is to start at the top, therefore the -90° rotation.
        var angle: CGFloat = angleStep + initialOffset

        var centerPoint = CGPoint(x: rect.midX, y: rect.midY)
        let fullRadius = (min(rect.width, rect.height)/2)
        let cornerRadius = self.cornerRadiusSize * fullRadius
        let radius = fullRadius - cornerRadius

        // calculate offset to make star look centered vertically
        let lowestVertex: Int = self.numberOfPoints / 2
        let lowestPoint = CGPoint(
            x: centerPoint.x + radius * cos(angleStep * CGFloat(lowestVertex) + initialOffset),
            y: centerPoint.y + radius * sin(angleStep * CGFloat(lowestVertex) + initialOffset)
        )
        let highestPoint = CGPoint(
            x: centerPoint.x + radius * cos(initialOffset),
            y: centerPoint.y + radius * sin(initialOffset)
        )

        insets.top = highestPoint.y
        insets.bottom = lowestPoint.y
        insets.left = rect.maxX
        insets.right = rect.minX

        let diff = (rect.maxY - highestPoint.y - lowestPoint.y) / 2

        // modify centerpoint to make star look symmetric
        centerPoint = CGPoint(
            x: centerPoint.x,
            y: centerPoint.y + diff)

        let arcAngle = cornerRadius / radius

        // draw the star
        for i in 1...self.numberOfPoints {
            let outerPoint1 = CGPoint(
                x: centerPoint.x + (radius + cornerRadius) * cos(angle - arcAngle/2),
                y: centerPoint.y + (radius + cornerRadius) * sin(angle - arcAngle/2)
            )

            let outerPoint2 = CGPoint(
                x: centerPoint.x + (radius + cornerRadius) * cos(angle + arcAngle/2),
                y: centerPoint.y + (radius + cornerRadius) * sin(angle + arcAngle/2)
            )

            let tangentPoint = CGPoint(
                x: centerPoint.x + radius * cos(angle - arcAngle),
                y: centerPoint.y + radius * sin(angle - arcAngle)
            )

            let nextTangentPoint = CGPoint(
                x: centerPoint.x + radius * cos(angle + arcAngle),
                y: centerPoint.y + radius * sin(angle + arcAngle)
            )

            let innerPoint = CGPoint(
                x: centerPoint.x + (radius * self.vertexSize) * cos(angle + angleStep/2),
                y: centerPoint.y + (radius * self.vertexSize) * sin(angle + angleStep/2)
            )

            if i == 1 {
                path.move(to: tangentPoint)
            } else {
                path.addLine(to: tangentPoint)
            }

            path.addCurve(to: nextTangentPoint, control1: outerPoint1, control2: outerPoint2)

            self.insets.left = [
                self.insets.left,
                nextTangentPoint.x,
                outerPoint1.x,
                outerPoint2.x].reduce(rect.maxX, smallest)
            self.insets.right = [
                self.insets.right,
                nextTangentPoint.x,
                outerPoint1.x,
                outerPoint2.x].reduce(rect.minX, greatest)

            path.addLine(to: innerPoint)

            angle += angleStep
        }
        path.closeSubpath()

        return path
    }
}

private func smallest(_ lh: CGFloat, _ rh: CGFloat) -> CGFloat {
    return lh < rh ? lh : rh
}

private func greatest(_ lh: CGFloat, _ rh: CGFloat) -> CGFloat {
    return lh > rh ? lh : rh
}
