//
//  ColorToken+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by louis.borlee on 13/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore

extension ColorToken {
    var isClear: Bool {
        return self.color == .clear && self.uiColor == .clear
    }
}
