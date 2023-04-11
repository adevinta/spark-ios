//
//  SparkIconography.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 06.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore

struct SparkIconography: Iconography {
    private(set) var checkmark: Image = {
        SparkIconAsset.checkboxSelected.swiftUIImage
    }()
}
