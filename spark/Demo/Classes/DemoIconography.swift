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

    lazy var checkmark: UIImage = {
        return UIImage(named: "checkbox-selected")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }()

    lazy var close: UIImage = {
        return UIImage(named: "close")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }()
}
