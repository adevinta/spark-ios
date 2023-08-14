//
//  ComponentsViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 14.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// swiftlint: disable all

import UIKit

final class ComponentsViewController: UICollectionViewController {

    typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, String>

    private let reuseIdentifier = "defaultCell"

    private lazy var collectionViewDataSource: DataSource = {

        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, title: String) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = title
            cell.contentConfiguration = contentConfiguration
            cell.accessories = [.disclosureIndicator(options: .init(tintColor: .systemGray3))]
        }

        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(
                            using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "UIComponents"
        setupData()
    }

    private func setupData() {
        var snapShot = SnapShot()
        snapShot.appendSections([.all])
        snapShot.appendItems(Row.allCases.map{ $0.name }, toSection: .all)
        collectionViewDataSource.apply(snapShot)
    }

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Row.allCases[indexPath.row]

        switch section {
        case .badge:
        default
            break
        }
    }
}

extension ComponentsViewController {

    enum Section {
        case all
    }

    enum Row: CaseIterable {
        case badge
        case button
        case checkbox
        case chip
        case icon
        case radioButton
        case spinner
        case switchButton
        case tag
    }
}
