//
//  ListViewDatasource.swift
//  SparkDemo
//
//  Created by alican.aycil on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

final class ListViewDataSource: NSObject, ObservableObject {

    static let shared = ListViewDataSource()

    @Published var components: [UIView] = []
}

extension ListViewDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.components.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell {
            let component = components[indexPath.row]
            component.translatesAutoresizingMaskIntoConstraints = false
            cell.configureCell(component: component)
            return cell
        }
        return UITableViewCell()
    }
}
