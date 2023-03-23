//
//  DimsDefault.swift
//  Spark
//
//  Created by louis.borlee on 22/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public struct DimsDefault: Dims {

    // MARK: - Properties

    public let dim1: CGFloat
    public let dim2: CGFloat
    public let dim3: CGFloat
    public let dim4: CGFloat
    public let dim5: CGFloat

    // MARK: - Init

    public init(dim1: CGFloat,
                dim2: CGFloat,
                dim3: CGFloat,
                dim4: CGFloat,
                dim5: CGFloat) {
        self.dim1 = dim1
        self.dim2 = dim2
        self.dim3 = dim3
        self.dim4 = dim4
        self.dim5 = dim5
    }
}
