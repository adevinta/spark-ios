//
//  ProgressTrackerComponent.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 13.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

@testable import SparkCore
import SwiftUI

struct ProgressTrackerComponent: View {
    @State var theme = SparkThemePublisher.shared.theme
    @State var intent = ProgressTrackerIntent.basic
    @State var variant = ProgressTrackerVariant.outlined
    @State var size = ProgressTrackerSize.medium
    @State var numberOfPages: Int = 4
    @State var orientation = ProgressTrackerOrientation.horizontal
    @State private var showLabel = CheckboxSelectionState.selected
    @State private var label: String = "Lore"
    @State private var currentPageIndex: Int = 0
    @State private var disabledPageIndex: Int = -1
    @State private var frame = 0
    @State private var contentType: ProgressTrackerComponentUIViewModel.ContentType = .none
    @State private var isDisabled = CheckboxSelectionState.unselected
    @State private var completedPageIndicator = CheckboxSelectionState.unselected
    @State private var currentPageIndicator = CheckboxSelectionState.unselected
    @State private var interaction = ProgressTrackerInteractionState.none

    private var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.multiplier = 150
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }()

    var body: some View {
        Component(
            name: "Progress Tracker",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an intent",
                    values: ProgressTrackerIntent.allCases,
                    value: self.$intent
                )

                EnumSelector(
                    title: "Size",
                    dialogTitle: "Select a size",
                    values: ProgressTrackerSize.allCases,
                    value: self.$size
                )

                EnumSelector(
                    title: "Variant",
                    dialogTitle: "Select a variant",
                    values: ProgressTrackerVariant.allCases,
                    value: self.$variant
                )

                EnumSelector(
                    title: "Orientation",
                    dialogTitle: "Select an orientation",
                    values: ProgressTrackerOrientation.allCases,
                    value: self.$orientation
                )

                EnumSelector(
                    title: "Interaction",
                    dialogTitle: "Select an interaction type",
                    values: ProgressTrackerInteractionState.allCases,
                    value: self.$interaction
                )

                EnumSelector(
                    title: "Content",
                    dialogTitle: "Content Type",
                    values: ProgressTrackerComponentUIViewModel.ContentType.allCases,
                    value: self.$contentType)

                CheckboxView(
                    text: "Disable",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$isDisabled
                )

                CheckboxView(
                    text: "Completed Page Indicator",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$completedPageIndicator
                )

                CheckboxView(
                    text: "Current Page Indicator",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$currentPageIndicator
                )

                RangeSelector(
                    title: "Disabled Page", range: -1...7, selectedValue: self.$disabledPageIndex)

                RangeSelector(
                    title: "Current Page", range: 0...7, selectedValue: self.$currentPageIndex)

                RangeSelector(
                    title: "Number of Pages", range: 2...8, selectedValue: self.$numberOfPages)

                HStack() {
                    Text("Label ").bold()
                    TextField(
                        "Value",
                        text: self.$label
                    )
                }

                CheckboxView(
                    text: "With Label",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$showLabel
                )

                RangeSelector(
                    title: "Frame width/height",
                    range: 0...3,
                    selectedValue: self.$frame,
                    numberFormatter: self.numberFormatter
                )

            },

            integration: {
                let view = self.progressTrackerView()

                if self.frame == 0 {
                    view.disabled(self.isDisabled == .selected)
                } else if self.orientation == .horizontal {
                    view.frame(width: CGFloat(self.frame) * 150.0)
                        .disabled(self.isDisabled == .selected)
                } else {
                    view.frame(height: CGFloat(self.frame) * 150.0)
                        .disabled(self.isDisabled == .selected)
                }
            }
        )
        .onChange(of: self.currentPageIndex) { index in
            Console.log("Current page \(index)")
        }
    }

    private func progressTrackerView() -> ProgressTrackerView {
        var view: ProgressTrackerView = {
            if self.showLabel == .selected {
                return ProgressTrackerView(
                    theme: self.theme,
                    intent: self.intent,
                    variant: self.variant,
                    size: self.size,
                    labels: (0..<self.numberOfPages).map(self.label(_:)),
                    orientation: self.orientation,
                    currentPageIndex: self.$currentPageIndex
                )
            } else {
                return ProgressTrackerView(
                    theme: self.theme,
                    intent: self.intent,
                    variant: self.variant,
                    size: self.size,
                    numberOfPages: self.numberOfPages,
                    orientation: self.orientation,
                    currentPageIndex: self.$currentPageIndex
                )
            }
        }()

        if self.frame == 0 {
            view = view.useFullWidth(false)
        } else if self.orientation == .horizontal {
            view = view.useFullWidth(true)
        } else {
            view = view.useFullWidth(true)
        }

        if self.disabledPageIndex >= 0 {
            view = view.disable(true, forIndex: self.disabledPageIndex)
        }

        if self.completedPageIndicator == .selected {
            let image: Image? = DemoIconography.shared.checkmark.image
            view = view.completedIndicatorImage(image)
        } else {
            view = view.completedIndicatorImage(nil)
        }

        if self.currentPageIndicator == .selected {
            for i in 0..<self.numberOfPages {
                let image = Image(uiImage: UIImage.selectedImage(at: i))
                view = view.currentPageIndicatorImage(image, forIndex: i)
            }
        }

        switch self.contentType {
        case .none:
            view = view.showDefaultPageNumber(false)
        case .page:
            view = view.showDefaultPageNumber(true)
        case .text:
            for i in 0..<self.numberOfPages {
                let text = "A\(i)"
                view = view.indicatorLabel(text, forIndex: i)
            }
        case .icon:
            for i in 0..<self.numberOfPages {
                let image = Image(uiImage: UIImage.image(at: i))
                view = view.indicatorImage(image, forIndex: i)
            }
        }

        view = view.interactionState(self.interaction)

        return view

    }

    private func label(_ index: Int) -> String {
        if self.label.isEmpty {
            return "\(index)"
        } else {
            let label = index % 2 == 0 ? String(self.label.prefix(4)) : self.label
            return "\(label.trimmingCharacters(in: .whitespaces)) \(index)"
        }
    }
}
