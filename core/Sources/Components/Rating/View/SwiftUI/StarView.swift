//
//  StarView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 04.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct StarView: View {
    private let rating: CGFloat
    private let lineWidth: CGFloat
    private let borderColor: Color
    private let fillColor: Color
    private let star: StarShape

    // MARK: - Initializer
    /// Create a StarUIView with the following parameters
    ///
    /// - Parameters:
    /// - numberOfVertices: number of vertex elements, the default is 5
    /// - rating: the value of the rating. This should be a number in the range [0...1]
    /// - fillMode: the fill mode of the start. The star will be filled according to the rating and the fillMode.
    /// - lineWidth: the width of the outer border.
    /// - vertexSize: this is the proportional length of the vertex according to the radius and should be in the range [0..1].
    /// - cornerRadiusSize: this is a proportional size of the corner radius according to the radius and should be in the range [0...1].
    /// - borderColor: The color of the border of the unfilled part of the star.
    /// - fillColor: The color of the filled part of the star.
    public init(
        rating: CGFloat = StarDefaults.rating,
        fillMode: StarFillMode = .half,
        lineWidth: CGFloat = StarDefaults.lineWidth,
        borderColor: Color,
        fillColor: Color,
        configuration: StarConfiguration = .default
    ) {
        self.rating = fillMode.rating(of: rating)
        self.lineWidth = lineWidth
        self.borderColor = borderColor
        self.fillColor = fillColor
        self.star = StarShape(configuration: configuration)
    }

    var body: some View {
        if #available(iOS 17.0, *) {
            self.newVersion()
        } else {
            self.oldVersion()
        }
    }

    @available(iOS 17.0, *)
    @ViewBuilder
    func newVersion() -> some View {
        star.stroke(self.borderColor, lineWidth: self.lineWidth)
            .overlay {
                self.background()
                    .mask {
                        star
                            .stroke(self.fillColor, lineWidth: self.lineWidth)
                            .fill(self.fillColor)
                    }
            }
    }


    @ViewBuilder
    func oldVersion() -> some View {
        star.stroke(self.borderColor, lineWidth: self.lineWidth)
            .overlay {
                self.background()
                    .mask {
                        star.stroke(self.fillColor, lineWidth: self.lineWidth)
                    }
            }
            .overlay {
                self.background()
                    .mask {
                        star.fill(self.fillColor)
                    }
            }
    }

    @ViewBuilder
    func background() -> some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(self.fillColor)
                    .frame(width: self.ratingPercent(width: geometry.size.width))
                Rectangle()
                    .fill(Color.clear)
            }
        }
    }

    private func ratingPercent(width: CGFloat) -> CGFloat {
        return width * self.rating
    }
}

#Preview {
    StarView(rating: 0.4,
             fillMode: .half,
             lineWidth: 2.0,
             borderColor: .gray,
             fillColor: .purple,
             configuration: .default)
    .frame(width: 100, height: 100)

}
