//
//  SliderHandle.swift
//  SparkCore
//
//  Created by louis.borlee on 13/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct SliderHandle: View {

    @ObservedObject var viewModel: SliderHandleViewModel

    @Binding var isEditing: Bool

    init(viewModel: SliderHandleViewModel,
         isEditing: Binding<Bool>) {
        self.viewModel = viewModel
        _isEditing = isEditing
    }

    var body: some View {
        ZStack(alignment: .center) {
            if self.isEditing {
                self.activeIndicatorStroke()
                self.activeIndicatorHalo()
            }
            Circle()
                .fill()
                .foregroundColor(self.viewModel.color.color)
                .frame(width: SliderConstants.handleSize.width, height: SliderConstants.handleSize.height)
        }
    }

    @ViewBuilder
    private func activeIndicatorStroke() -> some View {
        Circle()
            .strokeBorder(self.viewModel.color.color, lineWidth: 1.0)
            .frame(width: SliderConstants.activeIndicatorSize.width, height: SliderConstants.activeIndicatorSize.height)
    }

    @ViewBuilder
    private func activeIndicatorHalo() -> some View {
        Circle()
            .fill(self.viewModel.activeIndicatorColor)
            .frame(width: SliderConstants.activeIndicatorSize.width - 2, height: SliderConstants.activeIndicatorSize.height - 2)
    }
}
