//
//  Publisher-Subscribe.swift
//  SparkCore
//
//  Created by michael.zimmermann on 05.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation

extension Publisher where Failure == Never {
    func subscribe<S>(
        in subscriptions: inout Set<AnyCancellable>,
        on scheduler: S = RunLoop.main,
        action: @escaping (Self.Output) -> Void ) where S: Scheduler {

            self
                .receive(on: RunLoop.main)
                .sink { value in
                    action(value)
                }
                .store(in: &subscriptions)
    }
}
