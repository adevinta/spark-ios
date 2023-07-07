//
//  SwitchUIImages+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 03/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension SwitchUIImages: Equatable {

    public static func == (lhs: SwitchUIImages, rhs: SwitchUIImages) -> Bool {
        return lhs.on == rhs.on && lhs.off == rhs.off
    }
}
