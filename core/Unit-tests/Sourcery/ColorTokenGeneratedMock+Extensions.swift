//
//  File.swift
//  SparkCoreTests
//
//  Created by louis.borlee on 29/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

extension ColorTokenGeneratedMock {
    static func == (lhs: ColorTokenGeneratedMock, rhs: ColorTokenGeneratedMock) -> Bool {
        return lhs === rhs
    }
}

extension ColorTokenGeneratedMock {
  convenience init(uiColor: UIColor) {
    self.init()
    self.uiColor = uiColor
  }
}
