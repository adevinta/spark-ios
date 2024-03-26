//
//  ListComponentsViewController.swift
//  Spark
//
//  Created by alican.aycil on 13.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

final class ListComponentsViewController: UICollectionViewController {

    // MARK: - Typealias
    fileprivate typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    fileprivate typealias SnapShot = NSDiffableDataSourceSnapshot<Section, String>

    // MARK: - Properties
    private let reuseIdentifier = "defaultCell"

    var uiComponentAllCases: [UIComponent] {
        var all = UIComponent.allCases
        all.insert(.checkboxGroup, at: 3)
        all.insert(.radioButtonGroup, at: 9)
        all.append(.addOnTextField)
        return all
    }

    private lazy var collectionViewDataSource: DataSource = {
        /// CollectionView cell registration
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, title: String) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = title
            cell.contentConfiguration = contentConfiguration
            cell.accessories = [.disclosureIndicator(options: .init(tintColor: .systemGray3))]
        }
        /// CollectionView diffable data source
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(
                            using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        return dataSource
    }()

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "List"
        setupData()
    }

    private func setupData() {
        /// CollectionView append sections and items
        var snapShot = SnapShot()
        snapShot.appendSections([.list, .random])
        snapShot.appendItems(uiComponentAllCases.map{ $0.rawValue }, toSection: .list)
        snapShot.appendItems(Row.allCases.map{ $0.name }, toSection: .random)
        collectionViewDataSource.apply(snapShot)
    }
}

// MARK: - CollectionViewLayout
extension ListComponentsViewController {

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

// MARK: - CollectionViewDelegates
extension ListComponentsViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        var viewController: UIViewController!

        switch Section.allCases[indexPath.section] {
        case .list:
            viewController = self.listSectionControllers(index: indexPath.row)
        case .random:
            viewController = self.randomSectionControllers(index: indexPath.row)
        }

        guard viewController != nil else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    private func listSectionControllers(index: Int) -> UIViewController? {

        switch uiComponentAllCases[index] {
        case .badge:
            return ListViewController<BadgeCell, BadgeConfiguration>()
        case .button:
            return ListViewController<ButtonCell, ButtonConfiguration>()
        case .checkbox:
            return ListViewController<CheckboxCell, CheckboxConfiguration>()
        case .checkboxGroup:
            return ListViewController<CheckboxGroupCell, CheckboxGroupConfiguration>()
        case .chip:
            return ListViewController<ChipCell, ChipConfiguration>()
        case .icon:
            return ListViewController<IconCell, IconConfiguration>()
        case .progressBarIndeterminate:
            return ListViewController<ProgressBarIndeterminateCell, ProgressBarIndeterminateConfiguration>()
        case .progressBarSingle:
            return ListViewController<ProgressBarSingleCell, ProgressBarSingleConfiguration>()
        case .radioButton:
            return ListViewController<RadioButtonCell, RadioButtonConfiguration>()
        case .radioButtonGroup:
            return ListViewController<RadioButtonGroupCell, RadioButtonGroupConfiguration>()
        case .ratingDisplay:
            return ListViewController<RatingDisplayCell, RatingDisplayConfiguration>()
        case .ratingInput:
            return ListViewController<RatingInputCell, RatingInputConfiguration>()
        case .spinner:
            return ListViewController<SpinnerCell, SpinnerConfiguration>()
        case .star:
            return ListViewController<StarCell, StarCellConfiguration>()
        case .switchButton:
            return ListViewController<SwitchButtonCell, SwitchButtonConfiguration>()
        case .tab:
            return ListViewController<TabCell, TabConfiguration>()
        case .tag:
            return ListViewController<TagCell, TagConfiguration>()
        case .textField:
            return ListViewController<TextFieldCell, TextFieldConfiguration>()
        case .addOnTextField:
            return ListViewController<AddOnTextFieldCell, AddOnTextFieldConfiguration>()
        default:
            return nil
        }
    }

    private func randomSectionControllers(index: Int) -> UIViewController? {
        switch Row.allCases[index] {
        case .radioCheckboxSwiftui:
            return UIHostingController(
                rootView: RadioCheckboxView().environment(\.navigationController, self.navigationController)
            )
        case .radioCheckboxUikit:
            return RadioCheckboxUIViewController()
        }
    }
}

// MARK: - Enums
private extension ListComponentsViewController {

    enum Section: CaseIterable {
        case list
        case random
    }

    enum Row: CaseIterable {
        case radioCheckboxSwiftui
        case radioCheckboxUikit
    }
}

private extension UIComponent {
    static let checkboxGroup = UIComponent(rawValue: "Checkbox Group")
    static let radioButtonGroup = UIComponent(rawValue: "Radio Button Group")
    static let addOnTextField = UIComponent(rawValue: "Add-on Text Field")
}
