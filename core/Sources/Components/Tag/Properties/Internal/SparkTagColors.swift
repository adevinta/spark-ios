//
//  SparkTagColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol SparkTagColorables {
    var backgroundColor: ColorToken { get }
    var borderColor: ColorToken? { get }
    var foregroundColor: ColorToken { get }
}

struct SparkTagColors: SparkTagColorables {
    let backgroundColor: ColorToken
    let borderColor: ColorToken?
    let foregroundColor: ColorToken
}
