//
//  IconographyProDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyProDefault: IconographyPro {

    // MARK: - Properties

    public let cursor: IconographyFilled & IconographyOutlined
    public let download: IconographyFilled & IconographyOutlined
    public let graph: IconographyFilled & IconographyOutlined
    public let rocket: IconographyFilled & IconographyOutlined

    // MARK: - Init

    public init(cursor: IconographyFilled & IconographyOutlined,
                download: IconographyFilled & IconographyOutlined,
                graph: IconographyFilled & IconographyOutlined,
                rocket: IconographyFilled & IconographyOutlined) {
        self.cursor = cursor
        self.download = download
        self.graph = graph
        self.rocket = rocket
    }
}
