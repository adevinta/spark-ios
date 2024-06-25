//
//  SliderGetCornerRadiiUseCase.swift
//  SparkCore
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SliderGetCornerRadiiUseCasable {
    func execute(theme: Theme,
                 shape: SliderShape) -> SliderRadii
}

final class SliderGetCornerRadiiUseCase: SliderGetCornerRadiiUseCasable {
    func execute(theme: Theme,
                 shape: SliderShape) -> SliderRadii {
        let radius: CGFloat
        switch shape {
        case .rounded:
            radius = theme.border.radius.small
        case .square:
            radius = theme.border.radius.none
        }
        return SliderRadii(trackRadius: radius, indicatorRadius: radius)
    }
}
