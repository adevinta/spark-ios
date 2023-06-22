//
//  SwitchVariant+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 15/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension SwitchVariant: Equatable {

    public static func == (lhs: SwitchVariant, rhs: SwitchVariant) -> Bool {
        return lhs.onImage == rhs.onImage &&
        lhs.offImage == rhs.offImage &&
        lhs.onUIImage == rhs.onUIImage &&
        lhs.offUIImage == rhs.offUIImage
    }
}
