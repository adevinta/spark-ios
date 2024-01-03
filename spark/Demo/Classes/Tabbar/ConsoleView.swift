//
//  ConsoleView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 18.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import UIKit

final class Console {
    static var publisher: some Publisher<String, Never> {
        return Self.subject
    }
    private static let subject = PassthroughSubject<String, Never>()
    static func log(_ message: @autoclosure () -> String) {
        self.subject.send(message())
    }
}

final class ConsoleView: UIView {

    enum Constants {
        static let fullWidth: CGFloat = 200
        static let collapsedWidth: CGFloat = 40
    }

    private var dataSource = [String]()

    static let shared = ConsoleView()

    private var width: CGFloat {
        return self.consoleButton.isSelected ? Constants.fullWidth : Constants.collapsedWidth
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(ConsoleTableViewCell.self, forCellReuseIdentifier: ConsoleTableViewCell.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    private lazy var buttonBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var consoleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "apple.terminal"), for: .normal)
        button.setImage(UIImage(systemName: "apple.terminal.on.rectangle"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.toggleConsole), for: .touchUpInside)
        button.isSelected = false
        button.accessibilityIdentifier = "console_show_toggle_button"
        return button
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.clearText), for: .touchUpInside)
        button.isSelected = false
        button.accessibilityIdentifier = "console_delete_button"
        return button
    }()

    private var sizeConstraint: NSLayoutConstraint?
    private var cancellables = Set<AnyCancellable>()

    private init() {
        super.init(frame: .zero)
        self.setupView()
        self.setupConstraints()
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        guard let window = UIApplication.shared.windows.last else {
            return
        }
        window.addSubview(self)
        self.layer.zPosition = .greatestFiniteMagnitude

        self.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -20).isActive = true
        self.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.buttonBar)
        self.buttonBar.addSubview(self.consoleButton)
        self.buttonBar.addSubview(self.deleteButton)

        self.addSubview(self.tableView)

        self.tableView.isHidden = !self.consoleButton.isSelected
        self.tableView.backgroundColor = .darkGray
        self.tableView.layer.borderColor = UIColor.black.cgColor
        self.tableView.layer.borderWidth = 2.0
        self.tableView.layer.cornerRadius = 10

        self.deleteButton.isHidden = !self.consoleButton.isSelected

    }

    private func setupConstraints() {
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: self.width)
        NSLayoutConstraint.activate([
            widthConstraint,
            self.heightAnchor.constraint(equalTo: self.widthAnchor),
            self.deleteButton.leadingAnchor.constraint(equalTo: self.buttonBar.leadingAnchor),
            self.deleteButton.bottomAnchor.constraint(equalTo: self.buttonBar.bottomAnchor),
            self.consoleButton.trailingAnchor.constraint(equalTo: self.buttonBar.trailingAnchor),
            self.consoleButton.bottomAnchor.constraint(equalTo: self.buttonBar.bottomAnchor),
            self.buttonBar.heightAnchor.constraint(equalTo: self.consoleButton.heightAnchor),
            self.buttonBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.buttonBar.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.buttonBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.tableView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.buttonBar.bottomAnchor),
            self.tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        self.sizeConstraint = widthConstraint
    }

    @objc private func clear() {
        self.dataSource = []
        self.tableView.reloadData()
        self.scrollToBottom()
    }

    private func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.dataSource.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    private func setupSubscriptions() {
        Console.publisher.subscribe(in: &self.cancellables) { [weak self] message in
            guard let self = self else { return }
            self.dataSource.append(message)
            self.tableView.reloadData()
            self.scrollToBottom()
        }
    }

    @objc func toggleConsole() {
        self.consoleButton.isSelected.toggle()
        UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve], animations: { [weak self] in
            guard let self = self else { return }
            self.sizeConstraint?.constant = self.width

            self.tableView.isHidden = !self.consoleButton.isSelected
            self.deleteButton.isHidden = !self.consoleButton.isSelected

        })
    }

    @objc func clearText() {
        self.dataSource = []
        self.tableView.reloadData()
    }
}

extension ConsoleView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 12.0
    }
}

extension ConsoleView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.dataSource.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ConsoleTableViewCell.cellIdentifier) as? ConsoleTableViewCell else {
            fatalError("Couldn't dequeue table view cell")
        }
        let lineNumber = String(format: "%3d", indexPath.row)
        cell.label.text = "\(lineNumber)> \(self.dataSource[indexPath.row])"
        cell.accessibilityIdentifier = "console_row_\(indexPath.row)"

        return cell
    }
}

class ConsoleTableViewCell: UITableViewCell {
    static var cellIdentifier = String(describing: ConsoleTableViewCell.self)

    lazy var label: UILabel = {
        var label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 10, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.label)
        NSLayoutConstraint.stickEdges(from: self.label, to: self.contentView)
        self.backgroundColor = .clear

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
