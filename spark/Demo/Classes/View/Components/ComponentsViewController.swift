//
//  ComponentsViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 14.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

final class ComponentsViewController: UICollectionViewController {

    // MARK: - Typealias
    fileprivate typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    fileprivate typealias SnapShot = NSDiffableDataSourceSnapshot<Section, String>

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
        navigationItem.title = "UIComponents"
        setupData()
    }

    private func setupData() {
        /// CollectionView append sections and items
        var snapShot = SnapShot()
        snapShot.appendSections([.all])
        snapShot.appendItems(UIComponent.allCases.map{ $0.rawValue }, toSection: .all)
        collectionViewDataSource.apply(snapShot)
    }
}

// MARK: - CollectionViewLayout
extension ComponentsViewController {

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

// MARK: - CollectionViewDelegates
extension ComponentsViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = UIComponent.allCases[indexPath.row]
        var viewController: UIViewController!
        switch section {
        case .badge:
            viewController = BadgeComponentViewController.build()
        case .bottomSheet:
            viewController = BottomSheetPresentingUIViewController.build()
        case .button:
            viewController = ButtonComponentViewController.build()
        case .iconButton:
            viewController = IconButtonComponentViewController.build()
        case .checkbox:
            viewController = UIHostingController(
                rootView: ComponentsCheckboxListView(
                    isSwiftUI: false
                ).environment(\.navigationController, self.navigationController)
            )
        case .chip:
            viewController = ChipComponentViewController.build()
        case .formField:
            viewController = FormFieldComponentUIViewController.build()
        case .icon:
            viewController = IconComponentUIViewController.build()
        case .progressBarIndeterminate:
            viewController = ProgressBarIndeterminateComponentUIViewController.build()
        case .progressBarSingle:
            viewController = ProgressBarComponentUIViewController.build()
        case .progressTracker:
            viewController = ProgressTrackerComponentUIViewController.build()
        case .radioButton:
            viewController = RadioButtonComponentUIViewController.build()
        case .ratingDisplay:
            viewController = RatingDisplayComponentViewController.build()
        case .ratingInput:
            viewController = RatingInputComponentViewController.build()
        case .slider:
            viewController = SliderComponentUIViewController.build()
        case .spinner:
            viewController = SpinnerComponentUIViewController.build()
        case .star:
            viewController = StarComponentViewController.build()
        case .switchButton:
            viewController = SwitchComponentUIViewController.build()
        case .tab:
            viewController = TabComponentUIViewController.build()
        case .tag:
            viewController = TagComponentUIViewController.build()
        case .textField:
            viewController = TextFieldComponentUIViewController.build()
        case .textFieldAddons:
            viewController = TextFieldAddonsComponentUIViewController.build()
        case .textLink:
            viewController = TextLinkComponentUIViewController.build()
        default:
            break
        }
        guard viewController != nil else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Enums
private extension ComponentsViewController {

    enum Section {
        case all
    }
}
