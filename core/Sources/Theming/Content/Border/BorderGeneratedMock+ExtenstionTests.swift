//
//  BorderGeneratedMock+ExtenstionTests.swift
//  SparkCore
//
//  Created by alex.vecherov on 20.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension BorderGeneratedMock {

    // MARK: - Methods

    static func mocked() -> BorderGeneratedMock {
        let borderGeneratedMock = BorderGeneratedMock()

        borderGeneratedMock.width = BorderWidthGeneratedMock()
        borderGeneratedMock.radius = BorderRadiusGeneratedMock()
        
        return borderGeneratedMock
    }
}
