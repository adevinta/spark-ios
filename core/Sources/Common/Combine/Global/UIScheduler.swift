//
//  UIScheduler.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation

/// Combine custom scheduler which schedule action in DispatchQueue.main
struct UIScheduler: Scheduler {

    // MARK: - Type Alias

    typealias SchedulerOptions = Never
    typealias SchedulerTimeType = DispatchQueue.SchedulerTimeType

    // MARK: - Static Properties

    /// Shared instance
    static let shared = Self()

    // MARK: - Public Properties

    /// This scheduler's definition of the current moment in time.
    var now: SchedulerTimeType { self.dispatchQueue.now }
    /// The minimum tolerance allowed by the scheduler.
    var minimumTolerance: SchedulerTimeType.Stride { self.dispatchQueue.minimumTolerance }

    // MARK: - Private Properties

    private let dispatchQueue: DispatchQueue
    private let key = DispatchSpecificKey<UInt8>()
    private let value: UInt8 = 0

    // MARK: - Initialization

    private init(dispatchQueue: DispatchQueue = .main) {
        self.dispatchQueue = dispatchQueue
        self.dispatchQueue.setSpecific(key: self.key, value: self.value)
    }

    // MARK: - Schedule

    /// Performs the action at the next possible opportunity. Maybe immediat if we don't need to change thread
    func schedule(options _: SchedulerOptions? = nil, _ action: @escaping () -> Void) {
        if DispatchQueue.getSpecific(key: self.key) == self.value {
            action()
        } else {
            self.dispatchQueue.schedule(action)
        }
    }

    /// Performs the action at some time after the specified date.
    func schedule(
        after date: SchedulerTimeType,
        tolerance: SchedulerTimeType.Stride,
        options _: SchedulerOptions? = nil,
        _ action: @escaping () -> Void
    ) {
        self.dispatchQueue.schedule(after: date, tolerance: tolerance, options: nil, action)
    }

    /// Performs the action at some time after the specified date, at the specified frequency, optionally taking into account tolerance if possible.
    func schedule(
        after date: SchedulerTimeType,
        interval: SchedulerTimeType.Stride,
        tolerance: SchedulerTimeType.Stride,
        options _: SchedulerOptions? = nil,
        _ action: @escaping () -> Void
    ) -> Cancellable {
        self.dispatchQueue.schedule(after: date, interval: interval, tolerance: tolerance, options: nil, action)
    }
}
