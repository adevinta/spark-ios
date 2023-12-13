//
//  Scenario.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 11.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest

typealias UITestClosure = (XCUIApplication) -> Void

final class AppLauncher {

    static var shared = AppLauncher()
    let app = XCUIApplication()
    private var isLaunched: Bool = false

    private init() {}

    func launch() {
        guard !self.isLaunched else { return }
        self.isLaunched = true
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait

        app.launch()
    }

}

func Scenario(_ message: String, @GivenWhenThenBuilder builder: () -> GivenWhenThen) {
    AppLauncher.shared.launch()
    XCTContext.runActivity(named: message) {_ in
        builder().validate(AppLauncher.shared.app)
    }
}

@resultBuilder
enum GivenWhenThenBuilder {
    static func buildBlock(_ given: Given, _ when: When, _ then: Then) -> GivenWhenThen {
        GivenWhenThen(given: given, when: when, then: then)
    }
}

@resultBuilder
enum GivenBuilder {
    static func buildBlock(_ components: UITestClosure...) -> [UITestClosure] {
        components
    }

    static func buildOptional(_ component: [UITestClosure]?) -> [UITestClosure] {
        component ?? []
    }
}

//@resultBuilder
//enum ThenBuilder {
//    static func buildBlock(_ components: UITestPredicate...) -> [UITestPredicate] {
//        components
//    }
//
//    static func buildOptional(_ component: [UITestPredicate]?) -> [UITestPredicate] {
//        component ?? []
//    }
//}

struct GivenWhenThen {
    let given: Given
    let when: When
    let then: Then

    func validate(_ app: XCUIApplication) {
        self.given.validate(app)
        self.when.validate(app)
        self.then.validate(app)
    }
}

open class UIPredicate {
    let predicates: [UITestClosure]
    let name: String?
    init(
        _ name: String? = nil,
        @GivenBuilder builder: () -> [UITestClosure]
    ) {
        self.predicates = builder()
        self.name = name
    }

    func validate(_ app: XCUIApplication) {
        XCTContext.runActivity(named: self.name ?? "Missing") { _ in
            predicates.forEach{ $0(app) }
        }
    }
}

final class Given: UIPredicate {
    override init(
        _ name: String? = nil,
        @GivenBuilder builder: () -> [UITestClosure]
    ) {
        super.init(name, builder: builder)
    }
}

final class When: UIPredicate {
    override init(
        _ name: String? = nil,
        @GivenBuilder builder: () -> [UITestClosure]
    ) {
        super.init(name, builder: builder)
    }
}

final class Then: UIPredicate {
    override init(
        _ name: String? = nil,
        @GivenBuilder builder: () -> [UITestClosure]
    ) {
        super.init(name, builder: builder)
    }
}
