//
//  ComponentDisplayView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 17/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

struct ComponentDisplayView<ComponentView: View, ConfigurationView: View, Configuration: ComponentConfiguration>: View {

    // MARK: - Properties

    @State private var configurations: [Configuration]
    @State private var presentConfigurationID: String?
    @State private var style: ComponentDisplayStyle

    @State private var colorScheme: ColorScheme = .light

    private let styles: [ComponentDisplayStyle]

    var componentView: (_ configuration: Binding<Configuration>) -> ComponentView
    var configurationView: (_ configuration: Binding<Configuration>) -> ConfigurationView

    // MARK: - Initialization

    init(
        configurations: [Configuration],
        style: ComponentDisplayStyle = .default,
        styles: [ComponentDisplayStyle] = ComponentDisplayStyle.allCases,
        @ViewBuilder componentView: @escaping (_ configuration: Binding<Configuration>) -> ComponentView,
        @ViewBuilder configurationView: @escaping (_ configuration: Binding<Configuration>) -> ConfigurationView
    ) {
        self.configurations = configurations
        self.style = style
        self.styles = styles
        self.componentView = componentView
        self.configurationView = configurationView
    }

    // MARK: - View

    var body: some View {
        VStack(spacing: .medium) {
            switch self.style {
            case .alone:
                self.aloneContent()
            case .horizontalList:
                self.horizontalList()
            case .horizontalContent:
                self.horizontalContent()
            case .verticalList:
                self.verticalListContent()
            }

            if self.style.hasBottomSpace {
                Spacer()
            }
        }
        .toolbar {
            if self.styles.hasAddButton(currentStyle: self.style) {
                Button("Add a new configuration", systemImage: "plus") {
                    let newConfiguration = Configuration()
                    self.configurations.append(newConfiguration)
                    self.presentConfigurationID = newConfiguration.id
                }
            } else if let configuration = self.configurations.first,
                      let bindingConfiguration = self.$configurations.first {

                Button("Update configuration", systemImage: "pencil") {
                    self.presentConfigurationID = configuration.id
                }
                .sheet(isPresented: self.sheetCondition(configuration)) {
                    self.configurationView(bindingConfiguration)
                        .demoSheetStyle()
                }
            }
        }
        .toolbar {
            Menu("Settings", systemImage: "slider.horizontal.3") {
                Section {
                    Picker("Select the style of the list", selection: self.$style) {
                        ForEach(self.styles, id: \.rawValue) { style in
                            Label(style.name, systemImage: style.systemImage)
                                .tag(style)
                        }
                    }
                }

                ControlGroup {
                    Button("Light Mode", systemImage: self.colorScheme.isLight ? "sun.max.fill" : "sun.max") {
                        self.colorScheme = .light
                    }
                    .disabled(self.colorScheme.isLight)

                    Button("Dark Mode", systemImage: self.colorScheme.isLight ? "moon" : "moon.fill") {
                        self.colorScheme = .dark
                    }
                    .disabled(!self.colorScheme.isLight)
                }
            }
        }
        .preferredColorScheme(self.colorScheme)
    }

    // MARK: - Subview

    @ViewBuilder
    private func aloneContent() -> some View {
        if let configuration = self.$configurations.first {
            self.componentView(configuration)
                .padding(.horizontal, .medium)
                .padding(.bottom, .medium)
        } else {
            EmptyView()
        }
    }

    private func horizontalList() -> some View {
        self.section(
            title: "Horizontal scroll list",
            subtitle: "Infinite", content: {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(self.$configurations, id: \.wrappedValue.id) { $configuration in
                            self.componentView($configuration)
                                .demoBackground(configuration, forceRoundedBackground: true)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        )
    }

    private func horizontalContent() -> some View {
        self.section(
            title: "Horizontal content",
            subtitle: "Max screen width", content: {
                HStack {
                    ForEach(self.$configurations, id: \.wrappedValue.id) { $configuration in
                        self.componentView($configuration)
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        )
    }

    private func verticalListContent() -> some View {
        List(self.$configurations) { $configuration in
            HStack {
                self.componentView($configuration)

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
            .sheet(isPresented: self.sheetCondition(configuration)) {
                self.configurationView($configuration)
                    .demoSheetStyle()
            }
        }
    }

    private func section<Content: View>(
        title: String,
        subtitle: String,
        content: @escaping () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: .small) {
            // Header
            VStack(alignment: .leading) {
                Text(title)
                    .font(.footnote)
                    .bold()
                Text(subtitle)
                    .font(.footnote)
                    .italic()
            }
            .padding(.horizontal, .medium)

            // Content
            content()
                .padding(.horizontal, .medium)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, .medium)
        .background(.ultraThickMaterial)
        .radius(.medium)
        .padding(.horizontal, .medium)
    }

    // MARK: - Binding

    private func sheetCondition(_ configuration: Configuration) -> Binding<Bool> {
        return Binding<Bool>(
            get: { configuration.id == self.presentConfigurationID },
            set: { _ in
                self.presentConfigurationID = nil
            }
        )
    }
}

// MARK: - Extension

private extension View {

    func demoSheetStyle() -> some View {
        self.presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
    }
}

private extension ColorScheme {

    var isLight: Bool {
        return self == .light
    }
}
