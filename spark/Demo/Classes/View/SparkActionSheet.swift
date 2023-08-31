//
//  SparkActionSheet.swift
//  SparkDemo
//
//  Created by alican.aycil on 18.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

final class SparkActionSheet<T>: UIAlertController {

    let values: [T]
    let texts: [String]

    override var preferredStyle: UIAlertController.Style {
        return .actionSheet
    }

    init(values: [T], texts: [String], completion: @escaping (T) -> Void) {
        self.values = values
        self.texts = texts
        super.init(nibName: nil, bundle: nil)

        self.texts.enumerated().forEach { index, title in
            self.addAction(UIAlertAction(title: title, style: .default, handler: { _ in
                completion(values[index])
            }))
        }
        self.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
