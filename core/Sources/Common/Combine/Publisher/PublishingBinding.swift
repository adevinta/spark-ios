//
//  PublishingBinding.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 24.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI

protocol PublishingBinding {
    var publisher: any Publisher<Bool, Never> { get }
}

final class PublisherBinding<ID: Equatable & CustomStringConvertible>: PublishingBinding {
    let id: ID
    var selectedID: ID?

    private lazy var binding = Binding<ID?>(
        get: { self.selectedID },
        set: { newValue in
            self.selectedID = newValue
        }
    )

    private lazy var publishedBinding = PublishedBinding<ID>(binding: self.binding, id: self.id)

    var publisher: any Publisher<Bool, Never> {
        return publishedBinding.publisher
    }

    var wrappedBinding: Binding<ID?> {
        return self.publishedBinding.wrappedBinding
    }

    init(id: ID, selectedID: ID?) {
        self.id = id
        self.selectedID = selectedID
    }
}

final class PublishedBinding<ID: Equatable & CustomStringConvertible>: PublishingBinding {
    let binding: Binding<ID?>
    let id: ID

    lazy var wrappedBinding = Binding<ID?>(
        get: { self.binding.wrappedValue },
        set: { newValue in
            self.binding.wrappedValue = newValue
            self.subject.send(self.binding.wrappedValue == self.id)
        }
    )

    var publisher: any Publisher<Bool, Never> {
        return self.subject
    }
    private var subject = PassthroughSubject<Bool, Never>()

    init(binding: Binding<ID?>, id: ID) {
        self.binding = binding
        self.id = id
    }
}
