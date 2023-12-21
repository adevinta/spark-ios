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

    var configurations: [ComponentConfiguration] = []

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

        /// Badge
        case let badgeConfiguration as BadgeConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BadgeCell.reuseIdentifier, for: indexPath) as? BadgeCell {
                cell.configureCell(configuration: badgeConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Button
        case let buttonConfiguration as ButtonConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.reuseIdentifier, for: indexPath) as? ButtonCell {
                cell.configureCell(configuration: buttonConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Checkbox
        case let checkboxConfiguration as CheckboxConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CheckboxCell.reuseIdentifier, for: indexPath) as? CheckboxCell {
                cell.configureCell(configuration: checkboxConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Chip
        case let chipConfiguration as ChipConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ChipCell.reuseIdentifier, for: indexPath) as? ChipCell {
                cell.configureCell(configuration: chipConfiguration)
                return cell
            }
            return UITableViewCell()


        /// Icon
        case let iconConfiguration as IconConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: IconCell.reuseIdentifier, for: indexPath) as? IconCell {
                cell.configureCell(configuration: iconConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Progress Bar Indeterminate
        case let progressBarIndeterminateConfiguration as ProgressBarIndeterminateConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProgressBarIndeterminateCell.reuseIdentifier, for: indexPath) as? ProgressBarIndeterminateCell {
                cell.configureCell(configuration: progressBarIndeterminateConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Progress Bar Single
        case let progressBarSingleConfiguration as ProgressBarSingleConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProgressBarSingleCell.reuseIdentifier, for: indexPath) as? ProgressBarSingleCell {
                cell.configureCell(configuration: progressBarSingleConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Radio Button
        case let radioButtonConfiguration as RadioButtonConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RadioButtonCell.reuseIdentifier, for: indexPath) as? RadioButtonCell {
                cell.configureCell(configuration: radioButtonConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Rating Display
        case let ratingDisplayConfiguration as RatingDisplayConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RatingDisplayCell.reuseIdentifier, for: indexPath) as? RatingDisplayCell {
                cell.configureCell(configuration: ratingDisplayConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Rating Input
        case let ratingInputConfiguration as RatingInputConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RatingInputCell.reuseIdentifier, for: indexPath) as? RatingInputCell {
                cell.configureCell(configuration: ratingInputConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Spinner
        case let spinnerConfiguration as SpinnerConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SpinnerCell.reuseIdentifier, for: indexPath) as? SpinnerCell {
                cell.configureCell(configuration: spinnerConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Star
        case let starConfiguration as StarCellConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: StarCell.reuseIdentifier, for: indexPath) as? StarCell {
                cell.configureCell(configuration: starConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Switch Button
        case let switchButtonConfiguration as SwitchButtonConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SwitchButtonCell.reuseIdentifier, for: indexPath) as? SwitchButtonCell {
                cell.configureCell(configuration: switchButtonConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Tab
        case let tabConfiguration as TabConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TabCell.reuseIdentifier, for: indexPath) as? TabCell {
                cell.configureCell(configuration: tabConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Tag
        case let tagConfiguration as TagConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TagCell.reuseIdentifier, for: indexPath) as? TagCell {
                cell.configureCell(configuration: tagConfiguration)
                return cell
            }
            return UITableViewCell()

        /// Text Field
        case let textFieldConfiguration as TextFieldConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.reuseIdentifier, for: indexPath) as? TextFieldCell {
                cell.configureCell(configuration: textFieldConfiguration)
                return cell
            }
            return UITableViewCell()

        default:
            return UITableViewCell()
        }
    }
}

extension ListViewDataSource {

    func setupData(newItem: Bool = false) {

        var data: [ComponentConfiguration]!
        switch Configuration.self {
        case is BadgeConfiguration.Type:
            data = self.createBadgeConfigurations()

        case is ButtonConfiguration.Type:
            data = self.createButtonConfigurations()

        case is CheckboxConfiguration.Type:
            data = self.createCheckboxConfigurations()

        case is ChipConfiguration.Type:
            data = self.createChipConfigurations()

        case is IconConfiguration.Type:
            data = self.createIconConfigurations()

        case is ProgressBarIndeterminateConfiguration.Type:
            data = self.createProgressBarIndeterminateConfigurations()

        case is ProgressBarSingleConfiguration.Type:
            data = self.createProgressBarSingleConfigurations()

        case is RadioButtonConfiguration.Type:
            data = self.createRadioButtonConfigurations()

        case is RatingDisplayConfiguration.Type:
            data = self.createRatingDisplayConfigurations()

        case is RatingInputConfiguration.Type:
            data = self.createRatingInputConfigurations()

        case is SpinnerConfiguration.Type:
            data = self.createSpinnerConfigurations()

        case is StarCellConfiguration.Type:
            data = self.createStarConfigurations()

        case is SwitchButtonConfiguration.Type:
            data = self.createSwitchButtonConfigurations()

        case is TabConfiguration.Type:
            data = self.createTabConfigurations()

        case is TagConfiguration.Type:
            data = self.createTagConfigurations()

        case is TextFieldConfiguration.Type:
            data = self.createTextFieldConfigurations()

        default:
            break
        }

        let randomItem = [data.randomElement() ?? data[0]]
        self.configurations += newItem ? randomItem : data
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

    /// Progress Bar Indeterminate
    func createProgressBarIndeterminateConfigurations() -> [ProgressBarIndeterminateConfiguration] {
        [ProgressBarIndeterminateConfiguration(theme: SparkTheme.shared, intent: .main),
         ProgressBarIndeterminateConfiguration(theme: SparkTheme.shared, intent: .basic),
         ProgressBarIndeterminateConfiguration(theme: SparkTheme.shared, intent: .success)]
    }

    /// Progress Bar Single
    func createProgressBarSingleConfigurations() -> [ProgressBarSingleConfiguration] {
        [ProgressBarSingleConfiguration(theme: SparkTheme.shared, intent: .main, value: 50),
         ProgressBarSingleConfiguration(theme: SparkTheme.shared, intent: .basic, value: 75),
         ProgressBarSingleConfiguration(theme: SparkTheme.shared, intent: .success, value: 30)]
    }

    /// Radio Button
    func createRadioButtonConfigurations() -> [RadioButtonConfiguration] {
        [RadioButtonConfiguration(theme: SparkTheme.shared, intent: .main),
         RadioButtonConfiguration(theme: SparkTheme.shared, intent: .basic),
         RadioButtonConfiguration(theme: SparkTheme.shared, intent: .success)]
    }

    /// Rating Display
    func createRatingDisplayConfigurations() -> [RatingDisplayConfiguration] {
        [RatingDisplayConfiguration(theme: SparkTheme.shared, intent: .main),
         RatingDisplayConfiguration(theme: SparkTheme.shared, intent: .main),
         RatingDisplayConfiguration(theme: SparkTheme.shared, intent: .main)]
    }

    /// Rating Input
    func createRatingInputConfigurations() -> [RatingInputConfiguration] {
        [RatingInputConfiguration(theme: SparkTheme.shared, intent: .main),
         RatingInputConfiguration(theme: SparkTheme.shared, intent: .main),
         RatingInputConfiguration(theme: SparkTheme.shared, intent: .main)]
    }

    /// Spinner
    func createSpinnerConfigurations() -> [SpinnerConfiguration] {
        [SpinnerConfiguration(theme: SparkTheme.shared, intent: .main),
         SpinnerConfiguration(theme: SparkTheme.shared, intent: .basic),
         SpinnerConfiguration(theme: SparkTheme.shared, intent: .success)]
    }

    /// Star
    func createStarConfigurations() -> [StarCellConfiguration] {
        [StarCellConfiguration(theme: SparkTheme.shared, borderColor: UIColor.lightGray, fillColor: UIColor.blue),
         StarCellConfiguration(theme: SparkTheme.shared, borderColor: UIColor.lightGray, fillColor: UIColor.yellow),
         StarCellConfiguration(theme: SparkTheme.shared, borderColor: UIColor.lightGray, fillColor: UIColor.red)]
    }

    /// Switch Button
    func createSwitchButtonConfigurations() -> [SwitchButtonConfiguration] {
        [SwitchButtonConfiguration(theme: SparkTheme.shared, intent: .main),
         SwitchButtonConfiguration(theme: SparkTheme.shared, intent: .basic),
         SwitchButtonConfiguration(theme: SparkTheme.shared, intent: .success)]
    }

    /// Tab
    func createTabConfigurations() -> [TabConfiguration] {
        [TabConfiguration(theme: SparkTheme.shared, intent: .main),
         TabConfiguration(theme: SparkTheme.shared, intent: .basic),
         TabConfiguration(theme: SparkTheme.shared, intent: .support)]
    }

    /// Tag
    func createTagConfigurations() -> [TagConfiguration] {
        [TagConfiguration(theme: SparkTheme.shared, intent: .main),
         TagConfiguration(theme: SparkTheme.shared, intent: .basic),
         TagConfiguration(theme: SparkTheme.shared, intent: .success)]
    }

    /// Text Field
    func createTextFieldConfigurations() -> [TextFieldConfiguration] {
        [TextFieldConfiguration(theme: SparkTheme.shared, intent: .alert),
         TextFieldConfiguration(theme: SparkTheme.shared, intent: .error),
         TextFieldConfiguration(theme: SparkTheme.shared, intent: .success)]
    }
}
