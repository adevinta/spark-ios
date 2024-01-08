//
//  ColorsDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

public struct ColorsDefault: Colors {

    // MARK: - Properties

    public let main: any ColorsMain
    public let support: any ColorsSupport
    public let accent: any ColorsAccent
    public let basic: any ColorsBasic
    public let base: any ColorsBase
    public let feedback: any ColorsFeedback
    public let states: any ColorsStates

    // MARK: - Initialization

    public init(main: some ColorsMain,
                support: some ColorsSupport,
                accent: some ColorsAccent,
                basic: some ColorsBasic,
                base: some ColorsBase,
                feedback: some ColorsFeedback,
                states: some ColorsStates) {
        self.main = main
        self.support = support
        self.accent = accent
        self.basic = basic
        self.base = base
        self.feedback = feedback
        self.states = states
    }
}

// MARK: - Token

public struct ColorTokenDefault: ColorToken {

    // MARK: - Properties

    private let colorName: String
    private let bundle: Bundle

    public var uiColor: UIColor {
        guard let uiColor = UIColor(named: self.colorName, in: self.bundle, compatibleWith: nil) else {
            fatalError("Missing color asset named \(self.colorName) in bundle \(self.bundle.bundleIdentifier ?? self.bundle.description)")
        }
        return uiColor
    }
    public var color: Color {
        return Color(self.colorName, bundle: self.bundle)
    }

    // MARK: - Initialization

    public init(named colorName: String, in bundle: Bundle) {
        self.colorName = colorName
        self.bundle = bundle
    }
}
