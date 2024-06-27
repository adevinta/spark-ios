//
//  SpaceContainer.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

enum SpaceContainer: CaseIterable {
    case left
    case top
    case right
    case bottom

    // MARK: - Properties

    var fixedWidth: CGFloat? {
        switch self {
        case .left, .right:
            return 60
        default:
            return nil
        }
    }

    var fixedHeight: CGFloat? {
        switch self {
        case .top, .bottom:
            return 35
        default:
            return nil
        }
    }

    // MARK: - Methods

    func showSpaceContainer(from type: SpaceContainerType) -> Bool {
        switch self {
        case .left:
            return type.showLeftSpaceContainer
        case .top:
            return type.showTopSpaceContainer
        case .right:
            return type.showRightSpaceContainer
        case .bottom:
            return type.showBottomSpaceContainer
        }
    }
}

enum SpaceContainerType: CaseIterable {
    case left
    case top
    case right
    case bottom
    case horizontal
    case vertical
    case all
    case none

    // MARK: - Properties

    fileprivate var showLeftSpaceContainer: Bool {
        switch self {
        case .left, .horizontal, .all:
            return true
        default:
            return false
        }
    }

    fileprivate var showTopSpaceContainer: Bool {
        switch self {
        case .top, .vertical, .all:
            return true
        default:
            return false
        }
    }

    fileprivate var showRightSpaceContainer: Bool {
        switch self {
        case .right, .horizontal, .all:
            return true
        default:
            return false
        }
    }

    fileprivate var showBottomSpaceContainer: Bool {
        switch self {
        case .bottom, .vertical, .all:
            return true
        default:
            return false
        }
    }
}
