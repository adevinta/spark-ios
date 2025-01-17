//
//  ThemeView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 02/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct ThemeView: View {

    // MARK: - Enum

    private enum Styles: String, CaseIterable {
        case border
        case colors
        case dims
        case elevation
        case layout
        case typography
    }


    // MARK: - View

    var body: some View {
            List(Styles.allCases, id: \.self) { component in
                NavigationLink(component.name, value: component)
            }
            .navigationDestination(for: Styles.self, destination: { component in
                switch component {
                case .border : BorderView()
                case .colors : ColorView()
                case .dims : DimsView()
                case .elevation : ElevationView()
                case .layout : LayoutView()
                case .typography : TypographyView()
                }
            })
            .navigationBarTitle("Theme")
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
