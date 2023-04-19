//
//  Theme.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI

// sourcery: AutoMockable
public protocol Theme {
    var border: SparkCore.Border { get }
    var colors: SparkCore.Colors { get }
    var elevation: SparkCore.Elevation { get }
    var layout: SparkCore.Layout { get }
    var typography: SparkCore.Typography { get }
    var dims: SparkCore.Dims { get }
    var iconography: SparkCore.Iconography { get }
}

public protocol Iconography {
    var checkmark: ImageToken { get }
}

// sourcery: AutoMockable
public protocol ImageToken {
    var uiImage: UIImage { get }
    var image: Image { get }
}


public struct ImageTokenDefault: ImageToken {

    // MARK: - Properties

    public var uiImage: UIImage
    public var image: Image

    // MARK: - Initialization

    public init(uiImage: UIImage) {
        self.uiImage = uiImage
        self.image = Image(uiImage: uiImage)
    }
}
