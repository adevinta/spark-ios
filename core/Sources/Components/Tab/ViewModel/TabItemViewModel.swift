//
//  TabItemViewModel.swift
//  SparkCore
//
//  Created by alican.aycil on 24.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import Combine

final class TabItemViewModel: ObservableObject {
    
    @Published var tabStateAttributes: TabStateAttributes
    private var tabState: TabState {
        didSet {
            guard tabState != oldValue else { return }
            self.updateStateAttributes()
        }
    }
    var theme: Theme {
        didSet {
            self.updateStateAttributes()
        }
    }
    var intent: TabIntent {
        didSet {
            guard intent != oldValue else { return }
            self.updateStateAttributes()
        }
    }
    private let tabGetStateAttributesUseCase: TabGetStateAttributesUseCasable
    
    var isDisabled: Bool {
        get {
            self.tabState.isDisabled
        }
        set {
            self.tabState = TabState(isDisabled: newValue, isPressed: self.tabState.isPressed, isSelected: self.tabState.isSelected)
        }
    }
    
    var isSelected: Bool {
        get {
            self.tabState.isSelected
        }
        set {
            self.tabState = TabState(isDisabled: self.tabState.isDisabled, isPressed: self.tabState.isPressed, isSelected: newValue)
        }
    }
    
    var isPressed: Bool {
        get {
            self.tabState.isPressed
        }
        set {
            self.tabState = TabState(isDisabled: self.tabState.isDisabled, isPressed: newValue, isSelected: self.tabState.isSelected)
        }
    }
    
    init(
        theme: Theme,
        intent: TabIntent = .primary,
        isDisabled: Bool,
        isSelected: Bool,
        tabGetStateAttributesUseCase: TabGetStateAttributesUseCasable = TabGetStateAttributesUseCase()
    ) {
        let tabState = TabState(isDisabled: isDisabled, isSelected: isSelected)
        self.tabState = tabState
        self.theme = theme
        self.intent = intent
        self.tabGetStateAttributesUseCase = tabGetStateAttributesUseCase
        self.tabStateAttributes = tabGetStateAttributesUseCase.execute(
            theme: theme,
            intent: intent,
            state: tabState
        )
    }
    
    private func updateStateAttributes() {
        self.tabStateAttributes = self.tabGetStateAttributesUseCase.execute(
            theme: self.theme,
            intent: self.intent,
            state: self.tabState
        )
    }
}

