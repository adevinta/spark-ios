//
//  TabUIView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 08.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import UIKit

public final class TabUIView: UIControl {

    public var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .lastBaseline
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    public var segments: [TabItemUIView] {
        return self.stackView.arrangedSubviews.compactMap { view in
            return view as? TabItemUIView
        }
    }

    public var theme: Theme {
        didSet {
            self.segments.forEach { tab in
                tab.theme = theme
            }
        }
    }

    public var intent: TabIntent {
        didSet {
            self.segments.forEach { tab in
                tab.intent = intent
            }
        }
    }

    public var tabSize: TabSize {
        didSet {
            self.segments.forEach { tab in
                tab.tabSize = tabSize
            }
        }
    }

    public var publisher: some Publisher<Int, Never> {
        return self.selectedIndexSubject
    }

    public override var isEnabled: Bool {
        didSet {
            self.segments.forEach{ $0.isEnabled = self.isEnabled }
        }
    }
    private let selectedIndexSubject = PassthroughSubject<Int, Never>()

    public weak var delegate: TabUIViewDelegate?

    public convenience init(theme: Theme,
                intent: TabIntent = .main,
                tabSize: TabSize = .md,
                texts: [String]
    ) {
        self.init(theme: theme,
                  intent: intent,
                  tabSize: tabSize,
                  items: texts.map(TabUIItemContent.init(text:)))
    }

    convenience public init(theme: Theme,
                intent: TabIntent = .main,
                tabSize: TabSize = .md,
                icons: [UIImage]
    ) {
        self.init(theme: theme,
                  intent: intent,
                  tabSize: tabSize,
                  items: icons.map(TabUIItemContent.init(icon:)))
    }

    convenience public init(theme: Theme,
                intent: TabIntent = .main,
                tabSize: TabSize = .md,
                content: [(UIImage?, String?)]
    ) {
        self.init(theme: theme,
                  intent: intent,
                  tabSize: tabSize,
                  items: content.map(TabUIItemContent.init(icon:text:)))
    }

    init(theme: Theme,
                intent: TabIntent = .main,
                tabSize: TabSize = .md,
         items: [TabUIItemContent]) {

        self.theme = theme
        self.intent = intent
        self.tabSize = tabSize

        super.init(frame: .zero)

        let tabItemViews = items.map{ item in
            return TabItemUIView(theme: theme, intent: intent, tabSize: tabSize, text: item.text, icon: item.icon)
        }

        for (index, tabItem) in tabItemViews.enumerated() {
            let pressedAction = UIAction { [weak self] _ in
                self?.pressed(index)
            }
            let unselectAction = UIAction { [weak self] _ in
                self?.unselectSegment(index)
            }
            let contentChangedAction = UIAction { [weak self] _ in
                self?.segementContentChanged(index)
            }
            tabItem.addAction(pressedAction, for: .touchUpInside)
            tabItem.addAction(unselectAction, for: .otherSegmentSelected)
            tabItem.addAction(contentChangedAction, for: .contentChanged)
            tabItem.accessibilityIdentifier = "\(TabAccessibilityIdentifier.tabItem)-\(index)"
        }

        self.stackView.addArrangedSubviews(tabItemViews)
        self.addSubviewSizedEqually(stackView)
        self.selectedSegmentIndex = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Managing segment content
    /// Sets the content of a segment to a given image.
    public func setImage(_ image: UIImage?, forSegmentAt index: Int) {
        self.segments[safe: index]?.icon = image
    }

    /// Returns the image for a specific segment.
    public func imageForSegment(at index: Int) -> UIImage? {
        return self.segments[safe: index]?.icon
    }

    /// Sets the title of a segment.
    public func setTitle(_ text: String?, forSegmentAt index: Int) {
        self.segments[safe: index]?.text = text
    }

    /// Returns the title of the specified segment.
    public func titleForSegment(at index: Int) -> String? {
        return self.segments[safe: index]?.text
    }

    public func setBadge(_ badge: BadgeUIView?, forSegementAt index: Int) {
        self.segments[safe: index]?.badge = badge
    }

    public func badgeForSetment(at index: Int) -> UIView? {
        return self.segments[safe: index]?.badge
    }

    //MARK: -Managing segment actions
    /// Fetches the action of the segment at the index you specify, if one exists.
    public func actionForSegment(at index: Int) -> UIAction? {
        return self.segments[safe: index]?.action
    }

    /// Sets the action for the segment at the index you specify.
    public func setAction(_ action: UIAction, forSegmentAt index: Int) {
        self.segments[safe: index]?.action = action
    }

    //MARK: - Managing segments
    /// Returns the number of segments the segmented control has.
    public var numberOfSegments: Int {
        return segments.count
    }

    /// The index of the segment with an action that has a matching identifier, or NSNotFound if no matching action is found..
    public func segmentIndex(identifiedBy identifier: UIAction.Identifier) -> Int {
        return self.segments.firstIndex(where: { $0.action?.identifier  == identifier }) ?? NSNotFound
    }

    /// Insert a segment with the action you specify at the given index.
    public func insertSegment(action: UIAction,
                              at index: Int,
                              animated: Bool = false) {
        let tab = TabItemUIView(theme: self.theme, intent: self.intent, tabSize: self.tabSize)
        tab.action = action
        self.insertTab(tab, at: index, animated: animated)
    }

    /// Inserts a segment at the position you specify and gives it an image as content.
    public func insertSegment(with icon: UIImage?,
                              at index: Int,
                              animated: Bool = false) {
        let tab = TabItemUIView(theme: self.theme, intent: self.intent, tabSize: self.tabSize, icon: icon)
        self.insertTab(tab, at: index, animated: animated)
    }

    ///Inserts a segment at the position you specify and gives it a title as content.
    public func insertSegment(withTitle text: String?,
                              at index: Int,
                              animated: Bool = false) {
        let tab = TabItemUIView(theme: self.theme, intent: self.intent, tabSize: self.tabSize, text: text)
        self.insertTab(tab, at: index, animated: animated)
    }

    ///Inserts a segment at the position you specify and gives it a title as content.
    public func insertSegment(withImage icon: UIImage?,
                              andTitle text: String?,
                              at index: Int, animated: Bool = false) {
        let tab = TabItemUIView(theme: self.theme, intent: self.intent, tabSize: self.tabSize, text: text, icon: icon)
        self.insertTab(tab, at: index, animated: animated)
    }

    ///Enables the segment you specify.
    public func setEnabled(_ isEnabled: Bool,
                           at index: Int,
                           animated: Bool = false) {
        doWithAnimation(animated) {
            self.segments[safe: index]?.isEnabled = isEnabled
        }
    }

    ///Returns whether the indicated segment is enabled.
    func isEnabledForSegment(at index: Int) -> Bool {
        self.segments[safe: index]?.isEnabled ?? false
    }


    ///Removes all segments of the segmented control.
    public func removeAllSegments() {
        self.stackView.removeArrangedSubviews()
    }

    /// Removes the segment you specify from the segmented control, optionally animating the transition.
    public func removeSegment(at index: Int, animated: Bool) {
        guard let tab = self.stackView.arrangedSubviews[safe: index] else { return }
        self.removeTab(tab, animated: animated)
    }

    ///  The index number that identifies the selected segment that the user last touched.
    public var selectedSegmentIndex: Int {
        get {
            return self.segments.firstIndex(where: {$0.isSelected == true}) ?? NSNotFound
        }
        set {
            guard newValue != self.selectedSegmentIndex else { return }
            guard newValue < self.numberOfSegments, newValue >= 0 else { return }
            self.setSelectedSegment(newValue, animated: false)
        }
    }

    // MARK: - Private Functions
    private func pressed(_ index: Int) {
        self.setSelectedSegment(index, animated: true)
        self.selectedIndexSubject.send(index)
        self.sendActions(for: .valueChanged)
        self.delegate?.segmentSelected(index: index, sender: self)
    }

    private func unselectSegment(_ index: Int) {
        self.segments[safe: index]?.backingIsSelected = false
    }

    private func segementContentChanged(_ index: Int) {
        guard let segment = self.segments[safe: index] else { return }
        segment.isHidden = segment.isEmpty
    }

    private func setSelectedSegment(_ index: Int, animated: Bool) {
        self.doWithAnimation(animated) { [weak self] in
            guard let self else { return }
            self.segments[safe: self.selectedSegmentIndex]?.backingIsSelected = false
            self.segments[safe: index]?.backingIsSelected = true
        }
    }

    private func removeTab(_ tab: UIView, animated: Bool) {
        self.doWithAnimation(animated) { [weak self] in
            self?.stackView.detachArrangedSubview(tab)
        }
    }

    private func insertTab(_ tab: UIView, at index: Int, animated: Bool) {
        self.doWithAnimation(animated) { [weak self] in
            self?.stackView.insertArrangedSubview(tab, at: index)
        }
    }

    private func doWithAnimation(_ animated: Bool, block: @escaping () -> Void) {
        if animated {
            UIView.animate(withDuration: 1,
                           delay: 0.1,
                           options: .curveEaseInOut,
                           animations: block)
        } else {
            block()
        }
    }
}

private extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        for view in subviews {
            self.addArrangedSubview(view)
        }
    }
}
