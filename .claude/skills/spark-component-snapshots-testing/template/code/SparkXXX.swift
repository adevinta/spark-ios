//
//  SparkXXX.swift
//  SparkComponentXXX
//
//  Created by robin.lemaire on 24/02/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon

/// A xxx bar that groups related content and lets users switch views on the same page.
///
/// XXXs are used to group different but related content, allowing users to navigate views without leaving the page.
/// They always contain at least two items and one xxx is active at a time.
///
/// ## Example of usage
///
/// ### With Text
///
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State private var selection = 1
///
///     var body: some View {
///         SparkXXX(selection: self.$selection) {
///             SparkXXXItem(tag: 1, text: "First")
///             SparkXXXItem(tag: 2, text: "Second")
///             SparkXXXItem(tag: 3, text: "Third")
///         }
///         .sparkTheme(self.theme)
///         .sparkXXXIntent(.main)
///         .sparkXXXSize(.medium)
///         .sparkXXXApportionsSegmentWidthsByContent(true)
///     }
/// }
/// ```
///
/// ### With Icons
///
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State private var selection = 1
///
///     var body: some View {
///         SparkXXX(selection: self.$selection) {
///             SparkXXXItem(tag: 1, icon: Image(systemName: "house"))
///             SparkXXXItem(tag: 2, icon: Image(systemName: "star"))
///             SparkXXXItem(tag: 3, icon: Image(systemName: "person"))
///         }
///         .sparkTheme(self.theme)
///         .sparkXXXIntent(.main)
///         .sparkXXXSize(.medium)
///         .sparkXXXApportionsSegmentWidthsByContent(true)
///     }
/// }
/// ```
///
/// ### With Extra Label
///
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State private var selection = 1
///
///     var body: some View {
///         SparkXXX(selection: self.$selection) {
///             SparkXXXItem(tag: 1, text: "First", icon: Image(systemName: "house")) {
///                 Text("99+")
///             }
///             SparkXXXItem(tag: 2, text: "Second", icon: Image(systemName: "star"))
///             SparkXXXItem(tag: 3, text: "Third", icon: Image(systemName: "person"))
///         }
///         .sparkTheme(self.theme)
///         .sparkXXXIntent(.main)
///         .sparkXXXSize(.medium)
///         .sparkXXXApportionsSegmentWidthsByContent(true)
///     }
/// }
/// ```
///
/// ## EnvironmentValues
///
/// This component uses some EnvironmentValues:
/// - **theme**: ``sparkTheme(_:)`` (View extension)
/// - **intent**: ``sparkXXXIntent(_:)`` (View extension)
/// - **size**: ``sparkXXXSize(_:)`` (View extension)
/// - **apportionsSegmentWidthsByContent**: ``sparkXXXApportionsSegmentWidthsByContent(_:)`` (View extension)
///
/// > If these values are not set, default values will be applied.
///
/// > **YOU MUST PROVIDE ``sparkTheme(_:)``**
///
/// ## Accessibility
///
/// By default, VoiceOver reads in order:
/// - The xxx item label
/// - The current position (e.g., "1 of 3")
/// - The selection state
///
/// On accessibility sizes, a long press gesture will show an accessibility list view for easier navigation.
///
/// ## Rendering
///
/// ### Texts
///
/// ![XXX rendering.](xxx_texts.png)
///
/// ### Icons
///
/// ![XXX rendering.](xxx_icons.png)
///
/// ### With Extra View
///
/// ![XXX rendering.](xxx_extra_view.png)
///
/// ### All Values
///
/// ![XXX rendering.](xxx_all_values.png)
///
public struct SparkXXX<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {

    // MARK: - Properties

    @Binding private var selection: SelectionValue
    private var content: () -> Content

    @Environment(\.theme) private var theme
    @Environment(\.xxxApportionsSegmentWidthsByContent) private var apportionsSegmentWidthsByContent
    @Environment(\.xxxIntent) private var intent
    @Environment(\.xxxSize) private var size
    @Environment(\.isEnabled) private var isEnabled

    @StateObject private var viewModel = XXXViewModel()

    @State private var tags: [AnyHashable] = []

    @State private var pressedId: AnyHashable?

    @State private var showAccessibilityList = false
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    // MARK: - Initialization

    /// Creates a xxx bar to switch between multiple child views.
    ///
    /// - Parameters:
    ///   - selection: A binding to a property that determines the currently-selected xxx.
    ///   - content: A closure that produces the content of the xxx bar. Use ``SparkXXXItem`` instances to define each xxx.
    ///
    /// ## Example of usage
    ///
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State private var selection = 1
    ///
    ///     var body: some View {
    ///         SparkXXX(selection: self.$selection) {
    ///             SparkXXXItem(tag: 1, text: "First")
    ///             SparkXXXItem(tag: 2, text: "Second")
    ///             SparkXXXItem(tag: 3, text: "Third")
    ///         }
    ///         .sparkTheme(self.theme)
    ///         .sparkXXXIntent(.main)
    ///         .sparkXXXSize(.medium)
    ///         .sparkXXXApportionsSegmentWidthsByContent(true)
    ///     }
    /// }
    /// ```
    ///
    /// ## Rendering
    ///
    /// ![XXX rendering.](xxx_texts.png)
    ///
    public init(
        selection: Binding<SelectionValue>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selection = selection
        self.content = content
    }

    // MARK: - View

    public var body: some View {
        // Items
        ZStack(alignment: .bottom) {

            // Background line
            self.backgroundLine()

            self.container {

                HStack(spacing: .zero) {

                    ForEach(self.tags.indices, id: \.self) { index in

                        if let tag = self.tags[safe: index] {

                            let isSelected = self.selection == tag.base as? SelectionValue

                            ZStack(alignment: .bottomLeading) {

                                // Button
                                self.itemButton(
                                    tag: tag,
                                    index: index,
                                    isSelected: isSelected
                                )

                                // Selected item indicator line
                                Rectangle()
                                    .fill(self.viewModel.linesColors.selectedColorToken)
                                    .frame(height: isSelected ? XXXConstants.selectedLineHeight : .zero)
                                    .optionalAnimation(
                                        .easeInOut(duration: XXXConstants.animationDuration),
                                        value: isSelected
                                    )
                            }
                            .id(tag)
                        }
                    }

                    if !self.apportionsSegmentWidthsByContent {
                        Spacer(minLength: .zero)
                    }
                }
            }
        }
        .sparkSensoryFeedback(.selection, trigger: self.selection)
        .opacity(self.viewModel.dim)
        .background(
            content()
                .hidden()
                .xxxContext(.collecting)
                .onPreferenceChange(XXXTagsPreferenceKey.self) { value in
                    self.tags = value
                }
        )
        .popover(isPresented: self.$showAccessibilityList, content: {
            self.accessibilityPopoverContent()
        })
        .accessibilityIdentifier(XXXAccessibilityIdentifier.view)
        .dynamicTypeSize(DynamicTypeSize.large)
        .onAppear() {
            self.viewModel.setup(
                theme: self.theme.value,
                intent: self.intent,
                size: self.size,
                isEnabled: self.isEnabled
            )
        }
        .onChange(of: self.theme) { theme in
            self.viewModel.theme = theme.value
        }
        .onChange(of: self.intent) { intent in
            self.viewModel.intent = intent
        }
        .onChange(of: self.size) { size in
            self.viewModel.size = size
        }
        .onChange(of: self.isEnabled) { isEnabled in
            self.viewModel.isEnabled = isEnabled
        }
    }

    private func backgroundLine() -> some View {
        Rectangle()
            .fill(self.viewModel.linesColors.colorToken)
            .frame(height: XXXConstants.lineHeight)
    }

    @ViewBuilder
    private func container<Label>(content: @escaping () -> Label) -> some View where Label: View {
        if !self.apportionsSegmentWidthsByContent {
            content()
        } else {
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    content()
                }
                .scrollIndicators(.hidden)
                .scrollBounceBehavior()
                .onChange(of: self.tags) { _ in
                    // Scroll to selection when tags are populated
                    if !self.tags.isEmpty {
                        DispatchQueue.main.async {
                            proxy.scrollTo(self.selection)
                        }
                    }
                }
                .onChange(of: self.selection) { newSelection in
                    DispatchQueue.main.async {
                        withAnimation(.easeInOut(duration: XXXConstants.animationDuration)) {
                            proxy.scrollTo(newSelection)
                        }
                    }
                }
            }
        }
    }

    private func itemButton(
        tag: AnyHashable,
        index: Int,
        isSelected: Bool
    ) -> some View {
        Button {
            if !self.showAccessibilityList, let tagValue = tag.base as? SelectionValue {
                self.selection = tagValue
            }
        } label: {

            self.content()
                .xxxLayout(self.viewModel.layout)
                .xxxSizes(self.viewModel.sizes)
                .xxxItemIsSelected(isSelected)
                .xxxItemIsPressed(self.pressedId == tag)
                .xxxContext(.renderer)
                .xxxItemTag(tag)
        }
        .frame(maxWidth: self.apportionsSegmentWidthsByContent ? nil : .infinity)
        .buttonStyle(PressedButtonStyle(
            isPressed: Binding(
                get: {
                    self.pressedId == tag
                }, set: { value, _ in
                    self.pressedId = value ? tag : nil
                }
            )
        ))
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.5)
                .onEnded { _ in
                    self.showAccessibilityList = true
                    self.pressedId = nil
                },
            isEnabled: self.dynamicTypeSize.isAccessibilitySize
        )
        .accessibilityIdentifier(XXXAccessibilityIdentifier.item(at: index))
        .accessibilityValue(String.accessibilityLabel(
            index: index,
            count: self.tags.indices.count
        ))
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .overlay(alignment: .bottom) {
            self.backgroundLine()
        }
    }

    private func accessibilityPopoverContent() -> some View {
        ScrollView {
            VStack {
                ForEach(self.tags.indices, id: \.self) { index in

                    if let tag = self.tags[safe: index] {

                        let isSelected = self.selection == tag.base as? SelectionValue

                        Button {
                            if let tagValue = tag.base as? SelectionValue {
                                self.selection = tagValue
                            }
                            self.showAccessibilityList = false
                        } label: {
                            self.content()
                                .xxxContext(.accessibilityRenderer)
                                .xxxItemTag(tag)
                        }
                        .padding(.horizontal, self.viewModel.layout.horizontalPadding)
                        .padding(.vertical, self.viewModel.layout.verticalPadding)
                        .accessibilityItemButtonColors(
                            isSelected: isSelected,
                            colors: self.viewModel.accessibilityColors
                        )
                        .clipShape(Capsule())
                        .accessibilityValue(String.accessibilityLabel(
                            index: index,
                            count: self.tags.indices.count
                        ))
                        .accessibilityAddTraits(isSelected ? .isSelected : [])
                        .accessibilityAddTraits(isSelected ? .isSelected : [])
                    }
                }
            }
            .padding(.vertical, self.viewModel.layout.verticalPadding)
        }
        .padding(.horizontal, self.viewModel.layout.horizontalPadding)
        .scrollBounceBehavior()
        .scrollIndicators(.hidden)
        .presentationCompactAdaptation()
    }

    // MARK: - Methods

    private func isSelected(_ tag: AnyHashable) -> Bool {
        guard let tagValue = tag.base as? SelectionValue else {
            return false
        }

        return tagValue == self.selection
    }
}

// MARK: - Extension

private extension View {

    @ViewBuilder
    func scrollBounceBehavior() -> some View {
        if #available(iOS 16.4, *) {
            self.scrollBounceBehavior(.basedOnSize, axes: .horizontal)
        } else {
            self
        }
    }

    @ViewBuilder
    func presentationCompactAdaptation() -> some View {
        if #available(iOS 16.4, *) {
            self.presentationCompactAdaptation(.popover)
        } else {
            self
        }
    }

    @ViewBuilder
    func accessibilityItemButtonColors(isSelected: Bool, colors: XXXAccessibilityColors) -> some View {
        if isSelected {
            self.tint(colors.selectedTintcolorToken)
                .background(colors.selectedBackgroundColorToken)
        } else {
            self.tint(.primary)
        }
    }
}
