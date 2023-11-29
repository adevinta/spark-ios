//
//  ButtonContent.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@available(*, deprecated, message: "Must be removed when ButtonUIViewDeprecated is deleted")
struct ButtonContent: Equatable {

    // MARK: - Properties

    let shouldShowIconImage: Bool
    let isIconImageTrailing: Bool
    let iconImage: ImageEither?

    let shouldShowTitle: Bool
}
