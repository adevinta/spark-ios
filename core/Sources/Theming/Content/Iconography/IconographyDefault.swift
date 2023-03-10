//
//  IconographyDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//

import UIKit
import SwiftUI

public struct IconographyDefault: Iconography {

    // MARK: - Properties

    public let account: IconographyAccount
    public let actions: IconographyActions
    public let arrows: IconographyArrows
    public let calendar: IconographyCalendar
    public let contact: IconographyContact
    public let categories: IconographyCategories
    public let flags: IconographyFlags
    public let images: IconographyImages
    public let alert: IconographyAlert
    public let security: IconographySecurity
    public let delivery: IconographyDelivery
    public let map: IconographyMap
    public let others: IconographyOthers
    public let options: IconographyOptions
    public let transaction: IconographyTransaction
    public let crm: IconographyCRM
    public let pro: IconographyPro
    public let share: IconographyShare
    public let toggle: IconographyToggle
    public let user: IconographyUser

    // MARK: - Initialization

    public init(account: IconographyAccount,
                actions: IconographyActions,
                arrows: IconographyArrows,
                calendar: IconographyCalendar,
                contact: IconographyContact,
                categories: IconographyCategories,
                flags: IconographyFlags,
                images: IconographyImages,
                alert: IconographyAlert,
                security: IconographySecurity,
                delivery: IconographyDelivery,
                map: IconographyMap,
                others: IconographyOthers,
                options: IconographyOptions,
                transaction: IconographyTransaction,
                crm: IconographyCRM,
                pro: IconographyPro,
                share: IconographyShare,
                toggle: IconographyToggle,
                user: IconographyUser) {
        self.account = account
        self.actions = actions
        self.arrows = arrows
        self.calendar = calendar
        self.contact = contact
        self.categories = categories
        self.flags = flags
        self.images = images
        self.alert = alert
        self.security = security
        self.delivery = delivery
        self.map = map
        self.others = others
        self.options = options
        self.transaction = transaction
        self.crm = crm
        self.pro = pro
        self.share = share
        self.toggle = toggle
        self.user = user
    }
}

// MARK: - Style

public struct IconographyFillDefault: IconographyFill {

    // MARK: - Properties

    public let fill: IconographyImage

    // MARK: - Initialization

    public init(fill: IconographyImage) {
        self.fill = fill
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
    private let bundle: Bundle?

    public var uiImage: UIImage? {
        return UIImage(named: self.imageName, in: self.bundle, with: nil)
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
