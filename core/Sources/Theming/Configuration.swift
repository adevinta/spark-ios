//
//  Configuration.swift
//  SparkCore
//
//  Created by robin.lemaire on 02/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// Implement this protocol to load some configuration (like custom fonts) used by Spark
public protocol Configuration {

    static func load()
}
