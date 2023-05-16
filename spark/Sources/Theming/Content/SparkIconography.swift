//
//  SparkIconography.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 06.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SwiftUI
import SparkCore

struct SparkIconography: Iconography {
    private(set) var checkmark: ImageToken = {
        let image = SparkIconAsset.checkboxSelected.image.withRenderingMode(.alwaysTemplate)
        return ImageTokenDefault(uiImage: image)
    }()
}
