//
//  ListViewDatasource.swift
//  SparkDemo
//
//  Created by alican.aycil on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit
import SparkCore

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

        /// Checkbox Group
        case let checkboxGroupConfiguration as CheckboxGroupConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CheckboxGroupCell.reuseIdentifier, for: indexPath) as? CheckboxGroupCell {
                cell.configureCell(configuration: checkboxGroupConfiguration)
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

        /// Radio Button Group
        case let radioButtonGroupConfiguration as RadioButtonGroupConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RadioButtonGroupCell.reuseIdentifier, for: indexPath) as? RadioButtonGroupCell {
                cell.configureCell(configuration: radioButtonGroupConfiguration)
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

        /// Add On Text Field
        case let addOnTextFieldConfiguration as AddOnTextFieldConfiguration:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AddOnTextFieldCell.reuseIdentifier, for: indexPath) as? AddOnTextFieldCell {
                cell.configureCell(configuration: addOnTextFieldConfiguration)
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

        case is CheckboxGroupConfiguration.Type:
            data = self.createCheckboxGroupConfigurations()

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

        case is RadioButtonGroupConfiguration.Type:
            data = self.createRadioButtonGroupConfigurations()

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

        case is AddOnTextFieldConfiguration.Type:
            data = self.createAddOnTextFieldConfigurations()

        default:
            break
        }

        let randomItem = [data.randomElement() ?? data[0]]
        self.configurations += newItem ? randomItem : data
    }

    /// Badge
    func createBadgeConfigurations() -> [BadgeConfiguration] {
        [BadgeConfiguration(theme: SparkTheme.shared, intent: .main, size: .medium, value: 99, format: .default),
         BadgeConfiguration(theme: SparkTheme.shared, intent: .basic, size: .small, value: 123456, format: .default),
         BadgeConfiguration(theme: SparkTheme.shared, intent: .success, size: .medium, value: 99, format: .custom(formatter: BadgePreviewFormatter()))]
    }

    /// Button
    func createButtonConfigurations() -> [ButtonConfiguration] {
        [ButtonConfiguration(theme: SparkTheme.shared, intent: .main, variant: .filled, size: .medium, shape: .rounded, alignment: .leadingImage, content: .text, isEnabled: false),
         ButtonConfiguration(theme: SparkTheme.shared, intent: .basic, variant: .outlined, size: .large, shape: .square, alignment: .trailingImage, content: .imageAndText, isEnabled: true),
         ButtonConfiguration(theme: SparkTheme.shared, intent: .success, variant: .ghost, size: .small, shape: .pill, alignment: .leadingImage, content: .attributedText, isEnabled: true)
        ]
    }

    /// Checkbox
    func createCheckboxConfigurations() -> [CheckboxConfiguration] {
        [CheckboxConfiguration(theme: SparkTheme.shared, intent: .main, isEnabled: true, alignment: .left, text: "Hello World", selectionState: .indeterminate),
         CheckboxConfiguration(theme: SparkTheme.shared, intent: .basic, isEnabled: true, alignment: .right, text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", selectionState: .unselected),
         CheckboxConfiguration(theme: SparkTheme.shared, intent: .success, isEnabled: false, alignment: .left, text: "Hello World", icon: DemoIconography.shared.close.uiImage, selectionState: .selected)
        ]
    }

    /// Checkbox Group
    func createCheckboxGroupConfigurations() -> [CheckboxGroupConfiguration] {
        [CheckboxGroupConfiguration(theme: SparkTheme.shared, intent: .main, alignment: .left, layout: .vertical, showGroupTitle: false, items: [CheckboxGroupItemDefault(title: "Text", id: "1", selectionState: .selected, isEnabled: true), CheckboxGroupItemDefault(title: "Text 2", id: "2", selectionState: .unselected, isEnabled: true)]),
         CheckboxGroupConfiguration(theme: SparkTheme.shared, intent: .support, alignment: .left, layout: .horizontal, showGroupTitle: false, items: [CheckboxGroupItemDefault(title: "Text", id: "1", selectionState: .selected, isEnabled: true), CheckboxGroupItemDefault(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", id: "2", selectionState: .indeterminate, isEnabled: true), CheckboxGroupItemDefault(title: "Hello World", id: "3", selectionState: .unselected, isEnabled: true)]),
         CheckboxGroupConfiguration(theme: SparkTheme.shared, intent: .info, alignment: .right, layout: .vertical, showGroupTitle: true, items: [CheckboxGroupItemDefault(title: "Text", id: "1", selectionState: .selected, isEnabled: false), CheckboxGroupItemDefault(title: "Text 2", id: "2", selectionState: .unselected, isEnabled: true)])]
    }

    /// Chip
    func createChipConfigurations() -> [ChipConfiguration] {
        [ChipConfiguration(theme: SparkTheme.shared, intent: .main, variant: .dashed, alignment: .leadingIcon, isEnabled: true, isSelected: false, title: "This is", icon: UIImage(systemName: "calendar")),
         ChipConfiguration(theme: SparkTheme.shared, intent: .basic, variant: .outlined, alignment: .trailingIcon, isEnabled: false, isSelected: false, title: "A chip", icon: UIImage(systemName: "arrowshape.left") ),
         ChipConfiguration(theme: SparkTheme.shared, intent: .success, variant: .tinted, alignment: .leadingIcon, isEnabled: true, isSelected: true, title: "Hello", icon: nil)]
    }

    /// Icon
    func createIconConfigurations() -> [IconConfiguration] {
        [IconConfiguration(theme: SparkTheme.shared, intent: .main, size: .extraLarge),
         IconConfiguration(theme: SparkTheme.shared, intent: .basic, size: .small),
         IconConfiguration(theme: SparkTheme.shared, intent: .success, size: .medium)]
    }

    /// Progress Bar Indeterminate
    func createProgressBarIndeterminateConfigurations() -> [ProgressBarIndeterminateConfiguration] {
        [ProgressBarIndeterminateConfiguration(theme: SparkTheme.shared, intent: .main, isAnimated: true),
         ProgressBarIndeterminateConfiguration(theme: SparkTheme.shared, intent: .basic, isAnimated: false),
         ProgressBarIndeterminateConfiguration(theme: SparkTheme.shared, intent: .success, isAnimated: true)]
    }

    /// Progress Bar Single
    func createProgressBarSingleConfigurations() -> [ProgressBarSingleConfiguration] {
        [ProgressBarSingleConfiguration(theme: SparkTheme.shared, intent: .main, value: 0.5),
         ProgressBarSingleConfiguration(theme: SparkTheme.shared, intent: .basic, value: 0.75),
         ProgressBarSingleConfiguration(theme: SparkTheme.shared, intent: .success, value: 1.0)]
    }

    /// Radio Button
    func createRadioButtonConfigurations() -> [RadioButtonConfiguration] {
        [RadioButtonConfiguration(theme: SparkTheme.shared, intent: .main, alignment: .trailing, isSelected: true, isEnabled: true, text: "Sample of toggle on radio button"),
         RadioButtonConfiguration(theme: SparkTheme.shared, intent: .basic, alignment: .leading, isSelected: false, isEnabled: true, text: "Hello world"),
         RadioButtonConfiguration(theme: SparkTheme.shared, intent: .success, alignment: .trailing, isSelected: true, isEnabled: false, text: "This is an example of a multi-line text which is very long and in which the user should read all the information.")]
    }

    /// Radio Button Group
    func createRadioButtonGroupConfigurations() -> [RadioButtonGroupConfiguration] {
        [RadioButtonGroupConfiguration(theme: SparkTheme.shared, intent: .main, alignment: .trailing, layout: .vertical, isEnabled: true, selectedID: 0),
         RadioButtonGroupConfiguration(theme: SparkTheme.shared, intent: .basic, alignment: .trailing, layout: .vertical, isEnabled: true, selectedID: 1),
         RadioButtonGroupConfiguration(theme: SparkTheme.shared, intent: .success, alignment: .leading, layout: .vertical, isEnabled: false, selectedID: 2)]
    }

    /// Rating Display
    func createRatingDisplayConfigurations() -> [RatingDisplayConfiguration] {
        [RatingDisplayConfiguration(theme: SparkTheme.shared, intent: .main, size: .medium, rating: 3.0, count: .five),
         RatingDisplayConfiguration(theme: SparkTheme.shared, intent: .main, size: .medium, rating: 0.5, count: .one),
         RatingDisplayConfiguration(theme: SparkTheme.shared, intent: .main, size: .small, rating: 4.0, count: .five)]
    }

    /// Rating Input
    func createRatingInputConfigurations() -> [RatingInputConfiguration] {
        [RatingInputConfiguration(theme: SparkTheme.shared, intent: .main, rating: 0, isEnabled: true),
         RatingInputConfiguration(theme: SparkTheme.shared, intent: .main, rating: 3.0, isEnabled: true),
         RatingInputConfiguration(theme: SparkTheme.shared, intent: .main, rating: 1.5, isEnabled: false)]
    }

    /// Spinner
    func createSpinnerConfigurations() -> [SpinnerConfiguration] {
        [SpinnerConfiguration(theme: SparkTheme.shared, intent: .main, size: .medium),
         SpinnerConfiguration(theme: SparkTheme.shared, intent: .basic, size: .small),
         SpinnerConfiguration(theme: SparkTheme.shared, intent: .success, size: .medium)]
    }

    /// Star
    func createStarConfigurations() -> [StarCellConfiguration] {
        [StarCellConfiguration(theme: SparkTheme.shared, borderColor: UIColor.lightGray, fillColor: UIColor.blue, numberOfVertices: 5, fillMode: .full),
         StarCellConfiguration(theme: SparkTheme.shared, borderColor: UIColor.lightGray, fillColor: UIColor.green, numberOfVertices: 8, fillMode: .full),
         StarCellConfiguration(theme: SparkTheme.shared, borderColor: UIColor.lightGray, fillColor: UIColor.red, numberOfVertices: 5, fillMode: .half)]
    }

    /// Switch Button
    func createSwitchButtonConfigurations() -> [SwitchButtonConfiguration] {
        [SwitchButtonConfiguration(theme: SparkTheme.shared, intent: .main, alignment: .left, textContent: .text, isOn: true, isEnabled: true),
         SwitchButtonConfiguration(theme: SparkTheme.shared, intent: .basic, alignment: .right, textContent: .multilineText, isOn: false, isEnabled: true),
         SwitchButtonConfiguration(theme: SparkTheme.shared, intent: .success, alignment: .left, textContent: .attributedText, isOn: true, isEnabled: false)
        ]
    }

    /// Tab
    func createTabConfigurations() -> [TabConfiguration] {
        [TabConfiguration(theme: SparkTheme.shared, intent: .basic, size: .md, contents: [TabUIItemContent(title: "Tab 1"), TabUIItemContent(icon: UIImage(systemName: "paperplane.fill"), title: "Tab 2")], showBadge: false, isEqualWidth: true),
         TabConfiguration(theme: SparkTheme.shared, intent: .main, size: .md, contents: [TabUIItemContent(title: "Tab 1"), TabUIItemContent(icon: UIImage(systemName: "paperplane.fill"), title: "Tab 2")], showBadge: true, isEqualWidth: true),
         TabConfiguration(theme: SparkTheme.shared, intent: .support, size: .sm, contents: [TabUIItemContent(title: "Tab 1"), TabUIItemContent(icon: UIImage(systemName: "paperplane.fill"), title: "Tab 2"), TabUIItemContent(icon: UIImage(systemName: "paperplane.fill"), title: "Tab 3")], showBadge: false, isEqualWidth: false)
        ]
    }

    /// Tag
    func createTagConfigurations() -> [TagConfiguration] {
        [TagConfiguration(theme: SparkTheme.shared, intent: .main, variant: .filled, content: .text),
         TagConfiguration(theme: SparkTheme.shared, intent: .basic, variant: .outlined, content: .icon),
         TagConfiguration(theme: SparkTheme.shared, intent: .success, variant: .tinted, content: .iconAndText)]
    }

    /// Text Field
    func createTextFieldConfigurations() -> [TextFieldConfiguration] {
        [TextFieldConfiguration(theme: SparkTheme.shared, intent: .success, leftViewMode: .always, rightViewMode: .never, clearButtonMode: .whileEditing),
         TextFieldConfiguration(theme: SparkTheme.shared, intent: .neutral, leftViewMode: .always, rightViewMode: .whileEditing, clearButtonMode: .whileEditing, text: "Hello world"),
         TextFieldConfiguration(theme: SparkTheme.shared, intent: .error, leftViewMode: .always, rightViewMode: .always, clearButtonMode: .always)]
    }

    /// Add On Text Field
    func createAddOnTextFieldConfigurations() -> [AddOnTextFieldConfiguration] {
        [AddOnTextFieldConfiguration(theme: SparkTheme.shared, intent: .success, leftViewMode: .always, rightViewMode: .never, leadingAddOnOption: .button, trailingAddOnOption: .none, clearButtonMode: .whileEditing),
         AddOnTextFieldConfiguration(theme: SparkTheme.shared, intent: .neutral, leftViewMode: .always, rightViewMode: .whileEditing, leadingAddOnOption: .button, trailingAddOnOption: .shortText, clearButtonMode: .whileEditing, text: "Hello world"),
         AddOnTextFieldConfiguration(theme: SparkTheme.shared, intent: .error, leftViewMode: .always, rightViewMode: .always, leadingAddOnOption: .button, trailingAddOnOption: .longText, clearButtonMode: .always)]
    }
}
