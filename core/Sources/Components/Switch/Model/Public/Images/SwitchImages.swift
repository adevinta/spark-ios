//
//  SwitchImages.swift
//  SparkCore
//
//  Created by robin.lemaire on 03/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct SwitchImages: Equatable {

    // MARK: - Properties

    public let on: Image
    public let off: Image

    // MARK: - Initialization

    public init(on: Image, off: Image) {
        self.on = on
        self.off = off
    }
}
