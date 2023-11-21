//
//  StarUIViewTests.swift
//  SparkCoreUnitTests
//
//  Created by michael.zimmermann on 08.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class StarUIViewTests: XCTestCase {

    var cache: CGLayerCachingGeneratedMock!
    var sut: StarUIView!

    override func setUp() {
        super.setUp()
        self.cache = CGLayerCachingGeneratedMock()
        self.sut = StarUIView(
            rating: 0.4,
            fillMode: .full,
            lineWidth: 2,
            borderColor: .red,
            fillColor: .blue,
            configuration: .init(numberOfVertices: 6, vertexSize: 0.5, cornerRadiusSize: 0.12),
            cache: self.cache)
    }

    func test_cache_name() throws {
        // When
        let key = sut.cacheKey(rect: CGRect(x: 0, y: 0, width: 100, height: 100))

        XCTAssertEqual(key, "StarUIView_6_0.0_2.0_0.5_0.12_144048128_917504_100.0")
    }
}
