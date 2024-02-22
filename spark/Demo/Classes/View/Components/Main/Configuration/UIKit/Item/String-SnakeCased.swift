//
//  String-SnakeCased.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 13.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension String {
    func snakecased() -> Self {
        let pattern = "[^A-Za-z0-9_]+"
        return self.lowercased()
            .replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: pattern, with: "", options: [.regularExpression])
    }
}
