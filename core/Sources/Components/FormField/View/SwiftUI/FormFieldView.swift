//
//  FormFieldView.swift
//  SparkCore
//
//  Created by alican.aycil on 18.03.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

public struct FormFieldView<Component: View>: View {

    private let component: Component
    @ObservedObject private var viewModel: FormFieldViewModel
    @ScaledMetric private var spacing: CGFloat

    /// Initialize a new checkbox UIKit-view.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - title: The formfield title.
    ///   - description: The formfield helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    ///   - isEnabled: The formfield's component isEnabled value.
    ///   - isSelected: The formfield's component isSelected state.
    public init(
        theme: Theme,
        @ViewBuilder component: @escaping () -> Component,
        feedbackState: FormFieldFeedbackState = .default,
        title: String? = nil,
        description: String? = nil,
        isTitleRequired: Bool = false,
        isEnabled: Bool = true,
        isSelected: Bool = false
    ) {
        let attributedTitle: AttributedString? = title.map(AttributedString.init)
        let attributedDescription: AttributedString? = description.map(AttributedString.init)
        self.init(
            theme: theme,
            component: component,
            feedbackState: feedbackState,
            attributedTitle: attributedTitle,
            attributedDescription: attributedDescription,
            isTitleRequired: isTitleRequired,
            isEnabled: isEnabled,
            isSelected: isSelected
        )
    }

    /// Initialize a new checkbox UIKit-view.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - attributedTitle: The formfield attributedTitle.
    ///   - attributedDescription: The formfield attributed helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    ///   - isEnabled: The formfield's component isEnabled value.
    ///   - isSelected: The formfield's component isSelected state.
    public init(
        theme: Theme,
        @ViewBuilder component: @escaping () -> Component,
        feedbackState: FormFieldFeedbackState = .default,
        attributedTitle: AttributedString? = nil,
        attributedDescription: AttributedString? = nil,
        isTitleRequired: Bool = false,
        isEnabled: Bool = true,
        isSelected: Bool = false
    ) {
        let viewModel = FormFieldViewModel(
            theme: theme,
            feedbackState: feedbackState,
            title: .right(attributedTitle),
            description: .right(attributedDescription),
            isTitleRequired: isTitleRequired
        )

        self.viewModel = viewModel
        self._spacing = ScaledMetric(wrappedValue: viewModel.spacing)
        self.component = component()


//        self.isEnabled = isEnabled
//        self.isSelected = isSelected
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: self.spacing) {

            if let title = self.viewModel.title?.rightValue {
                Text(title)
                    .font(self.viewModel.titleFont.font)
                    .foregroundStyle(self.viewModel.titleColor.color)
            }
            
            self.component

            if let description = self.viewModel.description?.rightValue {
                Text(description)
                    .font(self.viewModel.descriptionFont.font)
                    .foregroundStyle(self.viewModel.descriptionColor.color)
            }
        }
    }


}
