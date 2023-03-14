//
//  IconographySectionType.swift
//  SparkDemo
//
//  Created by robin.lemaire on 13/03/2023.
//

import SparkCore

enum IconographySectionType: CaseIterable {
    case account
    case actions
    case alert
    case arrows
    case calendar
    case categories
    case contact
    case crm
    case delivery
    case flags
    case images
    case map
    case notifications
    case options
    case others
    case pro
    case security
    case share
    case toggle
    case transaction
    case user

    // MARK: - Properties

    var viewModel: any IconographySectionViewModelable {
        let iconography = CurrentTheme.part.iconography
        switch self {
        case .account:
            return IconographySectionAccountViewModel(iconography: iconography.account)
        case .actions:
            return IconographySectionActionsViewModel(iconography: iconography.actions)
        case .alert:
            return IconographySectionAlertViewModel(iconography: iconography.alert)
        case .arrows:
            return IconographySectionArrowsViewModel(iconography: iconography.arrows)
        case .calendar:
            return IconographySectionCalendarViewModel(iconography: iconography.calendar)
        case .categories:
            return IconographySectionCategoriesViewModel(iconography: iconography.categories)
        case .contact:
            return IconographySectionContactViewModel(iconography: iconography.contact)
        case .crm:
            return IconographySectionCRMViewModel(iconography: iconography.crm)
        case .delivery:
            return IconographySectionDeliveryViewModel(iconography: iconography.delivery)
        case .flags:
            return IconographySectionFlagsViewModel(iconography: iconography.flags)
        case .images:
            return IconographySectionImagesViewModel(iconography: iconography.images)
        case .map:
            return IconographySectionMapViewModel(iconography: iconography.map)
        case .notifications:
            return IconographySectionNotificationsViewModel(iconography: iconography.notifications)
        case .options:
            return IconographySectionOptionsViewModel(iconography: iconography.options)
        case .others:
            return IconographySectionOthersViewModel(iconography: iconography.others)
        case .pro:
            return IconographySectionProViewModel(iconography: iconography.pro)
        case .security:
            return IconographySectionSecurityViewModel(iconography: iconography.security)
        case .share:
            return IconographySectionShareViewModel(iconography: iconography.share)
        case .toggle:
            return IconographySectionToggleViewModel(iconography: iconography.toggle)
        case .transaction:
            return IconographySectionTransactionViewModel(iconography: iconography.transaction)
        case .user:
            return IconographySectionUserViewModel(iconography: iconography.user)
        }
    }
}
