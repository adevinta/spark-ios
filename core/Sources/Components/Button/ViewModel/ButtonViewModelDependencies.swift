//
//  ButtonViewModelDependencies.swift
//  SparkCore
//
//  Created by robin.lemaire on 03/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ButtonViewModelDependenciesProtocol {
    var getBorderUseCase: any ButtonGetBorderUseCaseable { get }
    var getColorsUseCase: any ButtonGetColorsUseCaseable { get }
    var getContentUseCase: any ButtonGetContentUseCaseable { get }
    var getCurrentColorsUseCase: any ButtonGetCurrentColorsUseCaseable { get }
    var getIsIconOnlyUseCase: any ButtonGetIsOnlyIconUseCaseable { get }
    var getSizesUseCase: any ButtonGetSizesUseCaseable { get }
    var getSpacingsUseCase: any ButtonGetSpacingsUseCaseable { get }
    var getStateUseCase: any ButtonGetStateUseCaseable { get }

    func makeDisplayedTitleViewModel(title: String?,
                                     attributedTitle: AttributedStringEither?) -> any DisplayedTextViewModel
}

struct ButtonViewModelDependencies: ButtonViewModelDependenciesProtocol {

    // MARK: - Properties

    let getBorderUseCase: any ButtonGetBorderUseCaseable
    let getColorsUseCase: any ButtonGetColorsUseCaseable
    let getContentUseCase: any ButtonGetContentUseCaseable
    let getCurrentColorsUseCase: any ButtonGetCurrentColorsUseCaseable
    let getIsIconOnlyUseCase: any ButtonGetIsOnlyIconUseCaseable
    let getSizesUseCase: any ButtonGetSizesUseCaseable
    let getSpacingsUseCase: any ButtonGetSpacingsUseCaseable
    let getStateUseCase: any ButtonGetStateUseCaseable

    // MARK: - Initialization

    init(
        getBorderUseCase: some ButtonGetBorderUseCaseable = ButtonGetBorderUseCase(),
        getColorsUseCase: some ButtonGetColorsUseCaseable = ButtonGetColorsUseCase(),
        getContentUseCase: some ButtonGetContentUseCaseable = ButtonGetContentUseCase(),
        getCurrentColorsUseCase: some ButtonGetCurrentColorsUseCaseable = ButtonGetCurrentColorsUseCase(),
        getIsIconOnlyUseCase: some ButtonGetIsOnlyIconUseCaseable = ButtonGetIsOnlyIconUseCase(),
        getSizesUseCase: some ButtonGetSizesUseCaseable = ButtonGetSizesUseCase(),
        getSpacingsUseCase: some ButtonGetSpacingsUseCaseable = ButtonGetSpacingsUseCase(),
        getStateUseCase: some ButtonGetStateUseCaseable = ButtonGetStateUseCase()
    ) {
        self.getBorderUseCase = getBorderUseCase
        self.getColorsUseCase = getColorsUseCase
        self.getContentUseCase = getContentUseCase
        self.getCurrentColorsUseCase = getCurrentColorsUseCase
        self.getIsIconOnlyUseCase = getIsIconOnlyUseCase
        self.getSizesUseCase = getSizesUseCase
        self.getSpacingsUseCase = getSpacingsUseCase
        self.getStateUseCase = getStateUseCase
    }

    // MARK: - Maker

    func makeDisplayedTitleViewModel(
        title: String?,
        attributedTitle: AttributedStringEither?
    ) -> any DisplayedTextViewModel {
        return DisplayedTextViewModelDefault(
            text: title,
            attributedText: attributedTitle
        )
    }
}
