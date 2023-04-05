//
//  SparkCheckboxViewModel.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 05.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public final class SparkCheckboxViewModel: ObservableObject {
    public var text: String
    @Published public var selectionState: SparkCheckboxSelectionState

    public init(
        text: String,
        selectionState: SparkCheckboxSelectionState
    ) {
        self.text = text
        self.selectionState = selectionState
    }
}
