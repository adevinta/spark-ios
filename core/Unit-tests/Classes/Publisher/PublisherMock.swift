//
//  PublisherMock.swift
//  Spark
//
//  Created by robin.lemaire on 31/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation

final class PublisherMock<T: Publisher> {

    // MARK: - Properties

    private let publisher: T
    let name: String
    var sinkValue: T.Output?
    var sinkValues = [T.Output]()
    var sinkCount = 0
    var sinkCalled: Bool {
        return self.sinkCount > 0
    }

    // MARK: - Initialization

    init(
        publisher: T,
        name: String = String(describing: T.Output.self)
    ) {
        self.publisher = publisher
        self.name = name
    }

    // MARK: - Methods

    func reset() {
        self.sinkValue = nil
        self.sinkValues.removeAll()
        self.sinkCount = 0
    }
}

// MARK: - Tests Management

extension PublisherMock where T.Failure == Never {

    func loadTesting(on subscriptions: inout Set<AnyCancellable>) {
        self.publisher.sink { value in
            self.sinkValue = value
            self.sinkValues.append(value)
            self.sinkCount += 1
        }.store(in: &subscriptions)
    }
}
