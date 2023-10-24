//
//  ComponentUIViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 25/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation

class ComponentUIViewModel {

    // MARK: - Properties

    let identifier: String
    lazy var configurationViewModel: ComponentsConfigurationUIViewModel = {
        var itemsViewModel = self.configurationItemsViewModel()
        itemsViewModel.append(self.spaceContainerTypeConfigurationItemViewModel)

        return .init(itemsViewModel: itemsViewModel)
    }()

    lazy var showSpaceContainerTypeSheet = self.showSpaceContainerTypeSheetSubject.eraseToAnyPublisher()
    private var showSpaceContainerTypeSheetSubject: PassthroughSubject<[SpaceContainerType], Never> = .init()

    @Published var spaceContainerType: SpaceContainerType = .none

    lazy var spaceContainerTypeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Space Container",
            type: .button,
            target: (source: self, action: #selector(self.presentSpaceContainerTypeSheet))
        )
    }()

    // MARK: - Initialization

    init(
        identifier: String
    ) {
        self.identifier = identifier
    }

    // MARK: - Methods

    func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return []
    }

    // MARK: - Navigation

    @objc func presentSpaceContainerTypeSheet() {
        self.showSpaceContainerTypeSheetSubject.send(SpaceContainerType.allCases)
    }
}
