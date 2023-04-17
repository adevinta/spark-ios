//
//  CheckboxGroupItemProtocol.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public protocol CheckboxGroupItemProtocol: Hashable {
    var title: String { get set }
    var id: String { get set }

    var selectionState: CheckboxSelectionState { get set }
    var state: SelectButtonState { get set }
}
