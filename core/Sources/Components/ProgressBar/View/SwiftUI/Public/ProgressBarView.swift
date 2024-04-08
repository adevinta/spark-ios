//
//  ProgressBarView.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct ProgressBarView: View {
    
    // MARK: - Type alias
    
    private typealias AccessibilityIdentifier = ProgressBarAccessibilityIdentifier
    private typealias Constants = ProgressBarConstants
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ProgressBarViewModel
    
    private let value: CGFloat
    
    // MARK: - Initialization
    
    /// Initialize a new progress bar view
    /// - Parameters:
    ///   - theme: The spark theme of the progress bar.
    ///   - intent: The intent of the progress bar.
    ///   - shape: The shape of the progress bar.
    ///   - value: The indicator value of the progress bar. Value **MUST** be into 0 (for 0 %) and 1 (for 100%)
    public init(
        theme: any Theme,
        intent: ProgressBarIntent,
        shape: ProgressBarShape,
        value: CGFloat
    ) {
        self.viewModel = .init(
            for: .swiftUI,
            theme: theme,
            intent: intent,
            shape: shape
        )
        self.value = value
    }
    
    // MARK: - View
    
    public var body: some View {
        ProgressBarContentView(
            trackCornerRadius: self.viewModel.cornerRadius,
            trackBackgroundColor: self.viewModel.colors?.trackBackgroundColorToken,
            indicatorView: {
                RoundedRectangle(cornerRadius: self.viewModel.cornerRadius ?? 0)
                    .fill(self.viewModel.colors?.indicatorBackgroundColorToken)
                    .if(self.viewModel.isValidIndicatorValue(self.value)) { view in
                        view.proportionalWidth(from: self.value)
                    }
            }
        )
        .accessibilityValue("\(Int(round(self.value * 100)))%")
    }
}
