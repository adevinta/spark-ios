//
//  EventPublisher.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 29.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

// MARK: - Methods
extension UIControl {
    func publisher(for event: Event) -> EventPublisher {
        EventPublisher(control: self, event: event)
    }
}

// MARK: - Publisher
extension UIControl {
    public struct EventPublisher: Publisher {
        // MARK: - Result
        public typealias Output = UIControl
        public typealias Failure = Never

        // MARK: - Properties
        var control: UIControl
        var event: Event

        // MARK: - Initialize
        public init(control: UIControl, event: Event) {
            self.control = control
            self.event = event
        }

        // MARK: - Methods
        public func receive<S: Subscriber>(
            subscriber: S
        ) where S.Input == Output, S.Failure == Failure {
            let subscription = EventSubscription<S>(
                target: subscriber,
                control: self.control,
                event: self.event
            )
            subscriber.receive(subscription: subscription)
        }
    }
}

// MARK: - Event subscription
class EventSubscription<Target: Subscriber>: Subscription where Target.Input == UIControl {
    // MARK: - Properties
    var target: Target?
    weak var control: UIControl?
    var event: UIControl.Event

    // MARK: - Initialize
    init(
        target: Target? = nil,
        control: UIControl,
        event: UIControl.Event
    ) {
        self.target = target
        self.control = control
        self.event = event

        control.addTarget(
            self,
            action: #selector(controlEventAction),
            for: self.event
        )
    }

    // MARK: - Methods
    func request(_ demand: Subscribers.Demand) {}

    func cancel() {
        self.control?.removeTarget(self, action: #selector(controlEventAction(sender:)), for: self.event)
        self.target = nil
        self.control = nil
    }

    @objc func controlEventAction(sender: UIControl) {
        _ = self.target?.receive(sender)
    }
}
