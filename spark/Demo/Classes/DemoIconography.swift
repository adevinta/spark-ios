//
//  DemoIconography.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 06.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@_spi(SI_SPI) import SparkCommon
import SwiftUI
import Spark

struct DemoIconography {
    // MARK: - Shared

    static var shared = DemoIconography()

    // MARK: - Initialize

    private init() {}

    // MARK: - Icons

    let checkmark: Icon = CheckmarkIcon()
    let close: Icon = CloseIcon()
}

protocol Icon {
      var uiImage: UIImage { get }
      var image: Image { get }
}

extension Icon {
     var image: Image {
         return Image(uiImage: self.uiImage)
     }
}

final class CheckmarkIcon: Icon {
     lazy var uiImage: UIImage = {
         return UIImage(named: "checkbox-selected")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
     }()
}

final class CloseIcon: Icon {
    lazy var uiImage: UIImage = {
        return UIImage(named: "close")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }()
}
