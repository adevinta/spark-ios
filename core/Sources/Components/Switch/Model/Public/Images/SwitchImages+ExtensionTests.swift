//
//  SwitchImages+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 03/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension SwitchImages: Equatable {

    public static func == (lhs: SwitchImages, rhs: SwitchImages) -> Bool {
        return lhs.on == rhs.on && lhs.off == rhs.off
    }
}
