//
//  IconButtonComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

struct AnimationDemoView: View {

    // MARK: - Properties

    @State private var animationType: SparkAnimationType?

    // MARK: - View

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(AnimationOption.allCases, id: \.self) { option in
                    AnimationView(option: option)
                }
            }
        }
        .padding(20)
    }
}

private struct AnimationView: View {

    // MARK: - Properties

    private let image = Image(systemName: "bell")
    @State private var option: AnimationOption
    @State private var play: Bool = false

    // MARK: - Initialization

    init(option: AnimationOption) {
        self.option = option
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20) {
                Text(self.option.title)
                    .font(.title2)
                    .bold()

                ButtonView(
                    theme: SparkTheme.shared,
                    intent: .support,
                    variant: .ghost,
                    size: .medium,
                    shape: .rounded,
                    alignment: .leadingImage
                ) {
                    self.play = true
                }
                .title("Start", for: .normal)
                .disabled(self.play)
            }

            HStack(alignment: .center, spacing: 20) {
                IconView(
                    theme: SparkTheme.shared,
                    intent: self.option.iconIntent,
                    size: .medium,
                    iconImage: self.image
                )
                .animate(
                    type: .bell,
                    play: self.play,
                    repeat: self.option.repeat) {
                        self.play = false
                    }

                IconButtonView(
                    theme: SparkTheme.shared,
                    intent: self.option.buttonIntent,
                    variant: .filled,
                    size: .medium,
                    shape: .rounded,
                    action: { })
                .image(self.image, for: .normal)
                .animate(
                    type: .bell,
                    play: self.play,
                    repeat: self.option.repeat) {
                        self.play = false
                    }

                Spacer()
            }

            if self.option.hasBottomSeparationLine {
                Divider()
            }
        }
    }
}

// MARK: - Preview

struct AnimationDemoView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationDemoView()
    }
}
