//
//  BorderDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/02/2023.
//

public struct BorderDefault: Border {

    // MARK: - Properties

    public let width: BorderWidth
    public let radius: BorderRadius

    // MARK: - Initialization

    public init(width: BorderWidth, radius: BorderRadius) {
        self.width = width
        self.radius = radius
    }
}
