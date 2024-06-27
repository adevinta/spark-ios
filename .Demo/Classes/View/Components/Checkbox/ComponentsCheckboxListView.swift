//
//  ComponentsCheckboxListView.swift
//  SparkDemo
//
//  Created by janniklas.freundt.ext on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct ComponentsCheckboxListView: View {

    @Environment(\.navigationController) var navigationController

    let isSwiftUI: Bool

    init(isSwiftUI: Bool) {
        self.isSwiftUI = isSwiftUI
    }

    var body: some View {
        List {

            if isSwiftUI {
                Button("Checkbox") {
                    self.navigateToView(CheckboxListView())
                }

                Button("Checkbox Group") {
                    self.navigateToView(CheckboxGroupListView())
                }
            } else {
                Button("Checkbox") {
                    self.navigationController?.pushViewController(CheckboxComponentUIViewController.build(), animated: true)
                }

                Button("Checkbox Group") {
                    self.navigationController?.pushViewController(CheckboxGroupComponentUIViewController.build(), animated: true)
                }
            }
        }
        .navigationBarTitle("Checkbox List")
        .foregroundColor(.primary)
        .navigationBarHidden(false)
        .navigationTitle("Components")
    }

    private func navigateToView(_ rootView: some View) {
        let controller = UIHostingController(rootView: rootView)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

struct ComponentsCheckboxListView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsCheckboxListView(isSwiftUI: false)
    }
}
