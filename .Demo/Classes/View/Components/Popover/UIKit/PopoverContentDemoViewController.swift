//
//  PopoverContentDemoViewController.swift
//  SparkDemo
//
//  Created by louis.borlee on 15/07/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import SparkCore
import SparkPopover

final class PopoverContentDemoViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel()
        label.text = "This is a label that should be multiline, depending on the content size. This is a label that should be multiline, depending on the content size."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(theme: Theme, intent: PopoverIntent) {
        super.init(nibName: nil, bundle: nil)
        self.label.textColor = intent.getColors(theme: theme).foreground.uiColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear

        self.view.addSubview(self.label)
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.label.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])

    }

    override func viewDidLayoutSubviews() {
        self.preferredContentSize = self.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
