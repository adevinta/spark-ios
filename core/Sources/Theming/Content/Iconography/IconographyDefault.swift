//
//  IconographyDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

public struct IconographyDefault: Iconography {

    // MARK: - Properties

    public let account: IconographyAccount
    public let actions: IconographyActions
    public let alert: IconographyAlert
    public let arrows: IconographyArrows
    public let calendar: IconographyCalendar
    public let categories: IconographyCategories
    public let contact: IconographyContact
    public let crm: IconographyCRM
    public let delivery: IconographyDelivery
    public let flags: IconographyFlags
    public let images: IconographyImages
    public let map: IconographyMap
    public let notifications: IconographyNotifications
    public let options: IconographyOptions
    public let others: IconographyOthers
    public let pro: IconographyPro
    public let security: IconographySecurity
    public let share: IconographyShare
    public let toggle: IconographyToggle
    public let transaction: IconographyTransaction
    public let user: IconographyUser

    // MARK: - Initialization

    public init(account: IconographyAccount,
                actions: IconographyActions,
                alert: IconographyAlert,
                arrows: IconographyArrows,
                calendar: IconographyCalendar,
                categories: IconographyCategories,
                contact: IconographyContact,
                crm: IconographyCRM,
                delivery: IconographyDelivery,
                flags: IconographyFlags,
                images: IconographyImages,
                map: IconographyMap,
                notifications: IconographyNotifications,
                options: IconographyOptions,
                others: IconographyOthers,
                pro: IconographyPro,
                security: IconographySecurity,
                share: IconographyShare,
                toggle: IconographyToggle,
                transaction: IconographyTransaction,
                user: IconographyUser) {
        self.account = account
        self.actions = actions
        self.alert = alert
        self.arrows = arrows
        self.calendar = calendar
        self.categories = categories
        self.contact = contact
        self.crm = crm
        self.delivery = delivery
        self.flags = flags
        self.images = images
        self.map = map
        self.notifications = notifications
        self.options = options
        self.others = others
        self.pro = pro
        self.security = security
        self.share = share
        self.toggle = toggle
        self.transaction = transaction
        self.user = user
    }
}

// MARK: - Style

public struct IconographyFilledDefault: IconographyFilled {

    // MARK: - Properties

    public let filled: IconographyImage

    // MARK: - Initialization

    public init(filled: IconographyImage) {
        self.filled = filled
    }
}

public struct IconographyOutlinedDefault: IconographyOutlined {

    // MARK: - Properties

    public let outlined: IconographyImage

    // MARK: - Initialization

    public init(outlined: IconographyImage) {
        self.outlined = outlined
    }
}

public struct IconographyLeftDefault: IconographyLeft {

    // MARK: - Properties

    public let left: IconographyImage

    // MARK: - Initialization

    public init(left: IconographyImage) {
        self.left = left
    }
}

public struct IconographyRightDefault: IconographyRight {

    // MARK: - Properties

    public let right: IconographyImage

    // MARK: - Initialization

    public init(right: IconographyImage) {
        self.right = right
    }
}

public struct IconographyUpDefault: IconographyUp {

    // MARK: - Properties

    public let up: IconographyImage

    // MARK: - Initialization

    public init(up: IconographyImage) {
        self.up = up
    }
}

public struct IconographyDownDefault: IconographyDown {

    // MARK: - Properties

    public let down: IconographyImage

    // MARK: - Initialization

    public init(down: IconographyImage) {
        self.down = down
    }
}

public struct IconographyVerticalDefault: IconographyVertical {

    // MARK: - Properties

    public let vertical: IconographyImage

    // MARK: - Initialization

    public init(vertical: IconographyImage) {
        self.vertical = vertical
    }
}

public struct IconographyHorizontalDefault: IconographyHorizontal {

    // MARK: - Properties

    public let horizontal: IconographyImage

    // MARK: - Initialization

    public init(horizontal: IconographyImage) {
        self.horizontal = horizontal
    }
}

// MARK: - Image

public struct IconographyImageDefault: IconographyImage {

    // MARK: - Properties

    private let imageName: String
    private let bundle: Bundle

    public var uiImage: UIImage {
        guard let uiImage = UIImage(named: self.imageName, in: self.bundle, with: nil) else {
            fatalError("Missing image asset named \(self.imageName) in bundle \(self.bundle.bundleIdentifier ?? self.bundle.description)")
        }
        return uiImage
    }
    public var swiftUIImage: Image {
        return Image(self.imageName, bundle: self.bundle)
    }

    // MARK: - Initialization

    public init(named imageName: String, in bundle: Bundle) {
        self.imageName = imageName
        self.bundle = bundle
    }
}
