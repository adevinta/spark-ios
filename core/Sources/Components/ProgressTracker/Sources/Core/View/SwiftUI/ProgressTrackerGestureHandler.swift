//
//  ProgressTrackerGestureHandler.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 21.03.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

// MARK: - Protocol
/// Touch handlers of the swiftui progress tracker
protocol ProgressTrackerGestureHandling {
    func onChanged(location: CGPoint)
    func onEnded(location: CGPoint)
    func onCancelled()
}

/// A gesture handler that has no actions.
final class ProgressTrackerNoneGestureHandler: ProgressTrackerGestureHandling {
    func onChanged(location: CGPoint) {}
    func onEnded(location: CGPoint) {}
    func onCancelled() {}
}

/// An `abstract` gesture  handler.
class ProgressTrackerGestureHandler: ProgressTrackerGestureHandling {

    @Binding var currentPageIndex: Int
    @Binding var currentTouchedPageIndex: Int?
    let indicators: [CGRect]
    let frame: CGRect
    let disabledIndeces: Set<Int>

    init(currentPageIndex: Binding<Int>,
         currentTouchedPageIndex: Binding<Int?>,
         indicators: [CGRect],
         frame: CGRect,
         disabledIndices: Set<Int>
    ) {
        self._currentPageIndex = currentPageIndex
        self._currentTouchedPageIndex = currentTouchedPageIndex
        self.indicators = indicators
        self.frame = frame
        self.disabledIndeces = disabledIndices
    }

    func onChanged(location: CGPoint) {}
    func onEnded(location: CGPoint) {}
    func onCancelled() {}
}

/// A gesture handler, that let's the user access any page of the page tracker
final class ProgressTrackerIndependentGestureHandler: ProgressTrackerGestureHandler {

    override func onChanged(location: CGPoint) {
        guard self.frame.contains(location) else {
            self.currentTouchedPageIndex = nil
            return
        }

        let index = self.indicators.index(closestTo: location)
        if let index,
            self.currentTouchedPageIndex == nil,
           !self.disabledIndeces.contains(index)
        {
            self.currentTouchedPageIndex = index
        }
    }

    override func onEnded(location: CGPoint) {
        guard self.frame.contains(location) else {
            self.currentTouchedPageIndex = nil
            return
        }

        guard let currentTouchedPageIndex else {
            return
        }
        self.currentPageIndex = currentTouchedPageIndex
        self.currentTouchedPageIndex = nil
    }

    override func onCancelled() {
        self.currentTouchedPageIndex = nil
    }
}

/// A gesture handler that only allows access to the direct neighboring pages and one one page change is allowed during one touch handling.
final class ProgressTrackerDiscreteGestureHandler: ProgressTrackerGestureHandler {

    override func onChanged(location: CGPoint) {
        guard self.frame.contains(location) else {
            self.currentTouchedPageIndex = nil
            return
        }

        guard let index = self.indicators.index(closestTo: location) else { return }

        let currentPressedPageIndex: Int?

        if index > self.currentPageIndex {
            currentPressedPageIndex = self.currentPageIndex + 1
        } else if index < self.currentPageIndex {
            currentPressedPageIndex = self.currentPageIndex - 1
        } else {
            currentPressedPageIndex = nil
        }

        if let nextIndex = currentPressedPageIndex, self.disabledIndeces.contains(nextIndex) {
            return
        }

        if self.currentTouchedPageIndex != currentPressedPageIndex {
            self.currentTouchedPageIndex = currentPressedPageIndex
        }
    }

    override func onEnded(location: CGPoint) {
        guard self.frame.contains(location) else {
            self.currentTouchedPageIndex = nil
            return
        }

        guard let currentTouchedPageIndex else { return }

        self.currentPageIndex = currentTouchedPageIndex
        self.currentTouchedPageIndex = nil
    }

    override func onCancelled() {
        self.currentTouchedPageIndex = nil
    }

}

/// A gesture handler, that allows the user to swipe across all indicators of the progress tracker and switch from one page to the next in one `drag` gesture.
final class ProgressTrackerContinuousGestureHandler: ProgressTrackerGestureHandler {

    override func onChanged(location: CGPoint) {
        guard self.frame.contains(location) else {
            self.currentTouchedPageIndex = nil
            return
        }

        guard let index = self.indicators.index(closestTo: location) else { return }

        if let currentTouchedPageIndex {
            let nextPageIndex: Int?
            if index > currentTouchedPageIndex {
                nextPageIndex = currentTouchedPageIndex + 1
            } else if index < currentTouchedPageIndex {
                nextPageIndex = currentTouchedPageIndex - 1
            } else {
                nextPageIndex = nil
            }

            if let nextPageIndex, self.disabledIndeces.contains(nextPageIndex) {
                return
            } else if let nextPageIndex {
                self.currentPageIndex = currentTouchedPageIndex
                self.currentTouchedPageIndex = nextPageIndex
            }

        } else {
            let currentPressedPageIndex: Int?

            if index > self.currentPageIndex {
                currentPressedPageIndex = self.currentPageIndex + 1
            } else if index < self.currentPageIndex {
                currentPressedPageIndex = self.currentPageIndex - 1
            } else {
                currentPressedPageIndex = nil
            }

            if let currentPressedPageIndex, self.disabledIndeces.contains(currentPressedPageIndex) {
                return
            } else if self.currentTouchedPageIndex != currentPressedPageIndex {
                self.currentTouchedPageIndex = currentPressedPageIndex
            }
        }
    }

    override func onEnded(location: CGPoint) {
        guard self.frame.contains(location) else {
            self.currentTouchedPageIndex = nil
            return
        }

        guard let currentTouchedPageIndex else { return }

        self.currentPageIndex = currentTouchedPageIndex
        self.currentTouchedPageIndex = nil
    }

    override func onCancelled() {
        self.currentTouchedPageIndex = nil
    }
}
