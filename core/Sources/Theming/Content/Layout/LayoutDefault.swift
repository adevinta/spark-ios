//
//  LayoutDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//

public struct LayoutDefault: Layout {

    // MARK: - Properties

    public let spacing: LayoutSpacing

    // MARK: - Initialization

    public init(spacing: LayoutSpacing) {
        self.spacing = spacing
    }
}
