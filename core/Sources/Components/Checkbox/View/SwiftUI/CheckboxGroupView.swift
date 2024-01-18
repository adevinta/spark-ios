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
    private var title: String?
    private var checkedImage: UIImage
    @Binding private var items: [any CheckboxGroupItemProtocol]

    private var theme: Theme
    private var intent: CheckboxIntent
    private var layout: CheckboxGroupLayout
    private var alignment: CheckboxAlignment
    private var accessibilityIdentifierPrefix: String

    @ScaledMetric private var spacingSmall: CGFloat
    @ScaledMetric private var spacingLarge: CGFloat
    @ScaledMetric private var checkboxSelectedBorderWidth: CGFloat
    
    @State private var viewWidth: CGFloat = 0
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
    public init(
        title: String? = nil,
        checkedImage: UIImage,
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        alignment: CheckboxAlignment,
        theme: Theme,
        intent: CheckboxIntent = .main,
        accessibilityIdentifierPrefix: String
    ) {
        self.title = title
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
            if let title = self.title, !title.isEmpty  {
                Text(title)
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
            let checkboxWidth = self.calculateSingleCheckboxWidth(string: item.title.wrappedValue, alignment: self.alignment)
            self.checkBoxView(item: item)
                .if(checkboxWidth > maxWidth ?? 0) { view in
                    view
                        .frame(width: maxWidth)
                        .fixedSize(horizontal: false, vertical: true)
                } else: { view in
                    view
                        .fixedSize()
                }
        }
    }

    private func checkBoxView(item: Binding<any CheckboxGroupItemProtocol>) -> some View {
        let identifier = "\(self.accessibilityIdentifierPrefix).\(item.id.wrappedValue)"
        return CheckboxView(
            text: item.title.wrappedValue,
            checkedImage: self.checkedImage,
            alignment: self.alignment,
            theme: self.theme,
            intent: self.intent,
            isEnabled: item.isEnabled.wrappedValue,
            selectionState: item.selectionState
        )
        .accessibilityIdentifier(identifier)
    }
}



// MARK: - Helpers
extension CheckboxGroupView {
    private func calculateSingleCheckboxWidth(string: String?, alignment: CheckboxAlignment) -> CGFloat {
        let font: UIFont = self.theme.typography.body1.uiFont
        let textWidth: CGFloat = string?.widthOfString(usingFont: font) ?? 0
        let spacing: CGFloat = CheckboxGetSpacingUseCase().execute(layoutSpacing: self.theme.layout.spacing, alignment: alignment)
        let checkboxControlSize: CGFloat = CheckboxView.Constants.checkboxSize
        let width: CGFloat = checkboxControlSize + spacing + textWidth
        return width
    }
}

private extension String {
   func widthOfString(usingFont font: UIFont?) -> CGFloat {
       if let font = font {
           let fontAttributes = [NSAttributedString.Key.font: font]
           let size = self.size(withAttributes: fontAttributes)
           return size.width
       }
       return 0
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
