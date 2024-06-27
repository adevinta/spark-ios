//
//  UIApplication.swift
//  SparkDemo
//
//  Created by alican.aycil on 14.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

extension UIApplication {

    public var windows: [UIWindow] {
        return self.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
    }

    public var topController: UIViewController? {
        self.windows.filter{ $0.isKeyWindow }.first?.rootViewController
    }
}
