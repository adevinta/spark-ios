//
//  Scenario.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 11.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest

//typealias UITestPredicate = (ScenarioConfigurtion) -> Bool
typealias UITestClosure = (XCUIApplication) -> Void

struct ScenarioConfigurtion {
    let app: XCUIApplication
    let message: String

    func assertTrue(
        _ expression: @autoclosure () throws -> Bool,
        message: @autoclosure () -> String = "",
        function: StaticString = #function,
        file: StaticString = #filePath,
        line: UInt = #line) {
            do {
                let expression = try expression()
                XCTAssertTrue(
                    expression,
                    "\(message()): \(function)",
                    file: file,
                    line: line
                )
            }
            catch {
                XCTFail("\(message()): \(function) \(error)", file: file, line: line)
            }
        }
}

final class AppLauncher {

    static var shared = AppLauncher()
    let app = XCUIApplication()
    private var isLaunched: Bool = false

    private init() {}

    func launch() {
        guard !self.isLaunched else { return }
        self.isLaunched = true
        app.launch()
    }

}

struct Scenario {

    let message: String
    let appLauncher = AppLauncher.shared
    let givenWhenThen: GivenWhenThen

    init(
        _ message: String,
        @GivenWhenThenBuilder builder: () -> GivenWhenThen
    ) {
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait
        self.message = message
        self.givenWhenThen = builder()
        self.appLauncher.launch()
    }

    func validate() {
        XCTContext.runActivity(named: self.message) {_ in
            givenWhenThen.validate(XCUIApplication())
        }
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
