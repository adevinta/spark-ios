//
//  ProgressTrackerUITouchHandler.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 12.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import Foundation
import UIKit

/// Touch handling for the progress tracker.
/// There are four different typs of touch handler:
/// - ProgressTrackerNoneUITouchHandler. This ignores all touch events
/// - ProgressTrackerDiscreteUITouchHandler: This handles touches for discrete interaction. It is only possible to step from one page to the next with one interaction.
/// - ProgressTrackerContinuousUITouchHandler: This handles continuous (drag) interaction. It is possible to step from one page to the next, and then the following, etc. in one interaction. It is not possible to skip a step and all steps will be published.
/// - ProgressTrackerIndependentUITouchHandler: This handles touches quite similar to the discrete, but it is possible to skip steps.
protocol ProgressTrackerUITouchHandling {
    /// The current page being tracked by the touch event
    var trackingPageIndex: Int? { get }
    /// The current page will be published to the current page publisher
    var currentPagePublisher: any Publisher<Int, Never> { get }

    /// Handle begin tracking
    func beginTracking(location: CGPoint)

    /// Handle continue tracking
    func continueTracking(location: CGPoint)

    /// Handle end tracking
    func endTracking(location: CGPoint)
}

/// A helper extention to return a touch handler matching the interaction state
extension ProgressTrackerInteractionState {
    func touchHandler(currentPageIndex: Int, indicatorViews: [UIControl]) -> ProgressTrackerUITouchHandling {
        switch self {
        case .none: return ProgressTrackerNoneUITouchHandler()
        case .continuous: return ProgressTrackerContinuousUITouchHandler(currentPageIndex: currentPageIndex, indicatorViews: indicatorViews)
        case .discrete: return ProgressTrackerDiscreteUITouchHandler(currentPageIndex: currentPageIndex, indicatorViews: indicatorViews)
        case .independent: return ProgressTrackerIndependentUITouchHandler(currentPageIndex: currentPageIndex, indicatorViews: indicatorViews)
        }
    }
}

/// The root touch handler from which others inherit.
class ProgressTrackerUITouchHandler: ProgressTrackerUITouchHandling {

    /// The current page being tracked by the touch event
    var trackingPageIndex: Int? {
        didSet {
            if let formerPageIndex = oldValue {
                self.indicatorViews[formerPageIndex].isHighlighted = false
            }
            if let newIndex = self.trackingPageIndex {
                self.indicatorViews[newIndex].isHighlighted = true
            }
        }
    }

    /// The current page index
    var currentPageIndex: Int {
        get {
            return self.currentPageSubject.value
        }
        set {
            self.currentPageSubject.send(newValue)
        }
    }

    /// The number of pages
    var numberOfPages: Int {
        return indicatorViews.count
    }

    /// The indicator views, each representing a page
    var indicatorViews: [UIControl] = []

    /// Changes to the current page are published to the publisher
    private var currentPageSubject: CurrentValueSubject<Int, Never>
    var currentPagePublisher: any Publisher<Int, Never> {
        return self.currentPageSubject.dropFirst()
    }

    // MARK: Initialization
    fileprivate init(currentPageIndex: Int,
         indicatorViews: [UIControl]) {
        self.currentPageSubject = .init(currentPageIndex)
        self.indicatorViews = indicatorViews
    }

    func beginTracking(location: CGPoint) {
        self.trackingPageIndex = self.trackingIndex(closestTo: location)
    }

    /// Continue tracking is handled in each tracker seperately
    func continueTracking(location: CGPoint) {   }

    /// Tracking has finished.
    func endTracking(location: CGPoint) {
        if self.indicatorViews.index(closestTo: location) != self.currentPageIndex, let index = self.trackingPageIndex {
            self.updateCurrentPageTrackingIndex(index)
        }

        self.trackingPageIndex = nil
    }

    /// Set the new current page
    fileprivate func updateCurrentPageTrackingIndex(_ index: Int) {
        self.currentPageIndex = index
    }

    /// Return the index of the indicator closest the current page
    fileprivate func trackingIndex(closestTo location: CGPoint) -> Int? {
        if let index = self.indicatorViews.index(closestTo: location), index != self.currentPageIndex {
            let trackingPageIndex = index < self.currentPageIndex ? max(0, self.currentPageIndex - 1) : min(self.numberOfPages - 1, self.currentPageIndex + 1)
            return trackingPageIndex
        }
        return nil
    }
}

/// The `none` touch handler ignores all touch events
final class ProgressTrackerNoneUITouchHandler: ProgressTrackerUITouchHandling {
    var trackingPageIndex: Int?
    
    private var voidSubject = PassthroughSubject<Int, Never>()
    var currentPagePublisher: any Publisher<Int, Never> {
        return self.voidSubject
    }

    func beginTracking(location: CGPoint) {}
    
    func continueTracking(location: CGPoint) {}
    
    func endTracking(location: CGPoint) {}
}

/// With the `independent` touch handler,  steps in the progress tracker may be skipped.
final class ProgressTrackerIndependentUITouchHandler: ProgressTrackerUITouchHandler {

    override func beginTracking(location: CGPoint) {
        let index = self.indicatorViews.index(closestTo: location)
        if index != self.currentPageIndex {
            self.trackingPageIndex = index
        }
    }

    override func continueTracking(location: CGPoint) {
        if let index = self.trackingPageIndex {
            self.indicatorViews[index].isHighlighted = true
        }
    }
}

/// With the `discrete` touch handler, only those steps next to the current selected index may be selected.
class ProgressTrackerDiscreteUITouchHandler: ProgressTrackerUITouchHandler  {

    override func continueTracking(location: CGPoint) {
        if self.indicatorViews.index(closestTo: location) == self.currentPageIndex {
            self.trackingPageIndex = nil
        } else if self.trackingPageIndex == nil, let index = self.trackingIndex(closestTo: location) {
            self.trackingPageIndex = index
        } else if let index = self.trackingPageIndex {
            self.indicatorViews[index].isHighlighted = true
        }
    }
}

/// With the `continuous` touch handler, multipe steps can be published by dragging across the view. Each single step will be published.
final class ProgressTrackerContinuousUITouchHandler: ProgressTrackerDiscreteUITouchHandler {

    override func continueTracking(location: CGPoint) {

        if self.indicatorViews.index(closestTo: location) == self.currentPageIndex {
            self.trackingPageIndex = nil
        } else if let trackingPageIndex = self.trackingPageIndex {
            if let nextIndex = self.nextTrackingIndex(closestTo: location) {
                self.updateCurrentPageTrackingIndex(trackingPageIndex)
                self.trackingPageIndex = nextIndex
            } else {
                self.indicatorViews[trackingPageIndex].isHighlighted = true
            }
        } else {
            super.continueTracking(location: location)
        }
    }

    private func nextTrackingIndex(closestTo location: CGPoint) -> Int? {
        guard let trackingPageIndex = self.trackingPageIndex else { return nil }

        guard let index = self.indicatorViews.index(closestTo: location), index != self.currentPageIndex,
              index != trackingPageIndex else
        { return nil }

        let nextTrackingPageIndex = index < trackingPageIndex ? max(0, trackingPageIndex - 1) : min(self.numberOfPages - 1, trackingPageIndex + 1)

        return nextTrackingPageIndex
    }

}
