//
//  Component.swift
//  SparkDemo
//
//  Created by robin.lemaire on 19/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark

struct Component<Configuration: View, Integration: View>: View {

    // MARK: - Properties

    private var configuration: () -> Configuration
    private var integration: () -> Integration

    private let name: String

    @State private var spaceContainerType: SpaceContainerType = .none

    // MARK: - Initialization

    init(
        name: String,
        @ViewBuilder configuration: @escaping () -> Configuration,
        @ViewBuilder integration: @escaping () -> Integration
    ) {
        self.configuration = configuration
        self.integration = integration
        self.name = name
    }

    // MARK: - View

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Configuration")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 16) {
                    self.configuration()

                    EnumSelector(
                        title: "Space container",
                        dialogTitle: "Select an space container",
                        values: SpaceContainerType.allCases,
                        value: self.$spaceContainerType
                    )
                }

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()

                VStack {
                    // Top Space
                    Rectangle.spaceContainer(
                        for: .top,
                        type: self.spaceContainerType
                    )

                    HStack {
                        // Left Space
                        Rectangle.spaceContainer(
                            for: .left,
                            type: self.spaceContainerType
                        )

                        // Component Integration
                        self.integration()

                        // Right Space
                        Rectangle.spaceContainer(
                            for: .right,
                            type: self.spaceContainerType
                        )
                    }

                    // Bottom Space
                    Rectangle.spaceContainer(
                        for: .bottom,
                        type: self.spaceContainerType
                    )
                }

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitle(Text(self.name))
    }
}

// MARK: - Rectangle

private extension Rectangle {

    // MARK: - View Builder

    @ViewBuilder
    static func spaceContainer(
        for spaceContainer: SpaceContainer,
        type: SpaceContainerType
    ) -> some View {
        if spaceContainer.showSpaceContainer(from: type) {
            Rectangle()
                .fill(SparkTheme.shared.colors.main.mainContainer.color)
                .frame(width: spaceContainer.fixedWidth, height: spaceContainer.fixedHeight)
                .cornerRadius(SparkTheme.shared.border.radius.medium)
        }
    }
}
