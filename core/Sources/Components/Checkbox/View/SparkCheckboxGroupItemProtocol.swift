//
//  SparkCheckboxGroupItemProtocol.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public protocol SparkCheckboxGroupItemProtocol: Hashable {
    var title: String { get set }
    var id: String { get set }

    var selectionState: SparkCheckboxSelectionState { get set }
    var state: SparkSelectButtonState { get set }
}
