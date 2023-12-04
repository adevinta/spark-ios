//
//  StarShape.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 04.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct StarShape: Shape {
    // MARK: - Private variables
    private static let cache: NSCache<NSString, CGPath> = .init()

    private let configuration: StarConfiguration

    // MARK: - Initializer
    init(configuration: StarConfiguration) {
        self.configuration = configuration
    }

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

    private func cacheKey(rect: CGRect) -> NSString {
        return NSString(string: "\(self.configuration.description)_\(rect)")
    }
}
