//
//  ButtonContent.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol ButtonContent {
    var showIconImage: Bool { get }
    var isIconImageOnRight: Bool { get }
    var iconImage: ImageEither? { get }

    var showText: Bool { get }
}

struct ButtonContentDefault: ButtonContent {

    // MARK: - Properties

    let showIconImage: Bool
    let isIconImageOnRight: Bool
    let iconImage: ImageEither?

    let showText: Bool
}
