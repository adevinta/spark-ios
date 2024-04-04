//
//  CheckboxGroupView.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 06.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// The `CheckboxGroupView` renders a group containing of multiple`CheckboxView`-views. It supports a title, different layout and positioning options.
public struct CheckboxGroupView: View {

    // MARK: - Private properties

    @Binding private var items: [any CheckboxGroupItemProtocol]
    private var itemContents: [String] {
        return self.items.map { $0.id + ($0.title ?? "") }
    }
    @ObservedObject var viewModel: CheckboxGroupViewModel

    @ScaledMetric private var spacingSmall: CGFloat
    @ScaledMetric private var spacingLarge: CGFloat
    @ScaledMetric private var checkboxSelectedBorderWidth: CGFloat
    
    @State private var viewWidth: CGFloat = 0
    @State private var isScrollableHStack: Bool = true


    // MARK: - Initialization

    /// Initialize a group of one or multiple checkboxes.
    /// - Parameters:
    ///   - title: An optional group title displayed on top of the checkbox group..
    ///   - checkedImage: The tick-checkbox image for checked-state.
    ///   - items: An array containing of multiple `CheckboxGroupItemProtocol`. Each array item is used to render a single checkbox.
    ///   - layout: The layout of the group can be horizontal or vertical.
    ///   - checkboxAlignment: The checkbox is positioned on the leading or trailing edge of the view.
    ///   - theme: The Spark-Theme.
    ///   - accessibilityIdentifierPrefix: All checkbox-views are prefixed by this identifier followed by the `CheckboxGroupItemProtocol`-identifier.
    @available(*, deprecated, message: "Please use init without accessibilityIdentifierPrefix. It was gived as a static string.")
    public init(
        title: String? = nil,
        checkedImage: Image,
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        alignment: CheckboxAlignment,
        theme: Theme,
        intent: CheckboxIntent = .main,
        accessibilityIdentifierPrefix: String
    ) {
        self.init(
            title: title,
            checkedImage: checkedImage,
            items: items,
            layout: layout,
            alignment: alignment,
            theme: theme,
            intent: intent
        )
    }

    /// Initialize a group of one or multiple checkboxes.
    /// - Parameters:
    ///   - title: An optional group title displayed on top of the checkbox group..
    ///   - checkedImage: The tick-checkbox image for checked-state.
    ///   - items: An array containing of multiple `CheckboxGroupItemProtocol`. Each array item is used to render a single checkbox.
    ///   - layout: The layout of the group can be horizontal or vertical.
    ///   - checkboxAlignment: The checkbox is positioned on the leading or trailing edge of the view.
    ///   - theme: The Spark-Theme.
    public init(
        title: String? = nil,
        checkedImage: Image,
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        alignment: CheckboxAlignment,
        theme: Theme,
        intent: CheckboxIntent = .main
    ) {
        let viewModel = CheckboxGroupViewModel(
            title: title,
            checkedImage: checkedImage,
            theme: theme,
            intent: intent,
            alignment: alignment,
            layout: layout
        )
        self.viewModel = viewModel

        self._items = items
        self._spacingSmall = .init(wrappedValue: viewModel.spacing.small)
        self._spacingLarge = .init(wrappedValue: viewModel.spacing.large)
        self._checkboxSelectedBorderWidth = .init(wrappedValue: CheckboxView.Constants.checkboxSelectedBorderWidth)
    }

    // MARK: - Body

    /// Returns the rendered checkbox group view.
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let title = self.viewModel.title, !title.isEmpty  {
                Text(title)
                    .foregroundColor(self.viewModel.titleColor.color)
                    .font(self.viewModel.titleFont.font)
                    .padding(.bottom, self.spacingLarge - self.spacingSmall)
                    .accessibilityIdentifier(CheckboxAccessibilityIdentifier.checkboxGroupTitle)
            }
            switch self.viewModel.layout {
            case .horizontal:
                self.makeHStackView()
            case .vertical:
                self.makeVStackView()
            }
        }
        .overlay(
            GeometryReader { geo in
                Color.clear.onAppear {
                    self.viewWidth = geo.size.width
                }
            }
        )
        .onChange(of: self.itemContents) { newValue in
            self.isScrollableHStack = true
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(CheckboxAccessibilityIdentifier.checkboxGroup)
    }

    private func makeHStackView() -> some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: self.spacingLarge) {
                self.makeContentView(maxWidth: self.viewWidth)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .overlay(
                GeometryReader { geo in
                    Color.clear.preference(key: ScrollViewWidthPreferenceKey.self, value: geo.size.width)
                }
            )
            .onPreferenceChange(ScrollViewWidthPreferenceKey.self) { newValue in
                self.isScrollableHStack = self.viewWidth < newValue ?? .zero
            }
            .padding(checkboxSelectedBorderWidth)
        }
        .padding(-checkboxSelectedBorderWidth)
        .if(!self.isScrollableHStack) { _ in
            makeDefaultHStackView()
        } else: { view in
            view
        }
    }

    @ViewBuilder
    private func makeDefaultHStackView() -> some View {
        if (self.items.count < 2) {
            self.makeVStackView()
        } else {
            HStack(spacing: self.spacingLarge) {
                self.makeContentView()
            }
            .fixedSize(horizontal: true, vertical: false)
        }
    }

    private func makeVStackView() -> some View {
        VStack(alignment: .leading, spacing: self.spacingLarge) {
            self.makeContentView()
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private func makeContentView(maxWidth: CGFloat? = nil) -> some View {
        return ForEach(self.$items, id: \.id) { item in
            let checkboxWidth = self.viewModel.calculateSingleCheckboxWidth(string: item.title.wrappedValue)

            if checkboxWidth > maxWidth ?? 0 {
                self.checkBoxView(item: item)
                    .frame(width: maxWidth)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                  self.checkBoxView(item: item)
                  .fixedSize()
            }
        }
    }

    private func checkBoxView(item: Binding<any CheckboxGroupItemProtocol>) -> some View {
        return CheckboxView(
            text: item.title.wrappedValue,
            checkedImage: self.viewModel.checkedImage,
            alignment: self.viewModel.alignment,
            theme: self.viewModel.theme,
            intent: self.viewModel.intent,
            isEnabled: item.isEnabled.wrappedValue,
            selectionState: item.selectionState
        )
    }
}

// MARK: - PreferenceKeys
private struct CheckboxWidthPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

private struct ScrollViewWidthPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}
