//
//  ImageEither+ExtensionSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 30/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SwiftUI
import UIKit

extension ImageEither {

    static func mock(isSwiftUIComponent: Bool) -> Self {
        return isSwiftUIComponent ? .right(.mock) : .left(.mock)
    }
}

private extension Image {
    static let mock = Image(systemName: "person.2.circle.fill")
}

private extension UIImage {
    static var mock = UIImage(systemName: "person.2.circle.fill") ?? UIImage()
}
