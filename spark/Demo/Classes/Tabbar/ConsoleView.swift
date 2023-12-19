//
//  ConsoleView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 18.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import UIKit

final class ConsoleView: UIView {

    enum Constants {
        static let fullWidth: CGFloat = 200
        static let collapsedWidth: CGFloat = 40
    }

    static let shared = ConsoleView()

    private var isCollapsed = true
    private var width: CGFloat {
        return self.isCollapsed ? Constants.collapsedWidth : Constants.fullWidth
    }
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var buttonBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var consoleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "apple.terminal"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.toggleConsole), for: .touchUpInside)
        return button
    }()

    private var sizeConstraint: NSLayoutConstraint?

    private init() {
        super.init(frame: .zero)
        self.setupView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        let window = UIApplication.shared.windows.last!
        window.addSubview(self)
        self.layer.zPosition = .greatestFiniteMagnitude

        self.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -20).isActive = true
        self.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor).isActive = true
    }

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.buttonBar)
        self.buttonBar.addSubview(self.consoleButton)
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.textView)

        self.scrollView.isHidden = true
        self.scrollView.backgroundColor = .darkGray
        self.scrollView.layer.borderColor = UIColor.gray.cgColor
        self.scrollView.layer.borderWidth = 1.0
    }

    private func setupConstraints() {
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: self.width)
        NSLayoutConstraint.activate([
            widthConstraint,
            self.heightAnchor.constraint(equalTo: self.widthAnchor),
//            self.buttonBar.heightAnchor.constraint(equalToConstant: Self.Constants.collapsedWidth),
            self.consoleButton.trailingAnchor.constraint(equalTo: self.buttonBar.trailingAnchor),
            self.consoleButton.bottomAnchor.constraint(equalTo: self.buttonBar.bottomAnchor),
            self.buttonBar.heightAnchor.constraint(equalTo: self.consoleButton.heightAnchor),
            self.buttonBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.buttonBar.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.buttonBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.buttonBar.bottomAnchor),
            self.scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            self.textView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.textView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.textView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.textView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor)
        ])
        self.sizeConstraint = widthConstraint
    }


    @objc func toggleConsole() {
        self.isCollapsed.toggle()
        UIView.transition(with: self, duration: 0.5, options: [.transitionCrossDissolve], animations: { [weak self] in
            guard let self = self else { return }
            self.sizeConstraint?.constant = self.width
        })

        self.scrollView.isHidden = self.isCollapsed
    }
}

//
//extension UIViewController {
//
//    func showConsoleButton() {
//        navigationItem.rightBarButtonItem =
//        UIBarButtonItem(image: UIImage(systemName: "apple.terminal.on.rectangle"), style: .plain, target: self, action: #selector(openConsole))
//    }
//
//    @objc func openConsole() {
//        let console = ConsoleView.shared
//        let window = UIApplication.shared.windows.last!
//        window.addSubview(console)
//        print(self.navigationItem.rightBarButtonItem?.customView?.frame)
//        let frame: CGRect
//        if #available(iOS 17.0, *) {
//            let buttonFrame: CGRect = self.navigationItem.rightBarButtonItem?.frame(in: self.view) ?? CGRect(x: 150, y: 100, width: 200, height: 200)
//            frame = CGRect(x: buttonFrame.maxX - 200, y: buttonFrame.maxY, width: 200, height: 200)
//        } else {
//            frame = CGRect(x: 150, y: 100, width: 200, height: 200)
//        }
//
//        console.frame = frame
//
//        UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: { [weak self] in
//            guard let self = self else { return }
//
//            self.navigationItem.rightBarButtonItem =
//            UIBarButtonItem(image: UIImage(systemName: "apple.terminal"), style: .plain, target: self, action: #selector(closeConsole))
//        }, completion: nil)
//    }
//
//    @objc func closeConsole() {
//        ConsoleView.shared.removeFromSuperview()
//        let window = UIApplication.shared.windows.last!
//
//        UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: { [weak self] in
//            guard let self = self else { return }
//
//            self.navigationItem.rightBarButtonItem =
//            UIBarButtonItem(image: UIImage(systemName: "apple.terminal.on.rectangle"), style: .plain, target: self, action: #selector(self.openConsole))
//        }, completion: nil)
//
//    }
//}
