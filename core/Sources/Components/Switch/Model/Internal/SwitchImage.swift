//
//  SwitchImage.swift
//  SparkCore
//
//  Created by robin.lemaire on 13/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

// sourcery: AutoMockable
protocol SwitchImageable {
    var image: Image? { get }
    var uiImage: UIImage? { get }
}

struct SwitchImage: SwitchImageable {

    // MARK: - Properties

    let image: Image?
    let uiImage: UIImage?
}
