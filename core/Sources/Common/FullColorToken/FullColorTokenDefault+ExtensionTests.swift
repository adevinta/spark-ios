//
//  FullColorTokenDefault+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 13/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension FullColorTokenDefault: Equatable {

    public static func == (lhs: FullColorTokenDefault, rhs: FullColorTokenDefault) -> Bool {
        return lhs.color == rhs.color && lhs.uiColor == lhs.uiColor
    }
}
