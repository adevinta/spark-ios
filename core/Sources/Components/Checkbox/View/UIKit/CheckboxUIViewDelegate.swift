//
//  CheckboxUIViewDelegate.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 18.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public protocol CheckboxUIViewDelegate: AnyObject {
    func checkbox(_ checkbox: CheckboxUIView, didChangeSelection state: CheckboxSelectionState)
}
