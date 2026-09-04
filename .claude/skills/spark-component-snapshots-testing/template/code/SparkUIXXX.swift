//
//  SparkUIXXX.swift
//  SparkComponentXXX
//
//  Created by robin.lemaire on 03/03/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import UIKit
@_spi(SI_SPI) import SparkCommon
import SparkTheming
import Combine

/// A xxx control that groups related content and lets users switch views on the same page.
///
/// XXXs are used to group different but related content, allowing users to navigate views without leaving the page.
/// They always contain at least two items and one xxx is active at a time.
///
/// ## Example of usage
///
/// ### With Titles
///
/// ```swift
/// let xxx = SparkUIXXX(theme: theme, titles: ["First", "Second", "Third"])
/// xxx.intent = .main
/// xxx.size = .medium
/// xxx.selectedSegmentIndex = 0
/// xxx.addAction(UIAction { _ in
///     // Your action
/// }, for: .valueChanged)
/// ```
///
/// ### With Images
///
/// ```swift
/// let images = [UIImage(systemName: "house")!, UIImage(systemName: "star")!, UIImage(systemName: "person")!]
/// let xxx = SparkUIXXX(theme: theme, images: images)
/// xxx.intent = .main
/// xxx.size = .medium
/// ```
///
/// ### With XXXUISegment
///
/// ```swift
/// let segments = [
///     XXXUISegment(title: "First", image: UIImage(systemName: "house")!),
///     XXXUISegment(title: "Second", image: UIImage(systemName: "star")!),
///     XXXUISegment(title: "Third", image: UIImage(systemName: "person")!)
/// ]
/// let xxx = SparkUIXXX(theme: theme, segments: segments)
/// xxx.intent = .main
/// xxx.size = .medium
/// ```
///
/// ## Accessibility
///
/// By default, VoiceOver reads in order:
/// - The xxx item label
/// - The current position (e.g., "1 of 3")
/// - The selection state
///
/// On accessibility sizes, a long press gesture will show an accessibility list view for easier navigation.
///
/// ## Rendering
///
/// ### Texts
///
/// ![XXX rendering.](xxx_texts.png)
///
/// ### Icons
///
/// ![XXX rendering.](xxx_icons.png)
///
/// ### With Extra View
///
/// ![XXX rendering.](xxx_extra_view.png)
///
/// ### All Values
///
/// ![XXX rendering.](xxx_all_values.png)
/// 
public final class SparkUIXXX: UIControl {

    // MARK: - Components

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.segmentsStackView,
            self.rightSpaceView
        ])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()

    private lazy var segmentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var rightSpaceView = UIView()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = false
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()

    private let lineView = UIView()

    // MARK: - Public Properties

    /// The spark theme of the xxx.
    public var theme: any Theme {
        didSet {
            self.viewModel.theme = self.theme

            for view in self.segmentViews {
                view.theme = self.theme
            }
        }
    }

    /// The intent of the xxx.
    /// Check the ``XXXIntent`` to see the **default** value.
    public var intent: XXXIntent = .default {
        didSet {
            self.viewModel.intent = self.intent

            for view in self.segmentViews {
                view.intent = self.intent
            }
        }
    }

    /// The size of the xxx.
    /// Check the ``XXXSize`` to see the **default** value.
    public var size: XXXSize = .default {
        didSet {
            self.viewModel.size = self.size

            for view in self.segmentViews {
                view.size = self.size
            }
        }
    }

    /// A Boolean value indicating whether the control is in the enabled state.
    public override var isEnabled: Bool {
        didSet {
            self.viewModel.isEnabled = self.isEnabled
        }
    }

    /// A Boolean value that controls whether the width of segments is proportioned based on content.
    /// When `true`, segments are sized proportionally to their content.
    /// When `false`, all segments have equal width.
    public var apportionsSegmentWidthsByContent: Bool = false {
        didSet {
            self.updateSegmentDistribution()
        }
    }

    /// The number of segments in the xxx control.
    public var numberOfSegments: Int {
        return self.segmentViews.count
    }

    private var _selectedSegmentIndex: Int {
        self.segmentViews.firstIndex(where: { $0.isSelected == true }) ?? XXXConstants.defaultSelectedIndex
    }

    /// The index of the currently selected xxx segment. Default is -1.
    public var selectedSegmentIndex: Int {
        get {
            self._selectedSegmentIndex
        }
        set {
            self.updateSelection(
                selectedIndex: newValue,
                animated: false
            )
        }
    }

    private let valueChangedSubject = PassthroughSubject<Int, Never>()
    /// The publisher used to notify when value changed.
    public private(set) lazy var valueChangedPublisher: AnyPublisher<Int, Never> = self.valueChangedSubject.eraseToAnyPublisher()

    // MARK: - Private Properties

    private var segmentViews: [XXXSegmentUIControl] {
        self.segmentsStackView.arrangedSubviews.compactMap {
            $0 as? XXXSegmentUIControl
        }
    }

    private var segmentsStackViewWidthConstraint: NSLayoutConstraint?

    private var accessibilityLongPressGesture: UILongPressGestureRecognizer?

    private let viewModel = XXXViewModel()
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Initialization

    /// Creates a xxx control with the specified theme and titles.
    ///
    /// - Parameters:
    ///   - theme: The theme to apply to the xxx control.
    ///   - titles: An array of titles for the xxx segments.
    ///
    /// ## Example of usage
    ///
    /// ```swift
    /// let xxx = SparkUIXXX(theme: theme, titles: ["First", "Second", "Third"])
    /// xxx.selectedSegmentIndex = 0
    /// ```
    public convenience init(theme: any Theme, titles: [String]) {
        self.init(
            theme: theme,
            segments: titles.map { .init(title: $0) }
        )
    }

    /// Creates a xxx control with the specified theme and images.
    ///
    /// - Parameters:
    ///   - theme: The theme to apply to the xxx control.
    ///   - images: An array of images for the xxx segments.
    ///
    /// ## Example of usage
    ///
    /// ```swift
    /// let images = [UIImage(systemName: "house")!, UIImage(systemName: "star")!]
    /// let xxx = SparkUIXXX(theme: theme, images: images)
    /// xxx.selectedSegmentIndex = 0
    /// ```
    public convenience init(theme: any Theme, images: [UIImage]) {
        self.init(
            theme: theme,
            segments: images.map { .init(image: $0) }
        )
    }

    /// Creates a xxx control with the specified theme and segments.
    ///
    /// - Parameters:
    ///   - theme: The theme to apply to the xxx control.
    ///   - segments: An array of ``XXXUISegment`` defining the xxx segments.
    ///
    /// ## Example of usage
    ///
    /// ```swift
    /// let segments = [
    ///     XXXUISegment(title: "First", image: UIImage(systemName: "house")!),
    ///     XXXUISegment(title: "Second", image: UIImage(systemName: "star")!)
    /// ]
    /// let xxx = SparkUIXXX(theme: theme, segments: segments)
    /// xxx.selectedSegmentIndex = 0
    /// ```
    public init(theme: any Theme, segments: [XXXUISegment]) {
        self.theme = theme

        super.init(frame: .zero)

        self.setupView(segments: segments)
    }

    /// Creates a new xxx from a storyboard or nib file.
    /// - Parameter coder: An unarchiver object.
    /// - Note: This initializer is not implemented and will cause a fatal error if called.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Setup

    private func setupView(segments: [XXXUISegment]) {
        // Add subviews
        self.addSubview(self.lineView)
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentStackView)

        // Populate the segments
        self.addSegments(segments)

        // Setup constraints
        self.setupConstraints()

        // Setup subscriptions
        self.setupSubscriptions()

        // Setup accessibility
        self.setupAccessibility()

        // Setup gesture
        self.setupGesturesRecognizer()

        // Update the UI
        self.updateSegmentDistribution()
        DispatchQueue.main.async(execute: {
            self.scrollTo(index: self.selectedSegmentIndex, animated: false)
        })

        // Load view model
        self.viewModel.setup(
            theme: self.theme,
            intent: self.intent,
            size: self.size,
            isEnabled: self.isEnabled
        )
    }

    // MARK: - Constraints

    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.setupScrollViewConstraints()
        self.setupContentStackViewConstraints()
        self.setupSegmentsStackViewConstraints()
        self.setupBackgroundLineViewConstraints()
    }

    private func setupScrollViewConstraints() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func setupContentStackViewConstraints() {
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.contentStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentStackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        ])
    }

    private func setupSegmentsStackViewConstraints() {
        self.segmentsStackView.translatesAutoresizingMaskIntoConstraints = false

        self.segmentsStackViewWidthConstraint = self.segmentsStackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
    }

    private func setupBackgroundLineViewConstraints() {
        self.lineView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.lineView.heightAnchor.constraint(equalToConstant: XXXConstants.lineHeight)
        ])
    }

    // MARK: - Accessibility

    private func setupAccessibility() {
        self.accessibilityIdentifier = XXXAccessibilityIdentifier.view
    }

    private func updateAccessibitlityValues() {
        // Update Is selected
        for (index, segmentView) in self.segmentViews.enumerated() {
            segmentView.accessibilityValue = .accessibilityLabel(
                index: index,
                count: self.numberOfSegments
            )
        }
    }

    // MARK: - Gesture

    private func setupGesturesRecognizer() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.accessibilityLongPressGestureAction(_:)))
        gesture.minimumPressDuration = 0.5
        self.addGestureRecognizer(gesture)
        self.accessibilityLongPressGesture = gesture

        self.updateGesturesRecognizer()
    }

    private func updateGesturesRecognizer() {
        let isAccessibilityCategory = self.traitCollection.preferredContentSizeCategory.isAccessibilityCategory

        self.accessibilityLongPressGesture?.isEnabled = isAccessibilityCategory
    }

    // MARK: - Actions

    private func valueChangedAction(selectedIndex: Int) {
        guard self.selectedSegmentIndex != selectedIndex else {
            return
        }

        // Scroll to the new selected segment
        self.updateSelection(
            selectedIndex: selectedIndex,
            animated: true
        )

        // Haptic feedback
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()

        // Send actions
        self.valueChangedSubject.send(selectedIndex)
        self.sendActions(for: .valueChanged)
    }

    @objc private func accessibilityLongPressGestureAction(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else {
            return
        }

        guard let viewController = self.parentViewController else {
            return
        }

        // Create custom popover view controller
        let popoverViewController = XXXAccessibilityPopoverViewController(
            segmentViews: self.segmentViews,
            selectedIndex: self.selectedSegmentIndex,
            layout: self.viewModel.layout
        ) { [weak self] selectedIndex in
            guard let self else { return }

            self.valueChangedAction(selectedIndex: selectedIndex)
        }

        popoverViewController.modalPresentationStyle = .popover

        // Configure popover
        if let popoverController = popoverViewController.popoverPresentationController {
            popoverController.sourceView = self
            popoverController.sourceRect = self.bounds
            popoverController.permittedArrowDirections = [.up, .down]
            popoverController.delegate = popoverViewController
        }

        viewController.present(popoverViewController, animated: true)
    }

    // MARK: - Update UI

    private func updateSelection(selectedIndex: Int, animated: Bool) {
        // Update Is selected
        for (index, segmentView) in self.segmentViews.enumerated() {
            segmentView.setIsSelected(selectedIndex == index, animated: animated)
        }

        // Scroll to make selected segment visible
        self.scrollTo(index: selectedIndex, animated: animated)
    }

    private func scrollTo(index: Int, animated: Bool) {
        // Scroll to make selected segment visible
        if let selectedSegment = self.segmentView(at: index) {
            let segmentFrame = selectedSegment.frame
            self.scrollView.scrollRectToVisible(segmentFrame, animated: animated)
        }
    }

    private func updateSegmentDistribution() {
        // Update distrubution
        if self.apportionsSegmentWidthsByContent {
            self.segmentsStackView.distribution = .fill
        } else {
            self.segmentsStackView.distribution = .fillEqually
        }

        // Hide right spacing
        self.rightSpaceView.isHidden = !self.apportionsSegmentWidthsByContent

        // Update all segment views
        for segmentView in self.segmentViews {
            segmentView.apportionsSegmentWidthsByContent = self.apportionsSegmentWidthsByContent
        }

        self.segmentsStackViewWidthConstraint?.isActive = !self.apportionsSegmentWidthsByContent
    }

    // MARK: - Segment Management

    private func segmentView(at index: Int) -> XXXSegmentUIControl? {
        return self.segmentViews[safe: index]
    }

    /// Sets the selected segment index with optional animation.
    ///
    /// - Parameters:
    ///   - selectedSegmentIndex: The index of the segment to select.
    ///   - animated: Whether to animate the selection change.
    public func setSelectedSegmentIndex(_ selectedSegmentIndex: Int, animated: Bool) {
        self.updateSelection(
            selectedIndex: selectedSegmentIndex,
            animated: animated
        )
    }

    private func addSegments(_ segments: [XXXUISegment]) {
        for (index, segment) in segments.enumerated() {

            let segmentView = XXXSegmentUIControl(theme: self.theme)
            segmentView.accessibilityIdentifier = XXXAccessibilityIdentifier.item(at: index)
            segmentView.setModel(segment)

            let index = self.numberOfSegments
            self.insertSegmentView(
                segmentView,
                at: index,
                animated: false
            )
        }
    }

    /// Adds a segment with the specified title at the end of the segments.
    ///
    /// - Parameters:
    ///   - title: The title for the segment.
    ///   - animated: Whether to animate the insertion.
    public func addSegment(with title: String?, animated: Bool) {
        self.insertSegment(
            with: title,
            at: self.numberOfSegments,
            animated: animated
        )
    }

    /// Adds a segment with the specified attributed title at the end of the segments.
    ///
    /// - Parameters:
    ///   - attributedTitle: The attributed title for the segment.
    ///   - animated: Whether to animate the insertion.
    public func addSegment(with attributedTitle: NSAttributedString?, animated: Bool) {
        self.insertSegment(
            with: attributedTitle,
            at: self.numberOfSegments,
            animated: animated
        )
    }

    /// Adds a segment with the specified image at the end of the segments.
    ///
    /// - Parameters:
    ///   - image: The image for the segment.
    ///   - animated: Whether to animate the insertion.
    public func addSegment(with image: UIImage?, animated: Bool) {
        self.insertSegment(
            with: image,
            at: self.numberOfSegments,
            animated: animated
        )
    }

    /// Adds a segment with the specified XXXUISegment at the end of the segments.
    ///
    /// - Parameters:
    ///   - xxxSegment: The XXXUISegment containing title and/or image for the segment.
    ///   - animated: Whether to animate the insertion.
    public func addSegment(with xxxSegment: XXXUISegment, animated: Bool) {
        self.insertSegment(
            with: xxxSegment,
            at: self.numberOfSegments,
            animated: animated
        )
    }

    /// Inserts a segment with the specified title at the given index.
    ///
    /// - Parameters:
    ///   - title: The title for the segment.
    ///   - segment: The index at which to insert the segment.
    ///   - animated: Whether to animate the insertion.
    public func insertSegment(with title: String?, at index: Int, animated: Bool) {
        let segmentView = XXXSegmentUIControl(theme: self.theme)
        segmentView.title = title

        self.insertSegmentView(segmentView, at: index, animated: animated)
    }

    /// Inserts a segment with the specified attributed title at the given index.
    ///
    /// - Parameters:
    ///   - attributedTitle: The attributed title for the segment.
    ///   - segment: The index at which to insert the segment.
    ///   - animated: Whether to animate the insertion.
    public func insertSegment(with attributedTitle: NSAttributedString?, at index: Int, animated: Bool) {
        let segmentView = XXXSegmentUIControl(theme: self.theme)
        segmentView.attributedTitle = attributedTitle

        self.insertSegmentView(segmentView, at: index, animated: animated)
    }

    /// Inserts a segment with the specified image at the given index.
    ///
    /// - Parameters:
    ///   - image: The image for the segment.
    ///   - segment: The index at which to insert the segment.
    ///   - animated: Whether to animate the insertion.
    public func insertSegment(with image: UIImage?, at index: Int, animated: Bool) {
        let segmentView = XXXSegmentUIControl(theme: self.theme)
        segmentView.image = image

        self.insertSegmentView(segmentView, at: index, animated: animated)
    }

    /// Inserts a segment with the specified XXXUISegment at the given index.
    ///
    /// - Parameters:
    ///   - xxxSegment: The XXXUISegment containing title and/or image for the segment.
    ///   - segment: The index at which to insert the segment.
    ///   - animated: Whether to animate the insertion.
    public func insertSegment(with xxxSegment: XXXUISegment, at index: Int, animated: Bool) {
        let segmentView = XXXSegmentUIControl(theme: self.theme)
        segmentView.setModel(xxxSegment)

        self.insertSegmentView(segmentView, at: index, animated: animated)
    }

    private func insertSegmentView(_ segmentView: XXXSegmentUIControl, at index: Int, animated: Bool) {
        guard index >= 0 else { return }

        // Populate the view
        segmentView.intent = self.intent
        segmentView.size = self.size
        segmentView.sizes = self.viewModel.sizes
        segmentView.layout = self.viewModel.layout
        segmentView.apportionsSegmentWidthsByContent = self.apportionsSegmentWidthsByContent

        // Setup tap gesture
        segmentView.addAction(.init(handler: { [weak self] _ in
            guard let self else { return }

            if let index = self.segmentViews.firstIndex(of: segmentView) {
                self.valueChangedAction(selectedIndex: index)
            }
        }), for: .touchUpInside)

        if animated {
            segmentView.alpha = 0
        }

        // Update selected index
        let newSelectedIndex = if index <= self.selectedSegmentIndex {
            self.selectedSegmentIndex + 1
        } else {
            self.selectedSegmentIndex
        }

        // Insert the segment
        if index < self.segmentViews.count {
            self.segmentsStackView.insertArrangedSubview(segmentView, at: index)
        } else {
            self.segmentsStackView.addArrangedSubview(segmentView)
        }

        self.updateSelection(
            selectedIndex: newSelectedIndex,
            animated: animated
        )

        // Update Accessibitility Value
        self.updateAccessibitlityValues()

        if animated {
            UIView.optionalAnimate(withDuration: XXXConstants.animationDuration) {
                segmentView.alpha = 1
            }
        }
    }

    /// Removes the segment at the specified index.
    ///
    /// - Parameters:
    ///   - index: The index of the segment to remove.
    ///   - animated: Whether to animate the removal.
    public func removeSegment(at index: Int, animated: Bool) {
        guard let segmentToRemove = self.segmentViews[safe: index] else {
            return
        }

        // Update selected index
        let newSelectedIndex = if index == self.selectedSegmentIndex {
            XXXConstants.defaultSelectedIndex
        } else if index < self.selectedSegmentIndex {
            self.selectedSegmentIndex - 1
        } else {
            self.selectedSegmentIndex
        }

        // Remove the segment
        if animated {
            UIView.optionalAnimate(
                withDuration: XXXConstants.animationDuration,
                animations: {
                    segmentToRemove.alpha = 0
                },
                completion: { _ in
                    self.removeSegment(
                        segmentToRemove,
                        newSelectedIndex: newSelectedIndex,
                        animated: animated
                    )
                })

        } else {
            self.removeSegment(
                segmentToRemove,
                newSelectedIndex: newSelectedIndex,
                animated: animated
            )
        }
    }

    /// Removes all segments from the xxx control.
    private func removeSegment(
        _ segmentView: XXXSegmentUIControl,
        newSelectedIndex: Int,
        animated: Bool
    ) {
        // Remove the segment
        self.segmentsStackView.removeArrangedSubview(segmentView)
        segmentView.removeFromSuperview()

        // Update the selection
        self.updateSelection(
            selectedIndex: newSelectedIndex,
            animated: animated
        )

        // Update Accessibitility Value
        self.updateAccessibitlityValues()
    }

    /// Removes all segments from the xxx control.
    public func removeAllSegments() {
        self.segmentsStackView.removeArrangedSubviews()

        // Update the selection
        self.selectedSegmentIndex = 0

        // Update Accessibitility Value
        self.updateAccessibitlityValues()
    }

    /// Sets the accessibility label for the segment at the specified index.
    ///
    /// - Parameters:
    ///   - accessibilityLabel: The accessibility label for the segment.
    ///   - segment: The index of the segment.
    public func setAccessibilityLabel(_ accessibilityLabel: String?, forSegmentAt index: Int) {
        self.segmentView(at: index)?.accessibilityLabel = accessibilityLabel
    }

    /// Returns the accessibility label for the segment at the specified index.
    ///
    /// - Parameter segment: The index of the segment.
    /// - Returns: The accessibility label of the segment, or nil if the segment has no accessibility label.
    public func accessibilityLabelForSegment(at index: Int) -> String? {
        return self.segmentView(at: index)?.accessibilityLabel
    }

    /// Sets the title for the segment at the specified index.
    ///
    /// - Parameters:
    ///   - title: The title for the segment.
    ///   - segment: The index of the segment.
    public func setTitle(_ title: String?, forSegmentAt index: Int) {
        self.segmentView(at: index)?.title = title
    }

    /// Returns the title for the segment at the specified index.
    ///
    /// - Parameter segment: The index of the segment.
    /// - Returns: The title of the segment, or nil if the segment has no title.
    public func titleForSegment(at index: Int) -> String? {
        return self.segmentView(at: index)?.title
    }

    /// Sets the attributed title for the segment at the specified index.
    ///
    /// - Parameters:
    ///   - attributedTitle: The attributed title for the segment.
    ///   - segment: The index of the segment.
    public func setAttributedTitle(_ attributedTitle: NSAttributedString?, forSegmentAt index: Int) {
        self.segmentView(at: index)?.attributedTitle = attributedTitle
    }

    /// Returns the title for the segment at the specified index.
    ///
    /// - Parameter segment: The index of the segment.
    /// - Returns: The title of the segment, or nil if the segment has no title.
    public func attributedTitleForSegment(at index: Int) -> NSAttributedString? {
        return self.segmentView(at: index)?.attributedTitle
    }

    /// Sets the image for the segment at the specified index.
    ///
    /// - Parameters:
    ///   - image: The image for the segment.
    ///   - segment: The index of the segment.
    public func setImage(_ image: UIImage?, forSegmentAt index: Int) {
        self.segmentView(at: index)?.image = image
    }

    /// Returns the image for the segment at the specified index.
    ///
    /// - Parameter segment: The index of the segment.
    /// - Returns: The image of the segment, or nil if the segment has no image.
    public func imageForSegment(at index: Int) -> UIImage? {
        return self.segmentView(at: index)?.image
    }

    /// Sets the extra view for the segment at the specified index.
    ///
    /// - Parameters:
    ///   - extraView: The extra view for the segment.
    ///   - segment: The index of the segment.
    public func setExtraView(_ extraView: UIView?, forSegmentAt index: Int) {
        self.segmentView(at: index)?.extraView = extraView
    }

    /// Returns the extra view for the segment at the specified index.
    ///
    /// - Parameter segment: The index of the segment.
    /// - Returns: The extra view of the segment, or nil if the segment has no extra view.
    public func extraViewForSegment(at index: Int) -> UIView? {
        return self.segmentView(at: index)?.extraView
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        // Lines Colors
        self.viewModel.$linesColors.subscribe(in: &self.subscriptions) { [weak self] linesColors in
            guard let self else { return }

            self.lineView.backgroundColor(linesColors.colorToken)

            for view in self.segmentViews {
                view.lineView.backgroundColor(linesColors.colorToken)
                view.selectedLineView.backgroundColor(linesColors.selectedColorToken)
            }
        }

        // Sizes
        self.viewModel.$sizes.subscribe(in: &self.subscriptions) { [weak self] sizes in
            guard let self else { return }

            for view in self.segmentViews {
                view.sizes = sizes
            }
        }

        // Layout
        self.viewModel.$layout.subscribe(in: &self.subscriptions) { [weak self] layout in
            guard let self else { return }

            for view in self.segmentViews {
                view.layout = layout
            }
        }

        // Dim
        self.viewModel.$dim.subscribe(in: &self.subscriptions) { [weak self] dim in
            guard let self else { return }

            self.alpha = dim
        }
    }

    // MARK: - Trait Collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self.updateGesturesRecognizer()
    }
}
