//
//  RangeSelector.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 13.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct RangeSelector: View {

    // MARK: - Properties

    private let title: String
    private let range: CountableClosedRange<Int>
    @Binding private var selectedValue: Int
    private let stepper: Int
    private let numberFormatter: NumberFormatter

    private var selectedFormattedValueString: String {
        return self.numberFormatter.string(from: Double(self.selectedValue) as NSNumber) ?? "Unknow"
    }

    // MARK: - Initialization

    init(
        title: String,
        range: CountableClosedRange<Int>,
        selectedValue: Binding<Int>,
        stepper: Int = 1,
        numberFormatter: NumberFormatter = NumberFormatter()
    ) {
        self.title = title
        self.range = range
        self._selectedValue = selectedValue
        self.stepper = stepper
        self.numberFormatter = numberFormatter
    }

    // MARK: - View

    var body: some View {
        HStack(spacing: 5) {
            Text(title).bold()
            Button("-") {
                guard self.selectedValue > self.range.lowerBound else { return }
                self.selectedValue -= self.stepper
            }
            Text("\(self.selectedFormattedValueString)")
            Button("+") {
                guard self.selectedValue < self.range.upperBound else { return }
                self.selectedValue += self.stepper
            }
        }
    }
}
