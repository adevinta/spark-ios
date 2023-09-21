//
//  AddOnUIView.swift
//  Spark
//
//  Created by Jacklyn Situmorang on 19.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

public final class AddOnUIView: UIView {
    
    // MARK: - Private properties

    private let content: UIView
    private let fillMode: AddOnFillMode
    private let position: AddOnPosition

    // MARK: - Private enum

    private enum Side {
        case left
        case right
    }
    
    // MARK: - Initializers

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Initialize an addon to be used with TextFieldUIView
    /// - Parameters:
    ///   - content: Element to be added to the addon, could be a button, label, etc.
    ///   - fillMode: The content can fill the entire add on or positioned centered in the add on
    ///   - position: Position of the add-on to the text field
    init(
        content: UIView,
        fillMode: AddOnFillMode,
        position: AddOnPosition
    ) {
        self.content = content
        self.fillMode = fillMode
        self.position = position

        super.init(frame: .zero)
        self.setupView()
    }

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.content.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white

        self.addSubview(content)

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 44),
            self.widthAnchor.constraint(equalToConstant: self.content.intrinsicContentSize.width + 32)
        ])

        switch fillMode {
        case .centered:
            NSLayoutConstraint.activate([
                self.content.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                self.content.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        case .fill:
            NSLayoutConstraint.stickEdges(from: content, to: self)
        }

        switch position {
        case .leading:
            self.addBorder(toThe: .right)
        case .trailing:
            self.addBorder(toThe: .left)
        }
    }

    private func addBorder(toThe side: AddOnUIView.Side) {
        let border = UIView()
        border.backgroundColor = .black

        switch side {
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: 1, height: frame.size.height)
            border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        case .right:
            border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
            border.frame = CGRect(x: frame.size.width - 1, y: 0, width: 1, height: frame.size.height)
        }

        self.addSubview(border)
    }
}
