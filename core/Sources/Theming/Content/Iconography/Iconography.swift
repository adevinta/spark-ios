//
//  Iconography.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 26.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

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
