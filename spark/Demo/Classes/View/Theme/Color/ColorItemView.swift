//
//  ColorItemView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore
@testable import Spark

struct ColorItemView: View {
    
    // MARK: - Properties
    
    let viewModel: ColorItemViewModel

    // MARK: - View

    var body: some View {
        ZStack {
            self.viewModel.color
                .frame(height: 60)
                .cornerRadius(10)
            Text(self.viewModel.name)
                .foregroundColor(.white).contrast(-10)
        }
    }
}

struct ColorItemView_Previews: PreviewProvider {
    static var previews: some View {
        ColorItemView(viewModel: .init(name: "Title",
                                            colorToken: ColorTokenDefault(named: "red", in: Bundle())))
    }
}
