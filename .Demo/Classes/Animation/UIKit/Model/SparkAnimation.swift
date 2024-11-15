//
//  SparkAnimation.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

public protocol SparkAnimation {
    // TODO: add completion when animation is finished
    init(from views: UIView...)
    func start()
    func start(with limit: Int)
    func stop()
}
