//
//  TabItemViewModel.swift
//  SparkCore
//
//  Created by alican.aycil on 24.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit


/// `TabItemViewModel` is the view model for both the SwiftUI `TabItemView` as well as the UIKit `TabItemUIView`.
/// The view model is responsible for returning the varying attributes to the views, i.e. colors and attributes. These are determined by the theme, intent, tabState, content and tabGetStateAttributesUseCase.
/// When the theme, intent, states or contents change the new values are calculated and published.
final class TabItemViewModel: ObservableObject {

    // MARK: - Private Properties
    private var tabState: TabState {
        didSet {
            guard tabState != oldValue else { return }
            self.updateStateAttributes()
        }
    }
    
    private let tabGetStateAttributesUseCase: TabGetStateAttributesUseCasable
    
    // MARK: Properties
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

    var tabSize: TabSize {
        didSet {
            guard self.tabSize != oldValue else { return }
            self.updateStateAttributes()
        }
    }


    var isEnabled: Bool {
        get {
            self.tabState.isEnabled
        }
        set {
            self.tabState = self.tabState.update(\.isEnabled, value: newValue)
        }
    }

    var isSelected: Bool {
        get {
            self.tabState.isSelected
        }
        set {
            self.tabState = self.tabState.update(\.isSelected, value: newValue)
        }
    }

    var isPressed: Bool {
        get {
            self.tabState.isPressed
        }
        set {
            self.tabState = self.tabState.update(\.isPressed, value: newValue)
        }
    }

    var hasTitle: Bool {
        didSet {
            self.updateStateAttributes()
        }
    }

    // MARK: Published Properties
    @Published var tabStateAttributes: TabStateAttributes
//    @Published var content: TabUIItemContentable
    
    // MARK: Init
    /// Init
    /// Parameters:
    /// - theme: the current `Theme`
    /// - intent: the `TabIntent`, which will determine the color of the tab item's tint color
    /// - tabState: the `TabState` determines the current state of the tab.
    /// - content: the `TabUIItemContent` contents of the tab item:
    /// - tabGetStateAttributesUseCase: `TabGetStateAttributesUseCasable` has a default value `TabGetStateAttributesUseCase`
    init(
        theme: Theme,
        intent: TabIntent = .main,
        tabSize: TabSize = .md,
        tabState: TabState = .init(),
        hasTitle: Bool = true,
        tabGetStateAttributesUseCase: TabGetStateAttributesUseCasable = TabGetStateAttributesUseCase()
    ) {
        self.tabState = tabState
        self.theme = theme
        self.intent = intent
        self.hasTitle = hasTitle
        self.tabSize = tabSize
        self.tabGetStateAttributesUseCase = tabGetStateAttributesUseCase

        self.tabStateAttributes = tabGetStateAttributesUseCase.execute(
            theme: theme,
            intent: intent,
            state: tabState,
            tabSize: tabSize,
            hasTitle: false
        )
    }

    // MARK: - Private functions
    private func updateStateAttributes() {
        self.tabStateAttributes = self.tabGetStateAttributesUseCase.execute(
            theme: self.theme,
            intent: self.intent,
            state: self.tabState,
            tabSize: self.tabSize,
            hasTitle: self.hasTitle
        )
    }
}
