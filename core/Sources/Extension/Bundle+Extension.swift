//
//  Bundle+Extension.swift
//  Spark
//
//  Created by robin.lemaire on 02/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import UIKit

public extension Bundle {

    // MARK: - Constants

    private enum Constants {
        static let fontExtensions = ["ttf", "otf"]
    }

    // MARK: - Fonts

    /// Register all bundle fonts  (.ttf or .otf) to be used by Spark
    func registerAllFonts() {
        // Get all custom fonts on bundle
        let fontURLs = Constants.fontExtensions.compactMap { fontExtension in
            self.urls(forResourcesWithExtension: fontExtension, subdirectory: nil)
        }
            .flatMap {
                $0
            }
            .map {
                $0 as CFURL
            }

        // Try to register all customs fonts
        fontURLs.forEach {
            guard let fontDataProvider = CGDataProvider(url: $0),
                  let font = CGFont(fontDataProvider) else {
                return
            }

            var error: Unmanaged<CFError>?
            CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }
}
