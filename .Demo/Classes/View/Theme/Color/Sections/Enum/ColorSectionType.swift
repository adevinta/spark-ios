//
//  ColorSectionType.swift
//  SparkDemo
//
//  Created by robin.lemaire on 13/03/2023.
//

@_spi(SI_SPI) import SparkCommon
import SparkCore

enum ColorSectionType: CaseIterable {
    case main
    case support
    case accent
    case basic
    case base
    case feedback
    case states

    // MARK: - Properties

    func viewModel(for theme: Theme) -> any ColorSectionViewModelable {
        let colors = theme.colors
        switch self {
        case .main:
            return ColorSectionMainViewModel(color: colors.main)
        case .support:
            return ColorSectionSupportViewModel(color: colors.support)
        case .accent:
            return ColorSectionAccentViewModel(color: colors.accent)
        case .basic:
            return ColorSectionBasicViewModel(color: colors.basic)
        case .base:
            return ColorSectionBaseViewModel(color: colors.base)
        case .feedback:
            return ColorSectionFeedbackViewModel(color: colors.feedback)
        case .states:
            return ColorSectionStatesViewModel(color: colors.states)
        }
    }
}
