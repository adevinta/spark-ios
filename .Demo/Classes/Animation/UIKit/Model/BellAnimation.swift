//
//  BellAnimation.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

public extension UIView {

    // TODO: comment
    class func sparkAnimate(
        withType type: SparkAnimationType,
        on views: UIView...,
        delay: TimeInterval = .zero,
        repeat: Bool = false,
        completion: ((Bool) -> Void)? = nil
    ) {
        switch type {
        case .bell:
            UIView.bellAnimation(
                on: views,
                delay: delay,
                repeat: `repeat`,
                completion: completion
            )
        }
    }
}

// TODO: move in another class
internal extension UIView {

    class func bellAnimation(
        on views: [UIView],
        delay: TimeInterval,
        repeat: Bool,
        completion: ((Bool) -> Void)?
    ) {
        // TODO: found a way
        var isFirstAnimation = true
        func animation() {
            print("LOGROB bell animation S1")
            UIView.animate(
                withDuration: 0.1,
                delay: isFirstAnimation ? delay : 2.0,
                animations: {
                    for view in views {
                        view.transform = .init(rotationAngle: Double.pi * 0.075)
                    }
                }, completion: { _ in
                    print("LOGROB bell animation S2")
                    UIView.animate(
                        withDuration: 2.0,
                        delay: .zero,
                        usingSpringWithDamping: 0.1,
                        initialSpringVelocity: 0,
                        options: .curveEaseInOut,
                        animations: {
                            for view in views {
                                view.transform = CGAffineTransformIdentity
                            }
                        }, completion: { result in
                            print("LOGROB bell animation S3")
                            // Restart the animation if needed
                            if `repeat` {
                                isFirstAnimation = false
                                animation()
                            } else {
                                completion?(result)
                            }
                        }
                    )
                }
            )
        }

        // Start the animation
        animation()
    }
}







// TODO: remove !
public final class RotateWithDampingAnimation: SparkAnimation {

    // MARK: - Properties

    private var views: [UIView]? // TODO: must be a weak
    private var inProgress: Bool = true
    private var counter: Int = 0
    private var limit: Int?

    // MARK: - Initialization

    public init(from views: UIView...) {
        self.views = views
    }

    public func start() {
        self.resetCounter()
        self.inProgress = true
        self.load()
    }

    public func start(with limit: Int) {
        self.counter = 0
        self.limit = limit
        self.inProgress = true
        self.load()
    }

    private func load() {
        guard let views else { return }
        var limitIsOver = false
        if let limit {
            limitIsOver = self.counter >= limit
        }

        guard self.inProgress, !limitIsOver else { return }
        UIView.animate(
            withDuration: 0.1,
            delay: 1.0,
            animations: {
                for view in views {
                    view.transform = .init(rotationAngle: Double.pi * 0.075)
                }
            }, completion: { [weak self] _ in
                guard let self else { return }
                UIView.animate(
                    withDuration: 2.0,
                    delay: .zero,
                    usingSpringWithDamping: 0.1,
                    initialSpringVelocity: 0,
                    options: .curveEaseInOut,
                    animations: {
                        for view in views {
                            view.transform = CGAffineTransformIdentity
                        }
                    }, completion: { [weak self] _ in
                        guard let self else { return }
                        self.counter += 1
                        if self.inProgress {
                            self.load()
                        }
                    }
                )
            }
        )
    }

    public func stop() {
        self.resetCounter()
        self.inProgress = false
        for view in self.views ?? [] {
            view.layer.removeAllAnimations()
        }
    }

    private func resetCounter() {
        self.counter = 0
        self.limit = nil
    }
}
