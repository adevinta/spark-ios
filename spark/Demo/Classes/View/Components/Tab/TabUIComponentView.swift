//
//  TabUIComponentView.swift
//  Spark
//
//  Created by michael.zimmermann on 08.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import Spark
import SparkCore
import SwiftUI
import UIKit

struct TabUIComponentView: View {
    // MARK: - Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared
    @State var selectedTab = 1
    @State var height: CGFloat = CGFloat(50)

    // MARK: - View
    var body: some View {
        TabUIComponentRepresentableView(
            theme: themePublisher.theme,
            intent: .main,
            tabSize: .md,
            showText: true,
            showIcon: true,
            showBadge: true,
            isEnabled: true,
            numberOfTabs: 1,
            selectedTab: self.$selectedTab,
            height: self.$height,
            maxWidth: 300
        )
    }
}

struct TabUIComponentRepresentableView: UIViewRepresentable {

    let theme: Theme
    let intent: TabIntent
    let tabSize: TabSize
    let showText: Bool
    let showIcon: Bool
    let showBadge: Bool
    let isEnabled: Bool
    let numberOfTabs: Int
    let badge: BadgeUIView
    @Binding var selectedTab: Int
    @Binding var height: CGFloat
    let maxWidth: CGFloat

    private let publishedBinding: PublishedBinding<Int>

    init(theme: Theme,
         intent: TabIntent,
         tabSize: TabSize,
         showText: Bool,
         showIcon: Bool,
         showBadge: Bool,
         isEnabled: Bool,
         numberOfTabs: Int,
         selectedTab: Binding<Int>,
         height: Binding<CGFloat>,
         maxWidth: CGFloat
    ) {
        self.theme = theme
        self.intent = intent
        self.tabSize = tabSize
        self.showText = showText
        self.showIcon = showIcon
        self.showBadge = showBadge
        self.isEnabled = isEnabled
        self.numberOfTabs = numberOfTabs
        self._selectedTab = selectedTab
        self._height = height
        self.publishedBinding = PublishedBinding(binding: selectedTab)
        self.maxWidth = maxWidth

        self.badge = BadgeUIView(
            theme: theme,
            intent: .danger,
            size: tabSize.badgeSize,
            value: 5,
            isBorderVisible: false
        )
    }

    func makeUIView(context: Context) -> SparkCore.TabUIView {

        let content: [(UIImage?, String?)] = (1...numberOfTabs).map { tabNo in
            (self.showIcon ? .image(at: tabNo) : nil,
             self.showText ? "Label \(tabNo)" : nil )
        }

        let view = TabUIView(
            theme: self.theme,
            intent: self.intent,
            tabSize: self.tabSize,
            content: content
        )
        view.maxWidth = self.maxWidth

        publishedBinding.publisher = view.publisher.eraseToAnyPublisher()
        view.selectedSegmentIndex = self.selectedTab
        if self.showBadge {
            view.segments.randomElement()?.badge = self.badge
        }

        return view
    }

    func updateUIView(_ uiView: SparkCore.TabUIView, context: Context) {
        uiView.theme = self.theme
        uiView.intent = self.intent
        uiView.tabSize = self.tabSize
        uiView.isEnabled = self.isEnabled
        uiView.maxWidth = self.maxWidth

        uiView.segments.enumerated().forEach{ index, tab in
            tab.icon = self.showIcon ? .image(at: index) : nil
            tab.title = self.showText ? "Label \(index)" : nil
        }

        if self.numberOfTabs > uiView.numberOfSegments {
            guard let content: (icon: UIImage, title: String) = (0..<self.numberOfTabs).map({ (icon: .image(at: $0), title: "Label \($0)") }).last else { return }

            if self.showIcon && self.showText {
                uiView.addSegment(withImage: content.icon, andTitle: content.title, animated: true)
            } else if self.showIcon {
                uiView.addSegment(with: content.icon, animated: true)
            } else if self.showText {
                uiView.addSegment(with: content.title, animated: true)
            } else {
                uiView.addSegment(with: "")
                uiView.segments[self.numberOfTabs].label.text = nil
            }
        } else if self.numberOfTabs < uiView.numberOfSegments {
            uiView.removeSegment(at: uiView.numberOfSegments - 1, animated: true)
            uiView.selectedSegmentIndex = min(uiView.selectedSegmentIndex, uiView.numberOfSegments - 1)
        }

        self.badge.size = self.tabSize.badgeSize
        let badgeIndex = uiView.segments.firstIndex(where: {$0.badge != nil})
        if let badgeIndex = badgeIndex, !self.showBadge {
            uiView.segments[badgeIndex].badge = nil
        } else if badgeIndex == nil && self.showBadge {
            uiView.segments.randomElement()?.badge = self.badge
        }

        DispatchQueue.main.async {
            self.height = uiView.intrinsicContentSize.height
            uiView.scrollToSelectedSegement(animated: true)
        }
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

    // swiftlint: disable force_unwrapping
    static func image(at index: Int) -> UIImage {
        let allSfs: [String] = names.flatMap{ [$0, "\($0).fill"] }
        let imageName = allSfs[index % names.count]
        return UIImage(systemName: imageName)!
    }
}

private class PublishedBinding<T> {
    var publisher: AnyPublisher<T, Never>? {
        didSet {
            guard let publisher = publisher else { return }
            publisher.sink { value in
                self.binding.wrappedValue = value
            }
            .store(in: &self.cancellables)
        }
    }
    let binding: Binding<T>
    var cancellables = Set<AnyCancellable>()

    init( binding: Binding<T>) {
        self.binding = binding
    }
}

private extension TabSize {
    var badgeSize: BadgeSize {
        switch self {
        case .md: return .medium
        case .sm: return .small
        case .xs: return .small
        @unknown default:
            fatalError()
        }
    }
}

