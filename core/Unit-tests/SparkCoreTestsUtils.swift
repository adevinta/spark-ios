//
//  SparkCoreTestsUtils.swift
//  SparkCoreTests
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

public func sparktAssertSnapshot<Value, Format>(
    matching value: @autoclosure () throws -> Value,
    as snapshotting: Snapshotting<Value, Format>,
    named name: String? = nil,
    record recording: Bool = false,
    timeout: TimeInterval = 5,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    let failure = verifySnapshot(
        matching: try value(),
        as: snapshotting,
        named: name,
        record: recording,
        snapshotDirectory: TestCaseTracker.shared.snapshotDirectory(for: file),
        timeout: timeout,
        file: file,
        testName: testName
    )
    guard let message = failure else { return }
    XCTFail(message, file: file, line: line)
}

final class TestCaseTracker: NSObject, XCTestObservation {
    static let shared = TestCaseTracker()

    private(set) var currentTestCase: XCTestCase!

    func snapshotDirectory(for file: StaticString) -> String {
      //  let snapshotDirectory = ProcessInfo.processInfo.environment["SNAPSHOT_REFERENCE_DIR"]! + "/"
      //  guard var url = URL(string: snapshotDirectory) else { return "" }
        var url = URL(fileURLWithPath: String(file))

        repeat {
            let lastPathComponent = url.lastPathComponent
            url.deleteLastPathComponent()
            switch url.lastPathComponent {
            case "Tests":
                return url
                    .appendingPathComponent(lastPathComponent)
                    .appendingPathComponent("__Snapshots__")
                    .appendingPathComponent(currentTestCase.testClassName)
                    .path
            case "Unit-tests":
                let returnValue = url
                    .appendingPathComponent("__Snapshots__")
                    .appendingPathComponent(currentTestCase.testClassName)
                    .path
                print("returnValue", returnValue)
                return returnValue
            default:
                precondition(url.path != "/", "Could not find test root and snapshot directory")
            }
        } while true
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
