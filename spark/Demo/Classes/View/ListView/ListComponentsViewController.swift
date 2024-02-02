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
        snapShot.appendSections([.all])
        snapShot.appendItems(uiComponentAllCases.map{ $0.rawValue }, toSection: .all)
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

        switch uiComponentAllCases[indexPath.row] {
        case .badge:
            viewController = ListViewController<BadgeCell, BadgeConfiguration>()
        case .button:
            viewController = ListViewController<ButtonCell, ButtonConfiguration>()
        case .checkbox:
            viewController = ListViewController<CheckboxCell, CheckboxConfiguration>()
        case .checkboxGroup:
            viewController = ListViewController<CheckboxGroupCell, CheckboxGroupConfiguration>()
        case .chip:
            viewController = ListViewController<ChipCell, ChipConfiguration>()
        case .icon:
            viewController = ListViewController<IconCell, IconConfiguration>()
        case .progressBarIndeterminate:
            viewController = ListViewController<ProgressBarIndeterminateCell, ProgressBarIndeterminateConfiguration>()
        case .progressBarSingle:
            viewController = ListViewController<ProgressBarSingleCell, ProgressBarSingleConfiguration>()
        case .radioButton:
            viewController = ListViewController<RadioButtonCell, RadioButtonConfiguration>()
        case .radioButtonGroup:
            viewController = ListViewController<RadioButtonGroupCell, RadioButtonGroupConfiguration>()
        case .ratingDisplay:
            viewController = ListViewController<RatingDisplayCell, RatingDisplayConfiguration>()
        case .ratingInput:
            viewController = ListViewController<RatingInputCell, RatingInputConfiguration>()
        case .spinner:
            viewController = ListViewController<SpinnerCell, SpinnerConfiguration>()
        case .star:
            viewController = ListViewController<StarCell, StarCellConfiguration>()
        case .switchButton:
            viewController = ListViewController<SwitchButtonCell, SwitchButtonConfiguration>()
        case .tab:
            viewController = ListViewController<TabCell, TabConfiguration>()
        case .tag:
            viewController = ListViewController<TagCell, TagConfiguration>()
        default:
            break
        }
        guard viewController != nil else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Enums
private extension ListComponentsViewController {

    enum Section {
        case all
    }
}

private extension UIComponent {
    static let checkboxGroup = UIComponent(rawValue: "Checkbox Group")
    static let radioButtonGroup = UIComponent(rawValue: "Radio Button Group")
}
