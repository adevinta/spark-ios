//
//  SliderViewModel.swift
//  SparkCore
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

class SliderViewModel {
    
    let getColorsUseCase: SliderGetColorsUseCasable
    let getCornerRadiiUseCase: SliderGetCornerRadiiUseCase
    let getClosestValueUseCase: SliderGetClosestValueUseCasable

    init(getColorsUseCase: SliderGetColorsUseCasable = SliderGetColorsUseCase(),
         getCornerRadiiUseCase: SliderGetCornerRadiiUseCase = SliderGetCornerRadiiUseCase(),
         getClosestValueUseCase: SliderGetClosestValueUseCasable = SliderGetClosestValueUseCase()) {
        self.getColorsUseCase = getColorsUseCase
        self.getCornerRadiiUseCase = getCornerRadiiUseCase
        self.getClosestValueUseCase = getClosestValueUseCase
    }
}

final class SingleSliderViewModel: SliderViewModel {

}

final class RangeSliderViewModel: SliderViewModel {

}
