//
//  FormFieldsViewController.swift
//  SparkDemo
//
//  Created by robin.lemaire on 23/10/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

final class FormFieldsViewController: UICollectionViewController {

    // MARK: - Typealias
    fileprivate typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    fileprivate typealias SnapShot = NSDiffableDataSourceSnapshot<Section, String>

    // MARK: - Properties
    private let reuseIdentifier = "FormFieldReuseIdentifier"

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
        return DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(
                            using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }()

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "FormField"
        setupData()
    }

    private func setupData() {
        /// CollectionView append sections and items
        var snapShot = SnapShot()
        snapShot.appendSections([.all])
        snapShot.appendItems(FormFieldComponentStyle.allCases.map{ $0.name }, toSection: .all)
        collectionViewDataSource.apply(snapShot)
    }

    // MARK: - Maker

    static func makeBasicView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }

    static func makeSingleCheckbox() -> CheckboxUIView {
        return CheckboxUIView(
            theme: SparkTheme.shared,
            text: "Hello World",
            checkedImage: DemoIconography.shared.checkmark.uiImage,
            selectionState: .unselected,
            alignment: .left
        )
    }

    static func makeVerticalCheckbox() -> CheckboxGroupUIView {
        let view = CheckboxGroupUIView(
            checkedImage: DemoIconography.shared.checkmark.uiImage,
            items: [
                CheckboxGroupItemDefault(title: "Checkbox 1", id: "1", selectionState: .unselected, isEnabled: true),
                CheckboxGroupItemDefault(title: "Checkbox 2", id: "2", selectionState: .selected, isEnabled: true),
            ],
            theme: SparkTheme.shared,
            intent: .success,
            accessibilityIdentifierPrefix: "checkbox"
        )
        view.layout = .vertical
        return view
    }

    static func makeHorizontalCheckbox() -> CheckboxGroupUIView {
        let view = CheckboxGroupUIView(
            checkedImage: DemoIconography.shared.checkmark.uiImage,
            items: [
                CheckboxGroupItemDefault(title: "Checkbox 1", id: "1", selectionState: .unselected, isEnabled: true),
                CheckboxGroupItemDefault(title: "Checkbox 2", id: "2", selectionState: .selected, isEnabled: true),
            ],
            theme: SparkTheme.shared,
            intent: .alert,
            accessibilityIdentifierPrefix: "checkbox"
        )
        view.layout = .horizontal
        return view
    }

    static func makeHorizontalScrollableCheckbox() -> CheckboxGroupUIView {
        let view = CheckboxGroupUIView(
            checkedImage: DemoIconography.shared.checkmark.uiImage,
            items: [
                CheckboxGroupItemDefault(title: "Hello World", id: "1", selectionState: .unselected, isEnabled: true),
                CheckboxGroupItemDefault(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", id: "2", selectionState: .selected, isEnabled: true),
            ],
            theme: SparkTheme.shared,
            accessibilityIdentifierPrefix: "checkbox"
        )
        view.layout = .horizontal
        return view
    }

    static func makeSingleRadioButton() -> UIControl {
        return RadioButtonUIView(
            theme: SparkTheme.shared,
            intent: .info,
            id: "radiobutton",
            label: NSAttributedString(string: "Hello World"),
            isSelected: true
        )
    }

    static func makeVerticalRadioButton() -> UIControl {
        return RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            intent: .danger,
            selectedID: "radiobutton",
            items: [
                RadioButtonUIItem(id: "1", label: "Radio Button 1"),
                RadioButtonUIItem(id: "2", label: "Radio Button 2"),
            ],
            groupLayout: .vertical
        )
    }

    static func makeHorizontalRadioButton() -> UIControl {
        return RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            intent: .support,
            selectedID: "radiobutton",
            items: [
                RadioButtonUIItem(id: "1", label: "Radio Button 1"),
                RadioButtonUIItem(id: "2", label: "Radio Button 2"),
            ],
            groupLayout: .horizontal
        )
    }

    static func makeTextField() -> TextFieldUIView {
        let view = TextFieldUIView(
            theme: SparkTheme.shared,
            intent: .alert
        )
        return view
    }

    static func makeAddOnTextField() -> TextFieldUIView {
        let view = TextFieldUIView(
            theme: SparkTheme.shared,
            intent: .alert
        )
        view.text = "I couldn't add addOnTextField. It is not UIControl for now"
        return view
    }

    static func makeRatingInput() -> RatingInputUIView {
        return RatingInputUIView(
            theme: SparkTheme.shared,
            intent: .main,
            rating: 2.0
        )
    }
}

// MARK: - CollectionViewLayout
extension FormFieldsViewController {

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

// MARK: - CollectionViewDelegates
extension FormFieldsViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = FormFieldComponentStyle.allCases[indexPath.row]
        var viewController: UIViewController!

        let viewModel = FormFieldComponentUIViewModel(
            theme: SparkThemePublisher.shared.theme
        )
        let feedbackState: FormFieldFeedbackState = .default
        let title = "Agreement"
        let helper = "Your agreement is important to us."

        switch section {
        case .basic:
            viewController = FormFieldComponentUIViewController(
                view: .init(
                    viewModel: viewModel,
                    component: FormFieldUIView(
                        theme: viewModel.theme,
                        component: Self.makeBasicView(),
                        feedbackState: feedbackState,
                        title: title,
                        helper: helper
                    )
                ),
                viewModel: viewModel
            )

        case .singleCheckbox:
            viewController = FormFieldComponentUIViewController(
                view: .init(
                    viewModel: viewModel,
                    component: FormFieldUIView(
                        theme: viewModel.theme,
                        component: Self.makeSingleCheckbox(),
                        feedbackState: feedbackState,
                        title: title,
                        helper: helper
                    )
                ),
                viewModel: viewModel
            )

        case .verticalCheckbox:
            viewController = FormFieldComponentUIViewController(
                view: .init(
                    viewModel: viewModel,
                    component: FormFieldUIView(
                        theme: viewModel.theme,
                        component: Self.makeVerticalCheckbox(),
                        feedbackState: feedbackState,
                        title: title,
                        helper: helper
                    )
                ),
                viewModel: viewModel
            )

        case .horizontalCheckbox:
            viewController = FormFieldComponentUIViewController(
                view: .init(
                    viewModel: viewModel,
                    component: FormFieldUIView(
                        theme: viewModel.theme,
                        component: Self.makeHorizontalCheckbox(),
                        feedbackState: feedbackState,
                        title: title,
                        helper: helper
                    )
                ),
                viewModel: viewModel
            )

        case .horizontalScrollableCheckbox:
            viewController = FormFieldComponentUIViewController(
                view: .init(
                    viewModel: viewModel,
                    component: FormFieldUIView(
                        theme: viewModel.theme,
                        component: Self.makeHorizontalScrollableCheckbox(),
                        feedbackState: feedbackState,
                        title: title,
                        helper: helper
                    )
                ),
                viewModel: viewModel
            )

        case .singleRadioButton:
            viewController = FormFieldComponentUIViewController(
                view: .init(
                    viewModel: viewModel,
                    component: FormFieldUIView(
                        theme: viewModel.theme,
                        component: Self.makeSingleRadioButton(),
                        feedbackState: feedbackState,
                        title: title,
                        helper: helper
                    )
                ),
                viewModel: viewModel
            )

        case .verticalRadioButton:
            viewController = FormFieldComponentUIViewController(
                view: .init(
                    viewModel: viewModel,
                    component: FormFieldUIView(
                        theme: viewModel.theme,
                        component: Self.makeVerticalRadioButton(),
                        feedbackState: feedbackState,
                        title: title,
                        helper: helper
                    )
                ),
                viewModel: viewModel
            )

        case .horizontalRadioButton:
            viewController = FormFieldComponentUIViewController(
                view: .init(
                    viewModel: viewModel,
                    component: FormFieldUIView(
                        theme: viewModel.theme,
                        component: Self.makeHorizontalRadioButton(),
                        feedbackState: feedbackState,
                        title: title,
                        helper: helper
                    )
                ),
                viewModel: viewModel
            )

        case .textField:
            viewController = FormFieldComponentUIViewController(
                view: .init(
                    viewModel: viewModel,
                    component: FormFieldUIView(
                        theme: viewModel.theme,
                        component: Self.makeTextField(),
                        feedbackState: feedbackState,
                        title: title,
                        helper: helper
                    )
                ),
                viewModel: viewModel
            )

        case .addOnTextField:
            viewController = FormFieldComponentUIViewController(
                view: .init(
                    viewModel: viewModel,
                    component: FormFieldUIView(
                        theme: viewModel.theme,
                        component: Self.makeAddOnTextField(),
                        feedbackState: feedbackState,
                        title: title,
                        helper: helper
                    )
                ),
                viewModel: viewModel
            )

        case .ratingInput:
            viewController = FormFieldComponentUIViewController(
                view: .init(
                    viewModel: viewModel,
                    component: FormFieldUIView(
                        theme: viewModel.theme,
                        component: Self.makeRatingInput(),
                        feedbackState: feedbackState,
                        title: title,
                        helper: helper
                    )
                ),
                viewModel: viewModel
            )
        }

        guard viewController != nil else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Enums
private extension FormFieldsViewController {

    enum Section {
        case all
    }
}
