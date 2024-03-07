//
//  PopoverView.swift
//  PopupUIKit
//
//  Created by alican.aycil on 01.03.24.
//

// swiftlint:disable all
import UIKit

final class PopoverView: UIView {

    lazy var titleLabel: UILabel = {
        let label =  UILabel()
        label.text = "It is a long established. It is a long established. It is a long established. It is a long established. It is a long established. It is a long established. It is a long established. It is a long established. It is a long established. It is a long established. It is a long established. It is a long established. It is a long established."
        label.numberOfLines = 0
        return label
    }()

    public let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var horizontalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, closeButton])
        view.axis = .horizontal
        view.alignment = .top
        return view
    }()

    let actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var verticalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [horizontalStack, actionButton])
        view.axis = .vertical
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)

        self.setUpView()
    }

    func setUpView() {
        // This is also important to set translatesAutoresizingMaskIntoConstraints
        self.translatesAutoresizingMaskIntoConstraints = false

        self.backgroundColor = UIColor.green
        self.addSubview(verticalStack)

        // verticalStack
        verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        verticalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true

        // closeButton
        closeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        // actionButton
        actionButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
