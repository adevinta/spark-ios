//
//  ListViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine

final class ListViewController<Cell: Configurable, Configuration: ComponentConfiguration>: UITableViewController {

    private var dataSource = ListViewDataSource<Configuration>()
    private var listProtocol = ListViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Cell.reuseIdentifier

        self.setupTableView()
    }

    private func setupTableView() {
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.listProtocol
        self.tableView.allowsSelection = false

        switch Cell.self {

        case is BadgeCell.Type:
            self.tableView.register(BadgeCell.self, forCellReuseIdentifier: BadgeCell.reuseIdentifier)

        case is ButtonCell.Type:
            self.tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.reuseIdentifier)

        case is CheckboxCell.Type:
            self.tableView.register(CheckboxCell.self, forCellReuseIdentifier: CheckboxCell.reuseIdentifier)

        case is ChipCell.Type:
            self.tableView.register(ChipCell.self, forCellReuseIdentifier: ChipCell.reuseIdentifier)

        case is IconCell.Type:
            self.tableView.register(IconCell.self, forCellReuseIdentifier: IconCell.reuseIdentifier)

        default:
            break
        }
    }
}
