//
//  ColorItemView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SwiftUI

struct ColorItemView: View {

    // MARK: - Properties

    let viewModel: ColorItemViewModel

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(self.viewModel.name)
            VStack(alignment: .leading, spacing: 8) {
                ForEach(self.viewModel.states, id: \.self) { stateViewModel in
                    Text(stateViewModel.name)
                        .font(Font.caption2)
                        .foregroundColor(.gray).contrast(-5)
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(stateViewModel.color)
                        .cornerRadius(8)
                }
            }

        }
    }
}

struct ColorItemView_Previews: PreviewProvider {
    static var previews: some View {
        ColorItemView(viewModel: .init(name: "Name",
                                       colorToken: .init(enabled: .init(uiColor: .blue, swiftUIcolor: .orange),
                                                         pressed: .init(uiColor: .green, swiftUIcolor: .blue),
                                                         disabled: .init(uiColor: .yellow, swiftUIcolor: .green),
                                                         on: .init(uiColor: .purple, swiftUIcolor: .yellow))))
    }
}
