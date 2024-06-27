//
//  EnviromentValues.swift
//  SparkDemo
//
//  Created by alican.aycil on 23.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

struct NavigationControllerKey: EnvironmentKey {
    static let defaultValue: UINavigationController? = nil
}

extension EnvironmentValues {
    var navigationController: NavigationControllerKey.Value {
        get {
            return self[NavigationControllerKey.self]
        }
        set {
            self[NavigationControllerKey.self] = newValue
        }
    }
}
