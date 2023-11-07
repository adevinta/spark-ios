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
    @available(*, deprecated)
    private var title: String

    private var checkedImage: UIImage
    @Binding private var items: [any CheckboxGroupItemProtocol]

    private var theme: Theme
    private var intent: CheckboxIntent
    private var layout: CheckboxGroupLayout
    private var alignment: CheckboxAlignment
    private var accessibilityIdentifierPrefix: String
    
    @available(*, deprecated)
    @ScaledMetric private var spacingSmall: CGFloat
    @ScaledMetric private var spacingLarge: CGFloat
    @ScaledMetric private var checkboxSelectedBorderWidth: CGFloat

    @State private var maxCheckboxHeight: CGFloat = .zero
    @State private var viewWidth: CGFloat = .zero
    @State private var isScrollableHStack: Bool = true
    private var itemContents: [String] {
        return self.items.map { $0.id + ($0.title ?? "") }
    }

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
    @available(*, deprecated)
    public init(
        title: String? = nil,
        checkedImage: UIImage,
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        checkboxAlignment: CheckboxAlignment,
        theme: Theme,
        intent: CheckboxIntent = .main,
        accessibilityIdentifierPrefix: String
    ) {
        self.title = title ?? ""
        self.checkedImage = checkedImage
        self._items = items
        self.layout = layout
        self.alignment = checkboxAlignment
        self.theme = theme
        self.intent = intent
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix

        self._spacingSmall = .init(wrappedValue: theme.layout.spacing.small)
        self._spacingLarge = .init(wrappedValue: theme.layout.spacing.large)
        self._checkboxSelectedBorderWidth = .init(wrappedValue: CheckboxView.Constants.checkboxSelectedBorderWidth)
    }

    /// Initialize a group of one or multiple checkboxes.
    /// - Parameters:
    ///   - checkedImage: The tick-checkbox image for checked-state.
    ///   - items: An array containing of multiple `CheckboxGroupItemProtocol`. Each array item is used to render a single checkbox.
    ///   - layout: The layout of the group can be horizontal or vertical.
    ///   - alignment: The checkbox is positioned on the leading or trailing edge of the view.
    ///   - theme: The Spark-Theme.
    ///   - accessibilityIdentifierPrefix: All checkbox-views are prefixed by this identifier followed by the `CheckboxGroupItemProtocol`-identifier.
    public init(
        checkedImage: UIImage,
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        alignment: CheckboxAlignment,
        theme: Theme,
        intent: CheckboxIntent = .main,
        accessibilityIdentifierPrefix: String
    ) {
        self.title = ""
        self.checkedImage = checkedImage
        self._items = items
        self.layout = layout
        self.alignment = alignment
        self.theme = theme
        self.intent = intent
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix

        self._spacingSmall = .init(wrappedValue: theme.layout.spacing.small)
        self._spacingLarge = .init(wrappedValue: theme.layout.spacing.large)
        self._checkboxSelectedBorderWidth = .init(wrappedValue: CheckboxView.Constants.checkboxSelectedBorderWidth)
    }

    // MARK: - Body

    /// Returns the rendered checkbox group view.
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !self.title.isEmpty {
                Text(self.title)
                    .foregroundColor(self.theme.colors.base.onSurface.color)
                    .font(self.theme.typography.subhead.font)
                    .padding(.bottom, self.spacingLarge - self.spacingSmall)
            }
            switch self.layout {
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
    }

    private func makeHStackView() -> some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: self.spacingLarge) {
                self.makeContentView(maxWidth: self.viewWidth)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(minHeight: self.maxCheckboxHeight, alignment: .top)
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
            HStack(alignment: .top, spacing: self.spacingLarge) {
                self.makeContentView()
            }
            .fixedSize(horizontal: true, vertical: false)
        } else: { view in
            view
        }
    }

    private func makeVStackView() -> some View {
        VStack(alignment: .leading, spacing: self.spacingLarge) {
            self.makeContentView()
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private func makeContentView(maxWidth: CGFloat? = nil) -> some View {
        var chekboxHeights: [CGFloat] = []
        return ForEach(self.$items, id: \.id) { item in
            let identifier = "\(self.accessibilityIdentifierPrefix).\(item.id.wrappedValue)"
            let attributeTextString: String = item.attributedTitle.wrappedValue?.string ?? ""
            CheckboxView(
                text: item.title.wrappedValue ?? attributeTextString,
                checkedImage: self.checkedImage,
                alignment: self.alignment,
                theme: self.theme,
                intent: self.intent,
                isEnabled: item.isEnabled.wrappedValue,
                selectionState: item.selectionState
            )
            .if(maxWidth != nil, content: {
                $0.frame(maxWidth: maxWidth, alignment: .top)
            })
            .accessibilityIdentifier(identifier)
            .if(layout == .horizontal, content: {
                $0.overlay(
                    GeometryReader { geo in
                        Color.clear.preference(key: HeightPreferenceKey.self, value: geo.size.height)
                    }
                )
                .onPreferenceChange(HeightPreferenceKey.self) {
                    let checkboxHeight = $0 ?? .zero
                    chekboxHeights.append(checkboxHeight)
                    self.maxCheckboxHeight = chekboxHeights.max() ?? .zero
                }
            })
        }
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

struct ScrollViewWidthPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}
