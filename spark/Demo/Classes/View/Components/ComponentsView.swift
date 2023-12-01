//
//  ComponentsView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct ComponentsView: View {

    @Environment(\.navigationController) var navigationController

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    var body: some View {
        List {
            Group {
                Button("Badge") {
                    self.navigateToView(BadgeComponentView())
                }
                Button("Button") {
                    self.navigateToView(ButtonComponentView())
                }

            }

            Group {
                Button("Checkbox") {
                    self.navigateToView(
                        ComponentsCheckboxListView(
                            isSwiftUI: true
                        ).environment(\.navigationController, self.navigationController)
                    )
                }

                Button("Chip") {
                    self.navigateToView(ChipComponentView())
                }
            }

            Button("Icon") {
                self.navigateToView(IconComponentView())
            }

            Group {
                Button("Progress Bar - Indeterminate") {
                    self.navigateToView(ProgressBarIndeterminateComponentView())
                }

                Button("Progress Bar - Single") {
                    self.navigateToView(ProgressBarComponentView())
                }
            }

            Button("Radio Button") {
                self.navigateToView(RadioButtonGroup())
            }

            Button("Spinner") {
                self.navigateToView(SpinnerComponent())
            }

            Button("Switch") {
                self.navigateToView(SwitchComponentView())
            }

            Group {
                Button("Tab") {
                    self.navigateToView(TabComponent())
                }

                Button("Tag") {
                    self.navigateToView(TagComponentView())
                }
            }
        }
        .foregroundColor(.primary)
        .navigationBarHidden(false)
        .navigationTitle("Components")
        .background(Color.gray)
        .accentColor(theme.colors.main.main.color)
    }

    private func navigateToView(_ rootView: some View) {
        let controller = UIHostingController(rootView: rootView)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

struct ComponentsView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsView()
    }
}
