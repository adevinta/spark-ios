//
//  SparkIconography.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//

import SparkCore
import Foundation

struct SparkIconography: Iconography {

    // MARK: - Properties

    let account: IconographyAccount = IconographyAccountDefault(bank: FillAndOutlined(named: "bank"),
                                                                holiday: FillAndOutlined(named: "holiday"))
}

// MARK: - Style

private struct FillAndOutlined: IconographyFill & IconographyOutlined {

    // MARK: - Subclass

    private class Class {}

    // MARK: - Properties

    var fill: IconographyImage
    var outlined: IconographyImage

    // MARK: - Initialization

    init(named: String) {
        let bundle = Bundle(for: Class.self)

        self.fill = IconographyImageDefault(named: named + "-fill", in: bundle)
        self.outlined = IconographyImageDefault(named: named + "-outlined", in: bundle)
    }
}
