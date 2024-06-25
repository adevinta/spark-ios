//
//  StarConfiguration.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public struct StarConfiguration: Equatable, Sendable {
    public var numberOfVertices: Int
    public var vertexSize: CGFloat
    public var cornerRadiusSize: CGFloat

    public var description: String {
        return "\(self.numberOfVertices)-\(self.vertexSize)-\(self.cornerRadiusSize)"
    }

    // MARK: - Default values
    public enum Defaults {
        public static let numberOfVertices = 5
        public static let vertexSize = CGFloat(0.65)
        public static let cornerRadiusSize = CGFloat(0.15)
    }

    public static let `default` = StarConfiguration(
        numberOfVertices: Defaults.numberOfVertices,
        vertexSize: Defaults.vertexSize,
        cornerRadiusSize: Defaults.cornerRadiusSize)

    public init(numberOfVertices: Int,
         vertexSize: CGFloat,
         cornerRadiusSize: CGFloat) {
        self.numberOfVertices = numberOfVertices
        self.vertexSize = vertexSize
        self.cornerRadiusSize = cornerRadiusSize
    }

}
