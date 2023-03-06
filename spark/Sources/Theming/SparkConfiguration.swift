//
//  SparkConfiguration.swift
//  Spark
//
//  Created by robin.lemaire on 02/03/2023.
//

import SparkCore
import Foundation
import UIKit

public struct SparkConfiguration: Configuration {

    // MARK: - Subclass

    private class Class {}

    // MARK: - static func

    public static func load() {
        Bundle(for: Class.self).registerAllFonts()
    }
}
