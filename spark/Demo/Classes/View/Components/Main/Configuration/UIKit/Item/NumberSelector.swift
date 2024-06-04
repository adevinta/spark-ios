//
//  NuumberSelector.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 06.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import UIKit
@_spi(SI_SPI) import SparkCommon

/// A control to select a number withing a given range
final class NumberSelector: UIControl {

    private let range: CountableClosedRange<Int>
    var selectedValue: Int
    var stepper: Int
    let numberFormatter: NumberFormatter

    private var selectedFormattedValueString: String {
        return self.numberFormatter.string(from: Double(self.selectedValue) as NSNumber) ?? "Unknow"
    }

    // MARK: - View Properties
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.decrementCount), for: .touchUpInside)
        return button
    }()

    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.incrementCount), for: .touchUpInside)
        return button
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.selectedFormattedValueString
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.minusButton,
            self.label,
            self.plusButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Initialization

    init(
        range: CountableClosedRange<Int>,
        selectedValue: Int,
        stepper: Int = 1,
        numberFormatter: NumberFormatter = NumberFormatter()
    ) {
        self.range = range
        self.selectedValue = min(max(range.lowerBound, selectedValue), range.upperBound)
        self.stepper = stepper
        self.numberFormatter = numberFormatter

        super.init(frame: .zero)

        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        self.addSubviewSizedEqually(self.stackView)
    }

    private func updateLabel() {
        self.label.text = self.selectedFormattedValueString
    }

    // MARK: - Button Targets

    @objc private func decrementCount() {
        guard self.selectedValue > self.range.lowerBound else { return }
        self.selectedValue -= self.stepper
        self.updateLabel()
        self.sendActions(for: .valueChanged)
    }

    @objc private func incrementCount() {
        guard self.selectedValue < self.range.upperBound else { return }
        self.selectedValue += self.stepper
        self.updateLabel()
        self.sendActions(for: .valueChanged)
    }
}
