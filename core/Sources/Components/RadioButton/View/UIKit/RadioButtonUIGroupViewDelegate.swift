//
//  RadioButtonUIGroupViewDelegate.swift
//  SparkCore
//
//  Created by michael.zimmermann on 14.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Delegate that receives changes of radio button ui group view
public protocol RadioButtonUIGroupViewDelegate: AnyObject {
    func radioButtonGroup<ID: Hashable & Equatable & CustomStringConvertible>(_ radioButtonGroup: some RadioButtonUIGroupView<ID>, didChangeSelection item: ID)
}
