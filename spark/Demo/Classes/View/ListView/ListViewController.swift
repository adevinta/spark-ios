//
//  ListViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine

final class ListViewController: UITableViewController {

    private var cancellables: Set<AnyCancellable> = []
    private var dataSource: ListViewDataSource {
        ListViewDataSource.shared
    }
    private var listProtocol = ListViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        self.tableView.dataSource = self.dataSource
        self.tableView.allowsSelection = false
        self.tableView.delegate = self.listProtocol
        self.tableView.estimatedRowHeight = 44

        self.dataSource.$components.subscribe(in: &self.cancellables) { [weak self] components in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }
}
