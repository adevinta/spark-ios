//
//  ButtonColors.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol ButtonColors {
    var textColor: any ColorToken { get }
    var backgroundColor: any ColorToken { get }
    var pressedBackgroundColor: any ColorToken { get }
    var borderColor: any ColorToken { get }
    var pressedBorderColor: any ColorToken { get }
}

/// All Button Colors from a theme, variant and intent colors
struct ButtonColorsDefault: ButtonColors {

    // MARK: - Properties

    let textColor: any ColorToken
    let backgroundColor: any ColorToken
    let pressedBackgroundColor: any ColorToken
    let borderColor: any ColorToken
    let pressedBorderColor: any ColorToken
}
