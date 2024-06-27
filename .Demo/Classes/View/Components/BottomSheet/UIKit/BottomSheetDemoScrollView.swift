//
//  BottomSheetDemoScrollView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 16.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

final class BottomSheetDemoScrollView: UIView, DidTapButtonable {

    // MARK: - UI Elements
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = BottomSheetDemoView()

    // MARK: - Interactions
    var didTapButton: (() -> Void)? {
        get { return self.contentView.didTapButton }
        set { self.contentView.didTapButton = newValue }
    }

    private let longText = """
    Sample of the UIKit bottom sheet with a scroll view
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    🧡
    💙
    """

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        style()
        layout()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - SSUL
    private func setup() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    private func style() {
        if #available(iOS 13, *) {
            self.backgroundColor = .systemBackground
        } else {
            self.backgroundColor = .white
        }

        self.contentView.descriptionText = self.longText
    }

    private func layout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
        ])
    }
}
