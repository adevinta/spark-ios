//
//  BorderItemView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SwiftUI

struct BorderItemView: View {

    // MARK: - Properties

    let viewModel: BorderItemViewModel

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading) {
            Text(self.viewModel.name)
            Text(self.viewModel.description)
                .font(Font.caption2)
                .italic()
                .foregroundColor(.gray)

            Color.gray
                .cornerRadius(self.viewModel.radius)
                .frame(width: 200, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: self.viewModel.radius)
                        .stroke(Color.black, lineWidth: self.viewModel.width)
                )
        }
    }
}

struct BorderItemView_Previews: PreviewProvider {
    static var previews: some View {
        BorderItemView(viewModel: .init(name: "Title", width: 10, radius: 4))
    }
}
