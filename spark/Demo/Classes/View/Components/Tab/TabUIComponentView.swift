//
//  TabUIComponentView.swift
//  Spark
//
//  Created by michael.zimmermann on 08.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import Spark
import SparkCore
import SwiftUI
import UIKit

struct TabUIComponentView: View {
    // MARK: - Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - View
    var body: some View {
        let badge = BadgeUIView(
            theme: themePublisher.theme,
            intent: .danger,
            value: 5,
            isBorderVisible: false)
        TabUIComponentRepresentableView(
            theme: themePublisher.theme,
            intent: .main,
            tabSize: .md,
            showText: true,
            showIcon: true,
            badge: badge,
            isSelected: true,
            isEnabled: true,
            numberOfTabs: 1
        )
    }
}

struct TabUIComponentRepresentableView: UIViewRepresentable {
    let theme: Theme
    let intent: TabIntent
    let tabSize: TabSize
    let showText: Bool
    let showIcon: Bool
    let badge: BadgeUIView?
    let isSelected: Bool
    let isEnabled: Bool
    let numbeOfTabs: Int

    init(theme: Theme,
         intent: TabIntent,
         tabSize: TabSize,
         showText: Bool,
         showIcon: Bool,
         badge: BadgeUIView?,
         isSelected: Bool,
         isEnabled: Bool,
         numberOfTabs: Int
    ) {
        self.theme = theme
        self.intent = intent
        self.tabSize = tabSize
        self.showText = showText
        self.showIcon = showIcon
        self.badge = badge
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.numbeOfTabs = numberOfTabs
    }

    func makeUIView(context: Context) -> SparkCore.TabUIView {

        let content: [(UIImage?, String?)] = (1...numbeOfTabs).map { tabNo in
            (self.showIcon ? UIImage.random : nil,
             self.showText ? "Label \(tabNo)" : nil )
        }

        let view = TabUIView(
            theme: self.theme,
            intent: self.intent,
            tabSize: self.tabSize,
            content: content
        )
        view.segments.last?.badge = self.badge
        view.segments.first?.isSelected = self.isSelected

        view.isSelected = self.isSelected
        view.isEnabled = self.isEnabled

        return view
    }

    func updateUIView(_ uiView: SparkCore.TabUIView, context: Context) {
        uiView.theme = self.theme
        uiView.intent = self.intent
        uiView.tabSize = self.tabSize
        uiView.isEnabled = self.isEnabled
        uiView.segments.forEach{ tab in
            tab.imageView.isHidden = !self.showIcon
            tab.label.isHidden = !self.showText
        }

        if self.numbeOfTabs != uiView.numberOfSegments {
            uiView.removeAllSegments()

            for tabNo in 0..<self.numbeOfTabs {
                uiView.insertSegment(
                    withImage: self.showIcon ? .random : nil,
                    andTitle: self.showText ? "Label \(tabNo)" : nil,
                    at: tabNo,
                    animated: false)
            }
        }
        uiView.segments.first?.isSelected = self.isSelected
        uiView.segments.last?.badge = self.badge
    }
}

struct TabUIComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TabUIComponentView()
    }
}


private extension UIImage {
    static let names = [
        "fleuron",
        "trash",
        "folder",
        "paperplane",
        "tray",
        "externaldrive",
        "internaldrive",
        "archivebox",
        "doc",
        "clipboard",
        "terminal",
        "book",
        "greetingcard",
        "menucard",
        "magazine"
    ]

    static var random: UIImage? {
        let allSfs: [String] = names.flatMap{ [$0, "\($0).fill"] }
        let sfName: String? = allSfs.randomElement()
        let image = sfName.flatMap(UIImage.init(systemName:))
        if image == nil {
            fatalError("NO IMAGE FOUND FOR \(sfName)")
        }
        return image
    }
}
