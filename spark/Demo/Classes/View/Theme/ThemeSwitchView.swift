//
//  ThemeSwitchView.swift
//  SparkDemo
//
//  Created by janniklas.freundt.ext on 02.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI

struct ThemeSwitchView: View {
    // MARK: - Constants
    private enum Constants {
        static let backgroundColor: Color = Color.black.opacity(0.1)
        static let size = CGSize(width: 300, height: 320)
    }

    // MARK: - Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    var themes: [ThemeCellModel] = [
        .init(title: "Spark", theme: SparkTheme()),
        .init(title: "Purple", theme: PurpleTheme())
    ]

    var dismiss: () -> Void

    init(dismissAction: @escaping () -> Void) {
        self.dismiss = dismissAction
    }

    // MARK: - Content
    var body: some View {
        ZStack {
            backgroundView
            listView
        }
        .ignoresSafeArea()
        .zIndex(.infinity)
    }

    var backgroundView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
            }
        }
        .background(Constants.backgroundColor)
        .onTapGesture {
            self.hide()
        }
    }

    var listView: some View {
        VStack {
            List {
                Section(header: Text("Themes")) {
                    ForEach(self.themes, id: \.self) { themeCellModel in
                        Button(themeCellModel.title) {
                            self.changeThemeAndHide(themeCellModel.theme)
                        }
                    }
                }

                Section(header: Text("Colors")) {
                    Button("Dark Mode") {
                        self.changeApperance(.dark)
                    }
                    Button("Light Mode") {
                        self.changeApperance(.light)
                    }
                    Button("System") {
                        self.changeApperance(.unspecified)
                    }
                }

                Button("Cancel") {
                    self.hide()
                }
            }
            .frame(width: Constants.size.width, height: Constants.size.height)
            .cornerRadius(self.theme.border.radius.medium)
        }
    }

    // MARK: - Methods
    private func changeThemeAndHide(_ theme: Theme) {
        self.hide {
            self.changeTheme(theme)
        }
    }

    private func hide(completion: (() -> Void)? = nil) {
        let duration: CGFloat = 0.3
        withAnimation(.easeInOut(duration: duration)) {
            self.dismiss()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion?()
        }
    }

    private func changeApperance(_ mode: UIUserInterfaceStyle) {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
    }

    private func changeTheme(_ theme: SparkCore.Theme) {
        withAnimation {
            if let theme = theme as? SparkTheme {
                SparkTheme.shared = theme
            }
            SparkThemePublisher.shared.theme = theme
        }
    }
}

struct ThemeCellModel: Equatable, Hashable {

    // MARK: - Properties
    let title: String
    let theme: Theme

    // MARK: - Initialize
    init(title: String, theme: Theme) {
        self.title = title
        self.theme = theme
    }

    // MARK: - Methods
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.title)
    }

    static func == (lhs: ThemeCellModel, rhs: ThemeCellModel) -> Bool {
        lhs.title == rhs.title
    }
}
