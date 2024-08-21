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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Item", style: .plain, target: self, action: #selector(self.addNewComponentToList))

        self.setupTableView()
    }

    private func setupTableView() {
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.listProtocol
        self.tableView.allowsSelection = false
        self.registerCells()
    }

    private func registerCells() {
        switch Cell.self {

        case is BadgeCell.Type:
            self.tableView.register(BadgeCell.self, forCellReuseIdentifier: BadgeCell.reuseIdentifier)

        case is ButtonCell.Type:
            self.tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.reuseIdentifier)

        case is CheckboxCell.Type:
            self.tableView.register(CheckboxCell.self, forCellReuseIdentifier: CheckboxCell.reuseIdentifier)

        case is CheckboxGroupCell.Type:
            self.tableView.register(CheckboxGroupCell.self, forCellReuseIdentifier: CheckboxGroupCell.reuseIdentifier)

        case is ChipCell.Type:
            self.tableView.register(ChipCell.self, forCellReuseIdentifier: ChipCell.reuseIdentifier)

        case is IconCell.Type:
            self.tableView.register(IconCell.self, forCellReuseIdentifier: IconCell.reuseIdentifier)

        case is ProgressBarIndeterminateCell.Type:
            self.tableView.register(ProgressBarIndeterminateCell.self, forCellReuseIdentifier: ProgressBarIndeterminateCell.reuseIdentifier)

        case is ProgressBarSingleCell.Type:
            self.tableView.register(ProgressBarSingleCell.self, forCellReuseIdentifier: ProgressBarSingleCell.reuseIdentifier)

        case is RadioButtonCell.Type:
            self.tableView.register(RadioButtonCell.self, forCellReuseIdentifier: RadioButtonCell.reuseIdentifier)

        case is RadioButtonGroupCell.Type:
            self.tableView.register(RadioButtonGroupCell.self, forCellReuseIdentifier: RadioButtonGroupCell.reuseIdentifier)

        case is RatingDisplayCell.Type:
            self.tableView.register(RatingDisplayCell.self, forCellReuseIdentifier: RatingDisplayCell.reuseIdentifier)

        case is RatingInputCell.Type:
            self.tableView.register(RatingInputCell.self, forCellReuseIdentifier: RatingInputCell.reuseIdentifier)

        case is SpinnerCell.Type:
            self.tableView.register(SpinnerCell.self, forCellReuseIdentifier: SpinnerCell.reuseIdentifier)

        case is StarCell.Type:
            self.tableView.register(StarCell.self, forCellReuseIdentifier: StarCell.reuseIdentifier)

        case is SwitchCell.Type:
            self.tableView.register(SwitchCell.self, forCellReuseIdentifier: SwitchCell.reuseIdentifier)

        case is TabCell.Type:
            self.tableView.register(TabCell.self, forCellReuseIdentifier: TabCell.reuseIdentifier)

        case is TagCell.Type:
            self.tableView.register(TagCell.self, forCellReuseIdentifier: TagCell.reuseIdentifier)

        default:
            break
        }
    }

    @objc func addNewComponentToList() {
        self.dataSource.setupData(newItem: true)
        self.tableView.reloadData()
    }
}
