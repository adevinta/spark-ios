//
//  SnackbarPresentationDemoView.swift
//  SparkDemo
//
//  Created by louis.borlee on 06/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

// swiftlint:disable no_debugging_method
struct SnackbarPresentationDemoView: View {

    @State private var isPresented = false
    @State private var direction: SnackbarPresentationDirection = .bottom
    @State private var autoDismissDelay: SnackbarAutoDismissDelay?

    @State private var withLeftPadding: Bool = false
    @State private var withRightPadding: Bool = false

    @State private var leftInset: CGFloat = .zero
    @State private var rightInset: CGFloat = .zero
    @State private var topInset: CGFloat = .zero
    @State private var bottomInset: CGFloat = .zero

    @State private var leftInsetText: String = ""
    @State private var rightInsetText: String = ""
    @State private var topInsetText: String = ""
    @State private var bottomInsetText: String = ""

    private static let numberFormatter = NumberFormatter()

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                componentConfiguration()
                insetsConfiguration()
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    self.isPresented = true
                }, label: {
                    Text("Show snackbar")
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(.borderedProminent)
            }
            .padding(16)
        }
        .snackbar(
            isPresented: self.$isPresented,
            direction: self.direction,
            autoDismissDelay: self.autoDismissDelay) {
                print("Dismissed!")
            } snackbar: {
                SnackbarView(
                    theme: SparkTheme.shared,
                    intent: .basic,
                    image: Image.init(.alertCircle)) {
                        Text("This is a snackbar")
                    } button: { buttonView in
                        buttonView
                            .title("Dismiss", for: .normal)
                    } action: {
                        self.isPresented = false
                    }
                    .frame(maxWidth: 600)
                    .padding(
                        .init(
                            top: self.topInset,
                            leading: self.leftInset,
                            bottom: self.bottomInset,
                            trailing: self.rightInset
                        )
                    )
            }
    }

    @ViewBuilder private func componentConfiguration() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            EnumSelector(
                title: "Direction",
                dialogTitle: "Select a direction",
                values: SnackbarPresentationDirection.allCases,
                value: self.$direction
            )
            OptionalEnumSelector(
                title: "Auto Dismiss Delay",
                dialogTitle: "Select an Auto Dismiss Delay",
                values: SnackbarAutoDismissDelay.allCases,
                value: self.$autoDismissDelay
            )
        }
    }

    @ViewBuilder private func insetsConfiguration() -> some View {
        VStack {
            TextField("Top inset", text: self.createCustomBinding(with: self.$topInsetText, to: self.$topInset))
            HStack {
                TextField("left inset", text: self.createCustomBinding(with: self.$leftInsetText, to: self.$leftInset))
                TextField("Right inset", text: self.createCustomBinding(with: self.$rightInsetText, to: self.$rightInset))
            }
            TextField("Bottom inset", text: self.createCustomBinding(with: self.$bottomInsetText, to: self.$bottomInset))
        }
    }

    private func createCustomBinding(with string: Binding<String>, to: Binding<CGFloat>) -> Binding<String> {
        return .init(
            get: { string.wrappedValue },
            set: { newValue in
                string.wrappedValue = newValue
                guard let float = Float(newValue) else {
                    to.wrappedValue = .zero
                    return
                }
                to.wrappedValue = CGFloat(float)
            }
        )
    }
}
