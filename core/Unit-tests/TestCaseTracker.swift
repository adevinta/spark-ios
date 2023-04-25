//
//  TestCaseTracker.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

final class TestCaseTracker: NSObject, XCTestObservation {
    static let shared = TestCaseTracker()

    private(set) var currentTestCase: XCTestCase!

    func snapshotDirectory(for file: StaticString) -> String {
        let snapshotDirectory = ProcessInfo.processInfo.environment["SNAPSHOT_REFERENCE_DIR"]! + "/"
        guard let url = URL(string: snapshotDirectory) else { return "" }

        return url.appendingPathComponent(currentTestCase.testClassName).path
    }

    func testName(_ identifier: String? = nil) -> String {
        [currentTestCase.testMethodName, identifier]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .joined(separator: "_")
    }

    // MARK: -

    func subscribe() {
        guard !didSubscribe else {
            return
        }

        defer { didSubscribe = true }

        XCTestObservationCenter.shared.addTestObserver(self)
    }

    @objc func testCaseWillStart(_ testCase: XCTestCase) {
        currentTestCase = testCase
    }

    @objc func testCaseDidFinish(_ testCase: XCTestCase) {
        currentTestCase = nil
    }

    // MARK: - Private

    private var didSubscribe = false
}

private extension String {
    init(_ staticString: StaticString) {
        self = staticString.withUTF8Buffer {
            String(decoding: $0, as: UTF8.self)
        }
    }
}

extension XCTestCase {
    var testClassName: String {
        String(sanitizedName.split(separator: " ").first!)
    }

    var testMethodName: String {
        String(sanitizedName.split(separator: " ").last!)
    }

    // MARK: - Private

    private var sanitizedName: String {
        let fullName = name
        let characterSet = CharacterSet(charactersIn: "[]+-")
        let name = fullName.components(separatedBy: characterSet).joined()

        if let quickClass = NSClassFromString("QuickSpec"), isKind(of: quickClass) {
            let className = String(describing: type(of: self))
            if let range = name.range(of: className), range.lowerBound == name.startIndex {
                return name
                    .replacingCharacters(in: range, with: "")
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        return name
    }
}
