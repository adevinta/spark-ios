//
//  ProgressBarRectangleModifier.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

typealias ProgressBarRectangle = RoundedRectangle

/// View extension only for the ProgressBar component
extension View {

    /// Add progressBar component width into an rounded rectange
    /// - Parameters:
    ///   - ratio: ratio of the parent view width.
    ///   - viewModel: viewModel use to check if the ratio is valid. If not, the frame is 9
    func width(
        from ratio: CGFloat,
        viewModel: ProgressBarValueViewModel
    ) -> some View {
        self.if(viewModel.isValidIndicatorValue(ratio)) { view in
            GeometryReader { reader in
                view.frame(width: ratio * reader.size.width)
            }
        }
    }
}
