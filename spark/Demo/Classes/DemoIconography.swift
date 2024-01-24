//
//  DemoIconography.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 06.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SwiftUI
import SparkCore

struct DemoIconography {
    // MARK: - Shared

    static var shared = DemoIconography()

    // MARK: - Initialize

    private init() {}

    // MARK: - Icons

    var checkmark: Image {
        return Image(uiImage: DemoIconography.shared.uiCheckmark)
    }

    var close: Image {
        return Image(uiImage: DemoIconography.shared.uiClose)
    }

    lazy var uiCheckmark: UIImage = {
        return UIImage(named: "checkbox-selected")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }()

    lazy var uiClose: UIImage = {
        return UIImage(named: "close")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }()
}
