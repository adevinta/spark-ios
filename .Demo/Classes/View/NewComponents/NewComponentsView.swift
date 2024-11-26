//
//  NewComponentsView.swift
//  SparkDemo
//
//  Created by louis.borlee on 19/09/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

struct NewComponentsView: View {

    @State var selectedFeature: Components?
    let isUIKit: Bool


    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationSplitView {
                List(Components.allCases, selection: self.$selectedFeature) { component in
                    Text(component.name)
                        .tag(component)
                }
                    .navigationTitle("\(isUIKit ? "UIKit" : "SwiftUI")")
            } detail: {
                if let selectedFeature {
                    Group {
                        if self.isUIKit {
                            selectedFeature.viewController()
                        } else {
                            selectedFeature.view()
                        }
                    }
                    .navigationTitle(selectedFeature.name)
                    .navigationBarTitleDisplayMode(.inline)
                } else {
                    EmptyView()
                }
            }
        } else {
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
}

// MARK: - UIKit
extension Components {
    @ViewBuilder
    func viewController() -> some View {
        let viewController = switch self {
        case .animation:
            AnimationDemoUIViewController()
        case .snackbar:
            SnackbarDemoUIView()
        case .snackbarPresentation:
            SnackbarPresentationDemoUIView()
        }

        HostingView(viewController: viewController)
    }

    private struct HostingView<ViewController: UIViewController>: UIViewControllerRepresentable {
        let viewController: ViewController

        func makeUIViewController(context: Context) -> ViewController {
            return self.viewController
        }
        
        func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        }
        
        typealias UIViewControllerType = ViewController
    }
}

// MARK: - SwiftUI
extension Components {
    @ViewBuilder func view() -> some View {
        switch self {
        case .animation:
            AnimationDemoView()
        case .snackbar:
            SnackbarDemoView()
        case .snackbarPresentation:
            SnackbarPresentationDemoView()
        }
    }
}
