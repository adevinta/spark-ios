//
//  SettingsViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 11.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

final class SettingsViewController: UICollectionViewController {

    // MARK: - Typealias
    typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, String>

    // MARK: - Properties
    private let reuseIdentifier = "defaultCell"

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
        navigationItem.title = "Settings"
        setupData()
    }

    private func setupData() {
        /// CollectionView append sections and items
        var snapShot = SnapShot()
        snapShot.appendSections([.all])
        snapShot.appendItems(Row.allCases.map{ $0.name }, toSection: .all)
        collectionViewDataSource.apply(snapShot)
    }
}

// MARK: - CollectionViewLayout
extension SettingsViewController {

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

// MARK: - CollectionViewDelegates
extension SettingsViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Row.allCases[indexPath.row]
        var viewController: UIViewController!
        switch section {
        case .appearance:
            self.presentAppearanceSheet()
        }
        guard viewController != nil else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Navigation
extension SettingsViewController {

    private func presentAppearanceSheet() {

        let actionSheet = SparkActionSheet<UIUserInterfaceStyle>.init(
            values: [.unspecified, .light, . dark],
            texts: ["Unspecified", "Light", "Dark"]
        ) { mode in
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = mode
            }
        }
        self.present(actionSheet, isAnimated: true)
    }
}

// MARK: - Enums
extension SettingsViewController {

    enum Section {
        case all
    }

    enum Row: CaseIterable {
        case appearance
    }
}
