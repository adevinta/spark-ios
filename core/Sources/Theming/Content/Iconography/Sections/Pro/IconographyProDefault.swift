//
//  IconographyProDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

struct IconographyProDefault: IconographyPro {

    // MARK: - Properties

    public let cursor: IconographyFill & IconographyOutlined
    public let download: IconographyFill & IconographyOutlined
    public let graph: IconographyFill & IconographyOutlined
    public let rocket: IconographyFill & IconographyOutlined

    // MARK: - Init

    public init(cursor: IconographyFill & IconographyOutlined,
                download: IconographyFill & IconographyOutlined,
                graph: IconographyFill & IconographyOutlined,
                rocket: IconographyFill & IconographyOutlined) {
        self.cursor = cursor
        self.download = download
        self.graph = graph
        self.rocket = rocket
    }
}
