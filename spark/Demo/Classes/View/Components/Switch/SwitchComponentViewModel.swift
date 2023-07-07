//
//  SwitchComponentViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark

struct SwitchComponentViewModel {

    // MARK: - Properties

    let text: String = "Text"
    private let multilineText: String = "This is an example of a multi-line text which is very long and in which the user should read all the information."
    let onImageNamed: String = "check"
    let offImageNamed: String = "close"

    // MARK: - Methods

    func text(isMultilineText: Bool) -> String {
        return isMultilineText ? self.multilineText : self.text
    }
}
