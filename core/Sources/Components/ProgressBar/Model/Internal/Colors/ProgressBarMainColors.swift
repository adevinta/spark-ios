//
//  ProgressBarMainColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol ProgressBarMainColors: Hashable, Equatable {
    var trackBackgroundColorToken: any ColorToken { get }
    var indicatorBackgroundColorToken: any ColorToken { get }
}
