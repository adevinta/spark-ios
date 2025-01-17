//
//  ComponentListView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 17/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

struct ComponentListView<ComponentView: View, ConfigurationView: View, Configuration: ComponentConfiguration>: View {

    // MARK: - Properties

    @State private var configurations: [Configuration]
    @State private var presentConfigurationID: String?

    var componentView: (_ configuration: Configuration) -> ComponentView
    var configurationView: (_ configuration: Binding<Configuration>) -> ConfigurationView

    // MARK: - Initialization

    init(
        configurations: [Configuration],
        @ViewBuilder componentView: @escaping (_ configuration: Configuration) -> ComponentView,
        @ViewBuilder configurationView: @escaping (_ configuration: Binding<Configuration>) -> ConfigurationView
    ) {
        self.configurations = configurations
        self.componentView = componentView
        self.configurationView = configurationView
    }

    // MARK: - View

    var body: some View {
        List(self.$configurations) { $configuration in
            HStack {
                self.componentView(configuration)

                Spacer()
            }
            .swipeActions(edge: .leading, content: {
                Button("Configure the component", systemImage: "pencil") {
                    self.presentConfigurationID = configuration.id
                }
                .tint(.blue)
            })
            .swipeActions {
                Button("Remove the component", systemImage: "trash") {
                    self.configurations.removeAll(where: { $0.id == configuration.id })
                }
                .tint(.red)
            }
            .sheet(isPresented: Binding<Bool>(
                get: { configuration.id == self.presentConfigurationID },
                set: { _ in
                    self.presentConfigurationID = nil
                })
            ) {
                self.configurationView($configuration)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        }
        .toolbar {
            Button("Add a new configuration", systemImage: "plus") {
                let newConfiguration = Configuration()
                self.configurations.append(newConfiguration)
                self.presentConfigurationID = newConfiguration.id
            }
        }
    }
}
