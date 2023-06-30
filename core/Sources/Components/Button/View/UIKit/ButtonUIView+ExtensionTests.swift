//
//  ButtonUIView+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 04/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

extension ButtonUIView {

    func testPressedAction() {
        self.viewModel.pressedAction()
    }
}
