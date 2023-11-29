//
//  RatingInputUIViewDelegate.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 29.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public protocol RatingInputUIViewDelegate: AnyObject {
    /// The rating value was changed.
    /// - Parameters:
    ///   - rating: The updated rating input.
    ///   - rating: The new rating value.
    func rating(_ rating: RatingInputUIView, didChangeRating rating: CGFloat)
}
