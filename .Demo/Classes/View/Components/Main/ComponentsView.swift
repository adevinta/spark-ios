//
//  ComponentsView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

struct ComponentsView: View {

    // MARK: - Enum

    enum Framework: String, CaseIterable, Hashable {
        case swiftUI
        case uiKit

        var isSwiftUI: Bool {
            self == .swiftUI
        }

        var name: String {
            switch self {
            case .uiKit: "UIKit"
            case .swiftUI: "SwiftUI"
            }
        }

        var icon: String {
            switch self {
            case .uiKit: "u.circle"
            case .swiftUI: "s.circle"
            }
        }
    }

    private enum Component: String, CaseIterable, Hashable {
        case textEditor
        case textField
        case tag
        case textLink

        static func allCases(for framework: Framework) -> [Self] {
            switch framework {
            case .uiKit: []
            case .swiftUI: self.allCases
            }
        }
    }

    // MARK: - Properties

    let framework: Framework

    // MARK: - View

    var body: some View {
        NavigationStack {
            List(Component.allCases(for: self.framework), id: \.self) { component in
                NavigationLink(component.name, value: component)
            }
            .navigationDestination(for: Component.self, destination: { component in
                switch self.framework {
                case .uiKit:
                    EmptyView()

                case .swiftUI:
                    self.swiftUIComponent(component)
                        .navigationBarTitle(component.name)
                }
            })
            .navigationBarTitle(self.framework.name + " Components")
        }
    }

    // MARK: - SwiftUI Components

    @ViewBuilder
    private func swiftUIComponent(_ component: Component) -> some View {
        switch component {
        case .textEditor:
            TextEditorComponentView()
        case .textField:
            TextFieldComponentView()
        case .tag:
             TagComponentView()
        case .textLink:
            TextLinkComponentView()
        }
    }
}

#Preview {
    ComponentsView(framework: .swiftUI)
}
