//
//  StarShape.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 04.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// A SwiftUI shape representing a star.
/// The paths of the stars are cached to avoid recalculating the same path multiple times.
struct StarShape: Shape {
    // MARK: - Private variables
    private static let cache: NSCache<NSString, CGPath> = .init()
    private let configuration: StarConfiguration

    // MARK: - Initializer
    init(configuration: StarConfiguration) {
        self.configuration = configuration
    }

    /// Returns the path of a star within the rect.
    func path(in rect: CGRect) -> Path {
        let cacheKey = self.cacheKey(rect: rect)
        if let cgPath = Self.cache.object(forKey: cacheKey) {
            return Path(cgPath)
        }

        let cgPath = Star(
            numberOfVertices: self.configuration.numberOfVertices,
            vertexSize: self.configuration.vertexSize,
            cornerRadiusSize: self.configuration.cornerRadiusSize)
            .cgPath(rect: rect)

        Self.cache.setObject(cgPath, forKey: cacheKey)

        return Path(cgPath)
    }

    // MARK: - Private functions
    private func cacheKey(rect: CGRect) -> NSString {
        return NSString(string: "\(self.configuration.description)_\(rect)")
    }
}
