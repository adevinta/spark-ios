//
//  ListViewDatasource.swift
//  SparkDemo
//
//  Created by alican.aycil on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

final class ListViewDataSource<Configuration: ComponentConfiguration>: NSObject, UITableViewDataSource {

    var configurations: [ComponentConfiguration]!

    override init() {
        super.init()
        self.setupData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.configurations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let configuration = configurations[indexPath.row]
        switch configuration {

        case let badgeConfiguration as BadgeConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BadgeCell.reuseIdentifier, for: indexPath) as? BadgeCell {
                cell.configureCell(configuration: badgeConfiguration)
                return cell
            }
            return UITableViewCell()

        case let buttonConfiguration as ButtonConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.reuseIdentifier, for: indexPath) as? ButtonCell {
                cell.configureCell(configuration: buttonConfiguration)
                return cell
            }
            return UITableViewCell()

        case let checkboxConfiguration as CheckboxConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CheckboxCell.reuseIdentifier, for: indexPath) as? CheckboxCell {
                cell.configureCell(configuration: checkboxConfiguration)
                return cell
            }
            return UITableViewCell()

        case let chipConfiguration as ChipConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ChipCell.reuseIdentifier, for: indexPath) as? ChipCell {
                cell.configureCell(configuration: chipConfiguration)
                return cell
            }
            return UITableViewCell()

        case let iconConfiguration as IconConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: IconCell.reuseIdentifier, for: indexPath) as? IconCell {
                cell.configureCell(configuration: iconConfiguration)
                return cell
            }
            return UITableViewCell()

        default:
            return UITableViewCell()
        }
    }
}

extension ListViewDataSource {

    func setupData() {
        switch Configuration.self {
        case is BadgeConfiguration.Type:
            configurations = self.createBadgeConfigurations()
        case is ButtonConfiguration.Type:
            configurations = self.createButtonConfigurations()
        case is CheckboxConfiguration.Type:
            configurations = self.createCheckboxConfigurations()
        case is ChipConfiguration.Type:
            configurations = self.createChipConfigurations()
        case is IconConfiguration.Type:
            configurations = self.createIconConfigurations()
        default:
            configurations = []
        }
    }

    /// Badge
    func createBadgeConfigurations() -> [BadgeConfiguration] {
        [BadgeConfiguration(theme: SparkTheme.shared, intent: .main),
         BadgeConfiguration(theme: SparkTheme.shared, intent: .basic),
         BadgeConfiguration(theme: SparkTheme.shared, intent: .success)]
    }

    /// Button
    func createButtonConfigurations() -> [ButtonConfiguration] {
        [ButtonConfiguration(theme: SparkTheme.shared, intent: .main),
         ButtonConfiguration(theme: SparkTheme.shared, intent: .basic),
         ButtonConfiguration(theme: SparkTheme.shared, intent: .success)]
    }

    /// Checkbox
    func createCheckboxConfigurations() -> [CheckboxConfiguration] {
        [CheckboxConfiguration(theme: SparkTheme.shared, intent: .main),
         CheckboxConfiguration(theme: SparkTheme.shared, intent: .basic),
         CheckboxConfiguration(theme: SparkTheme.shared, intent: .success)]
    }

    /// Chip
    func createChipConfigurations() -> [ChipConfiguration] {
        [ChipConfiguration(theme: SparkTheme.shared, intent: .main),
         ChipConfiguration(theme: SparkTheme.shared, intent: .basic),
         ChipConfiguration(theme: SparkTheme.shared, intent: .success)]
    }

    /// Icon
    func createIconConfigurations() -> [IconConfiguration] {
        [IconConfiguration(theme: SparkTheme.shared, intent: .main),
         IconConfiguration(theme: SparkTheme.shared, intent: .basic),
         IconConfiguration(theme: SparkTheme.shared, intent: .success)]
    }
}
