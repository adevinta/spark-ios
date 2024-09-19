//
//  NewComponentsView.swift
//  SparkDemo
//
//  Created by louis.borlee on 19/09/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

struct NewComponentsView: View {

    let isUIKit: Bool
    var body: some View {
        NavigationView {
            List(Components.allCases, id: \.self) { component in
                NavigationLink {
                    Group {
                        if self.isUIKit {
                            component.viewController()
                        } else {
                            component.view()
                        }
                    }
                    .navigationTitle(component.name)
                    .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text(component.name.capitalizingFirstLetter)
                }

            }
            .navigationTitle("\(isUIKit ? "UIKit" : "SwiftUI")")
        }
    }
}

// MARK: - UIKit
extension Components {
    func viewController() -> some View {
        switch self {
        case .snackbar:
            return HostingView(viewController: .init(nibName: nil, bundle: nil))
        }
    }

    private struct HostingView<ViewController: UIViewController>: UIViewControllerRepresentable {

        private let viewController: UIViewControllerType

        init(viewController: UIViewControllerType) {
            self.viewController = viewController
            self.viewController.view.backgroundColor = .systemBackground
        }

        func makeUIViewController(context: Context) -> ViewController {
            return self.viewController
        }

        func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
    }
}

// MARK: - SwiftUI
extension Components {
    @ViewBuilder func view() -> some View {
        switch self {
        case .snackbar:
            SnackbarDemoView()
        }
    }
}
