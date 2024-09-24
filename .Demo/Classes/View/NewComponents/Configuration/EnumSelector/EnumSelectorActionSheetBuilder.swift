//
//  EnumSelectorActionSheetBuilder.swift
//  SparkDemo
//
//  Created by louis.borlee on 20/09/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

final class EnumSelectorActionSheetBuilder<Enum> where Enum: CaseIterable & Hashable {

    private let title: String?

    init(title: String?) {
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func build(action: @escaping (Enum) -> Void) -> UIAlertController{
        let alertController = UIAlertController(
            title: self.title,
            message: nil,
            preferredStyle: .actionSheet
        )
        Enum.allCases.forEach { `case` in
            alertController.addAction(
                .init(
                    title: `case`.name,
                    style: .default,
                    handler: { _ in
                        action(`case`)
                    }
                )
            )
        }
        return alertController
    }

    func build(action: @escaping (Enum?) -> Void) -> UIAlertController{
        let alertController = UIAlertController(
            title: self.title,
            message: nil,
            preferredStyle: .actionSheet
        )
        Enum.allCases.forEach { `case` in
            alertController.addAction(
                .init(
                    title: `case`.name,
                    style: .default,
                    handler: { _ in
                        action(`case`)
                    }
                )
            )
        }
        alertController.addAction(
            .init(
                title: "Default",
                style: .default,
                handler: { _ in
                    action(nil)
                }
            )
        )
        return alertController
    }
}
