//
//  RangeSelector.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 13.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct RangeSelector: View {

    let title: String
    let range: CountableClosedRange<Int>
    @Binding var selectedValue: Int

    var body: some View {
        HStack(spacing: 5) {
            Text(title).bold()
            Button("-") {
                guard self.selectedValue > self.range.lowerBound else { return }
                self.selectedValue -= 1
            }
            Text("\(self.selectedValue)")
            Button("+") {
                guard self.selectedValue < self.range.upperBound else { return }
                self.selectedValue += 1
            }
        }
    }
}
