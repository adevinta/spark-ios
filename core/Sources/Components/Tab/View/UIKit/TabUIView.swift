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

    // MARK: - Private variables
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()

    private let bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        return bottomLine
    }()

    private let selectedIndexSubject = PassthroughSubject<Int, Never>()
    private let viewModel: TabViewModel<TabUIItemContent>
    private var widthConstraint: NSLayoutConstraint?
    private var bottomLineHeightConstraint: NSLayoutConstraint?
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Managing design of the segments
    /// All segements of the the tab
    public var segments: [TabItemUIView] {
        return self.stackView.arrangedSubviews
            .compactMap { view in
            return view as? TabItemUIView
        }
    }

    /// The current theme
    public var theme: Theme {
        didSet {
            self.segments.forEach { tab in
                tab.theme = theme
            }
        }
    }

    /// The current intent
    public var intent: TabIntent {
        didSet {
            self.segments.forEach { tab in
                tab.intent = intent
            }
        }
    }

    /// The current tab size
    public var tabSize: TabSize {
        didSet {
            self.segments.forEach { tab in
                tab.tabSize = tabSize
            }
            self.invalidateIntrinsicContentSize()
        }
    }

    /// Disable each segement of the tab
    public override var isEnabled: Bool {
        didSet {
            self.viewModel.isEnabled = self.isEnabled
            self.segments.forEach{ $0.isEnabled = self.isEnabled }
        }
    }

    /// Indicates the max possible width of the tab.
    public var maxWidth: CGFloat = UIScreen.main.bounds.width {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    /// Indicates whether the control attempts to adjust segment widths based on their content widths.
    public var apportionsSegmentWidthsByContent: Bool {
        get { return viewModel.apportionsSegmentWidthsByContent }
        set {
            self.viewModel.apportionsSegmentWidthsByContent = newValue
            self.segments.forEach{
                $0.apportionsSegmentWidthsByContent = newValue
            }
        }
    }

    public override var intrinsicContentSize: CGSize {
        let height = self.stackView
            .arrangedSubviews
            .filter(\.isNotHidden)
            .map(\.intrinsicContentSize.height)
            .reduce(0, max)

        let size = CGSize(width: self.maxWidth, height: height)
        return size
    }

    // MARK: - Managing interaction with the tab.
    /// An optional delegate.
    /// Chages to the current selected item of the tabs will be sent to the delegate.
    /// An alternative approach would be to add an action just like `UISegmentControl`for `valueChanged`
    /// or to subscribe to the publisher.
    public weak var delegate: TabUIViewDelegate?

    /// The index of the newly selected tab will be published.
    /// This is an alternative to using the delegate or to setting an action for `valueChanged`
    public var publisher: some Publisher<Int, Never> {
        return self.selectedIndexSubject
    }

    // MARK: - Initialization
    /// Initializer
    /// - Parameters:
    /// - theme: the current theme
    /// - intent: the tab intent. The default value is `basic`.
    /// - tabSize: The tab size, see `TabSize`. The default value is medium `md`.
    /// - titles: An array of labels.
    /// - apportionsSegmentWIdthsByContent: Indicates whether the control attempts to adjust segment widths based on their content widths.
    public convenience init(
        theme: Theme,
        intent: TabIntent = .basic,
        tabSize: TabSize = .md,
        titles: [String],
        apportionsSegmentWidthsByContent: Bool = false
    ) {
        self.init(
            theme: theme,
            intent: intent,
            tabSize: tabSize,
            content: titles.map(TabUIItemContent.init(title:)),
            apportionsSegmentWidthsByContent: apportionsSegmentWidthsByContent)
    }

    /// Initializer
    /// - Parameters:
    /// - theme: the current theme
    /// - intent: the tab intent. The default value is `basic`.
    /// - tabSize: The tab size, see `TabSize`. The default value is medium `md`.
    /// - icons: An array of images.
    /// - apportionsSegmentWIdthsByContent: Indicates whether the control attempts to adjust segment widths based on their content widths.
    public convenience init(
        theme: Theme,
        intent: TabIntent = .basic,
        tabSize: TabSize = .md,
        icons: [UIImage],
        apportionsSegmentWidthsByContent: Bool = false
    ) {
        self.init(theme: theme,
                  intent: intent,
                  tabSize: tabSize,
                  content: icons.map(TabUIItemContent.init(icon:)),
                  apportionsSegmentWidthsByContent: apportionsSegmentWidthsByContent
        )
    }

    /// Initializer
    /// - Parameters:
    /// - theme: the current theme
    /// - intent: the tab intent. The default value is `basic`.
    /// - tab size: the default value is `md`.
    /// - content: An array of TabUIItemContent with of image and string.
    /// - apportionsSegmentWIdthsByContent: Indicates whether the control attempts to adjust segment widths based on their content widths.
    public init(theme: Theme,
         intent: TabIntent = .basic,
         tabSize: TabSize = .md,
         content: [TabUIItemContent],
         apportionsSegmentWidthsByContent: Bool = false
    ) {

        self.theme = theme
        self.intent = intent
        self.tabSize = tabSize
        self.viewModel = TabViewModel(
            theme: theme,
            apportionsSegmentWidthsByContent: apportionsSegmentWidthsByContent,
            content: content)

        super.init(frame: .zero)

        self.setupViews(items: content)
        self.setupConstraints()
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self.invalidateIntrinsicContentSize()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView.alwaysBounceVertical = self.scrollView.bounds.width > self.bounds.width
    }

    // MARK: - Managing segment content

    /// Sets the content of a segment to a given image.
    public func setImage(_ image: UIImage?, forSegmentAt index: Int) {
        guard let segment = self.segments[safe: index] else { return }
        segment.icon = image
        self.viewModel.content[index].icon = image

        self.invalidateIntrinsicContentSize()
    }

    /// Returns the image for a specific segment.
    public func imageForSegment(at index: Int) -> UIImage? {
        return self.segments[safe: index]?.icon
    }

    /// Sets the title of a segment.
    public func setTitle(_ title: String?, forSegmentAt index: Int) {
        guard let segment = self.segments[safe: index] else { return }
        segment.title = title
        self.viewModel.content[index].title = title

        self.invalidateIntrinsicContentSize()
    }

    /// Returns the title of the specified segment.
    public func titleForSegment(at index: Int) -> String? {
        return self.segments[safe: index]?.title
    }

    /// Set a badge (or any UIView) on the tab at the given index.
    public func setBadge(_ badge: UIView?, forSegementAt index: Int) {
        guard let segment = self.segments[safe: index] else { return }
        segment.badge = badge
        self.invalidateIntrinsicContentSize()
    }

    /// Return the badge (any UIView) for the specific segment
    public func badgeForSegment(at index: Int) -> UIView? {
        return self.segments[safe: index]?.badge
    }

    //MARK: - Managing segment actions

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

    /// The segment at the givien index.
    public func segment(at index: Int) -> TabItemUIView? {
        return self.segments[safe: index]
    }

    /// The index of the segment with an action that has a matching identifier, or NSNotFound
    /// if no matching action is found.
    public func segmentIndex(identifiedBy identifier: UIAction.Identifier) -> Int {
        return self.segments.firstIndex(where: { $0.action?.identifier  == identifier }) ?? NSNotFound
    }

    /// Inserts a segment at the last position you specify and gives it an image as content.
    public func addSegment(with icon: UIImage,
                           animated: Bool = false) {
        let index = self.numberOfSegments
        self.viewModel.content.insert(.init(icon: icon), at: index)

        let tab = TabItemUIView(
            theme: self.theme,
            intent: self.intent,
            tabSize: self.tabSize,
            content: .init(icon: icon)
        )
        self.insertTab(tab, at: index, animated: animated)
    }

    ///Inserts a segment at the last position you specify and gives it a title as content.
    public func addSegment(with title: String,
                           animated: Bool = false) {
        let index = self.numberOfSegments
        self.viewModel.content.insert(.init(title: title), at: index)

        let tab = TabItemUIView(
            theme: self.theme,
            intent: self.intent,
            tabSize: self.tabSize,
            content: .init(title: title)
        )
        self.insertTab(tab, at: index, animated: animated)
    }

    ///Inserts a segment at the last position you specify and gives it a title as content.
    public func addSegment(withImage icon: UIImage,
                           andTitle title: String,
                           animated: Bool = false) {
        let index = self.numberOfSegments
        self.viewModel.content.insert(.init(icon: icon, title: title), at: index)

        let tab = TabItemUIView(
            theme: self.theme,
            intent: self.intent,
            tabSize: self.tabSize,
            content: .init(icon: icon, title: title)
        )
        self.insertTab(tab, at: index, animated: animated)
    }

    /// Inserts a segment at the position you specify and gives it an image as content.
    public func insertSegment(with icon: UIImage,
                              at index: Int,
                              animated: Bool = false) {
        self.viewModel.content.insert(.init(icon: icon), at: index)
        let tab = TabItemUIView(
            theme: self.theme,
            intent: self.intent,
            tabSize: self.tabSize,
            content: .init(icon: icon)
        )
        self.insertTab(tab, at: index, animated: animated)
    }

    ///Inserts a segment at the position you specify and gives it a title as content.
    public func insertSegment(with title: String,
                              at index: Int,
                              animated: Bool = false) {
        self.viewModel.content.insert(.init(title: title), at: index)
        let tab = TabItemUIView(
            theme: self.theme,
            intent: self.intent,
            tabSize: self.tabSize,
            content: .init(title: title)
        )
        self.insertTab(tab, at: index, animated: animated)
    }

    ///Inserts a segment at the position you specify and gives it a title as content.
    public func insertSegment(withImage icon: UIImage,
                              andTitle title: String,
                              at index: Int, animated: Bool = false) {
        self.viewModel.content.insert(.init(icon: icon, title: title), at: index)
        let tab = TabItemUIView(
            theme: self.theme,
            intent: self.intent,
            tabSize: self.tabSize,
            content: .init(icon: icon, title: title)
        )
        self.insertTab(tab, at: index, animated: animated)
    }

    ///Replace all current segments with segments with just icons
    public func setSegments(withImages icons: [UIImage]) {
        let content: [TabUIItemContent] = icons.map{ .init(icon: $0, title: nil) }
        self.setTabItems(content: content)
    }

    ///Replace all current segments with segments with just titles
    public func setSegments(withTitles titles: [String]) {
        let content: [TabUIItemContent] = titles.map{ .init(icon: nil, title: $0) }
        self.setTabItems(content: content)
    }

    ///Replace all current segments with segments with icons & titles
    public func setSegments(withContent content: [TabUIItemContent]) {
        self.setTabItems(content: content)
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
    public func isEnabledForSegment(at index: Int) -> Bool {
        self.segments[safe: index]?.isEnabled ?? false
    }

    ///Removes all segments of the segmented control.
    public func removeAllSegments() {
        self.stackView.removeArrangedSubviews()
    }

    /// Removes the segment you specify from the segmented control, optionally animating the transition.
    public func removeSegment(at index: Int, animated: Bool) {
        guard let tab = self.stackView.arrangedSubviews[safe: index] else { return }
        self.viewModel.content.remove(at: index)
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

    /// Scroll to the selected segment
    public func scrollToSelectedSegement(animated: Bool) {
        let frame = self.segments[self.selectedSegmentIndex].frame

        if scrollView.bounds.contains(frame) {
            return
        }

        var point = CGPoint.zero
        if frame.minX < self.scrollView.contentOffset.x {
            point.x = frame.minX
        } else if frame.maxX > self.scrollView.frame.maxX {
            point.x = frame.maxX - self.scrollView.frame.maxX
        }
        self.scrollView.setContentOffset(point, animated: animated)
    }

    // MARK: - Private Functions
    private func setupViews(items: [TabUIItemContent]) {
        let tabItemViews = items.map{ item in
            return TabItemUIView(
                theme: theme,
                intent: intent,
                tabSize: tabSize,
                content: .init(icon: item.icon, title: item.title),
                apportionsSegmentWidthsByContent: self.apportionsSegmentWidthsByContent
            )
        }

        for (index, tabItem) in tabItemViews.enumerated() {
            self.setupTabActions(for: tabItem, index: index)
        }
        self.stackView.addArrangedSubviews(tabItemViews)

        self.addSubviewSizedEqually(scrollView)
        self.scrollView.addSubview(self.bottomLine)
        self.bottomLine.backgroundColor = self.viewModel.tabsAttributes.lineColor.uiColor

        self.scrollView.addSubview(self.stackView)
        self.scrollView.bringSubviewToFront(self.stackView)

        self.selectedSegmentIndex = 0
        self.updateAccessibilityIdentifiers()

        self.scrollView.backgroundColor = self.viewModel.tabsAttributes.backgroundColor.uiColor
    }

    private func setupConstraints() {
        let scrollContentGuide = self.scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(lessThanOrEqualTo: scrollContentGuide.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
            self.bottomLine.leadingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.leadingAnchor),
            self.bottomLine.trailingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.trailingAnchor),
            self.bottomLine.bottomAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.bottomAnchor)
        ])

        self.bottomLineHeightConstraint = self.bottomLine.heightAnchor.constraint(equalToConstant: self.viewModel.tabsAttributes.lineHeight)
        self.bottomLineHeightConstraint?.isActive = true

        self.widthConstraint = self.stackView.widthAnchor.constraint(greaterThanOrEqualTo: self.widthAnchor)
        if !self.apportionsSegmentWidthsByContent {
            self.widthConstraint?.isActive = true
        }

        stackView.distribution = self.apportionsSegmentWidthsByContent ? .fill : .fillEqually
    }

    private func setTabItems(content: [TabUIItemContent]) {
        self.viewModel.content = content

        let items = content.map {
            TabItemUIView(
                theme: self.theme,
                intent: self.intent,
                tabSize: self.tabSize,
                content: $0
            )
        }
        self.stackView.removeArrangedSubviews()
        self.stackView.addArrangedSubviews(items)

        self.updateAccessibilityIdentifiers()
        self.invalidateIntrinsicContentSize()

        for (index, item) in items.enumerated() {
            self.setupTabActions(for: item, index: index)
        }
    }

    private func setupTabActions(for tabItem: TabItemUIView, index: Int) {
        let pressedAction = UIAction { [weak self] _ in
            self?.pressed(index)
        }
        let unselectAction = UIAction { [weak self] _ in
            self?.unselectSegment(index)
        }
        tabItem.addAction(pressedAction, for: .touchUpInside)
        tabItem.addAction(unselectAction, for: .otherSegmentSelected)
    }

    private func setupSubscriptions() {
        self.viewModel.$tabsAttributes.subscribe(in: &self.subscriptions) { [weak self] tabAttributes in
            guard let self else { return }

            self.bottomLineHeightConstraint?.constant = tabAttributes.lineHeight
            self.bottomLine.backgroundColor = tabAttributes.lineColor.uiColor
            self.scrollView.backgroundColor = tabAttributes.backgroundColor.uiColor
        }

        self.viewModel.$apportionsSegmentWidthsByContent.subscribe(in: &self.subscriptions) { [weak self] useContentWidth in
            guard let self else { return }

            self.widthConstraint?.isActive = !useContentWidth
            self.stackView.distribution = useContentWidth ? .fill : .fillEqually
            self.setNeedsUpdateConstraints()

        }
    }

    private func pressed(_ index: Int) {
        self.setSelectedSegment(index, animated: true)
        self.scrollToSelectedSegement(animated: true)
        self.selectedIndexSubject.send(index)
        self.sendActions(for: .valueChanged)
        self.delegate?.segmentSelected(index: index, sender: self)
    }

    private func unselectSegment(_ newSelected: Int) {
        for (index, segment) in segments.enumerated() {
            guard index != newSelected else { return }
            segment.backingIsSelected = false
        }
    }

    private func setSelectedSegment(_ index: Int, animated: Bool = false) {
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
        self.updateAccessibilityIdentifiers()
        self.invalidateIntrinsicContentSize()
    }

    private func insertTab(_ tab: TabItemUIView, at index: Int, animated: Bool) {
        self.setupTabActions(for: tab, index: index)
        self.doWithAnimation(animated) { [weak self] in
            self?.stackView.insertArrangedSubview(tab, at: index)
        }
        self.updateAccessibilityIdentifiers()
        self.invalidateIntrinsicContentSize()
    }

    private func updateAccessibilityIdentifiers() {
        for (index, tabItem) in segments.enumerated() {
            tabItem.accessibilityIdentifier = "\(TabAccessibilityIdentifier.tabItem)-\(index)"
        }
    }

    private func doWithAnimation(_ animated: Bool, block: @escaping () -> Void) {
        if animated {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: block)
        } else {
            block()
        }
    }
}
