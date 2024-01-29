//
//  ProgressTrackerUIControl.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 29.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import UIKit

public final class ProgressTrackerUIControl: UIControl {

    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    public var intent: ProgressTrackerIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    public var variant: ProgressTrackerVariant {
        didSet {

        }
    }

    public var size: ProgressTrackerSize {
        didSet {

        }
    }

    public var interactionState: ProgressInteractionState {
        didSet {

        }
    }

    public var allowsContinuousInteraction: Bool {
        set {
            self.interactionState = newValue ? .continuous : .discrete
        }
        get {
            return self.interactionState == .continuous && self.isUserInteractionEnabled
        }
    }


    private let viewModel: ProgressTrackerViewModel

    public init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize = .medium,
        orientation: ProgressTrackerOrientation = .horizontal
    ) {
        let viewModel = ProgressTrackerViewModel(
            theme: theme,
            intent: intent,
            orientation: orientation)

    }
}
