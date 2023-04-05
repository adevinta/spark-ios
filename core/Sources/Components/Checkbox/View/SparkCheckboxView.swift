//
//  SparkCheckboxView.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct SparkCheckboxView: View {

    // MARK: - Type Alias

    private typealias AccessibilityIdentifier = SparkTagAccessibilityIdentifier

    // MARK: - Public Properties

    public var theming: SparkCheckboxTheming {
        didSet {
            self.colors = colorsUseCase.execute(from: self.theming)
        }
    }
    public var iconImage: Image?

    public var accessibilityIdentifier: String?
    public var accessibilityLabel: String?

    // MARK: - Private Properties

    private var colors: SparkCheckboxColorables
    private let colorsUseCase: SparkCheckboxColorsUseCaseable

    @ObservedObject var viewModel: SparkCheckboxViewModel

    // MARK: - Initialization

    public init(theming: SparkCheckboxTheming,
                iconImage: Image? = nil,
                viewModel: SparkCheckboxViewModel) {
        self.init(theming: theming,
                  colorsUseCase: SparkCheckboxColorsUseCase(),
                  viewModel: viewModel)
    }

    init(theming: SparkCheckboxTheming,
         iconImage: Image? = nil,
         colorsUseCase: SparkCheckboxColorsUseCaseable,
         viewModel: SparkCheckboxViewModel) {
        self.theming = theming
        self.iconImage = iconImage
        self.colorsUseCase = colorsUseCase
        self.colors = colorsUseCase.execute(from: theming)
        self.viewModel = viewModel
    }

    @ViewBuilder private var checkboxView: some View {
        let tintColor = colors.checkboxTintColor.color
        switch viewModel.selectionState {
        case .selected:
            RoundedRectangle(cornerRadius: 5)
                .fill(tintColor)
                .frame(width: 15, height: 15)
        case .unselected:
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(tintColor, lineWidth: 2)
                .frame(width: 15, height: 15)
        case .indeterminate:
            RoundedRectangle(cornerRadius: 5)
                .fill(tintColor)
                .frame(width: 15, height: 15)
        }
    }

    public var body: some View {
        HStack {
            Text(viewModel.text)
                .font(self.theming.theme.typography.body1.font)
                .foregroundColor(self.colors.textColor.color)
                .accessibilityIdentifier(AccessibilityIdentifier.text)

            Spacer()

            checkboxView
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("tapped", viewModel.text)
            switch viewModel.selectionState {
            case .selected:
                viewModel.selectionState = .unselected
            case .unselected:
                viewModel.selectionState = .selected
            case .indeterminate:
                break
            }
        }
    }
}
