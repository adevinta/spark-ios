//
//  IconButtonComponentUIView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkCore
@_spi(SI_SPI) import SparkCommon

final class IconButtonComponentViewController2: UIViewController {

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            self.loadButton,
            self.buttonsStackView,
            UIView()
        ])
        view.axis = .vertical
        view.spacing = 30
        view.alignment = .leading
        return view
    }()

    private lazy var loadButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("Stop", for: .selected)
        view.setTitle("Start", for: .normal)
        view.addAction(.init(handler: { _ in
            self.isAnimated.toggle()
            view.isSelected = self.isAnimated
        }), for: .touchUpInside)
        view.setTitleColor(.systemBlue, for: .normal)
        return view
    }()

    private lazy var buttonsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            self.buttonViewStackView,
            self.button2ViewStackView
        ])
        view.axis = .vertical
        view.spacing = 24
        return view
    }()

    private lazy var buttonViewStackView: UIStackView = {
        self.buttonViewStackView(
            self.buttonView,
            iconButtonView: self.iconButtonView,
            title: "Infinite"
        )
    }()

    private lazy var buttonView: ButtonUIView = {
        let view = ButtonUIView(
            theme: SparkTheme.shared,
            intent: .main,
            variant: .filled,
            size: .medium,
            shape: .rounded,
            alignment: .leadingImage
        )
        view.setImage(self.image, for: .normal)
        view.setTitle("My Text", for: .normal)
        return view
    }()

    private lazy var iconButtonView: IconButtonUIView = {
        let view = IconButtonUIView(
            theme: SparkTheme.shared,
            intent: .support,
            variant: .filled,
            size: .medium,
            shape: .rounded
        )
        view.setImage(self.image, for: .normal)
        return view
    }()

    private lazy var button2ViewStackView: UIStackView = {
        self.buttonViewStackView(
            self.button2View,
            iconButtonView: self.iconButton2View,
            title: "Limit (3)"
        )
    }()

    private lazy var button2View: ButtonUIView = {
        let view = ButtonUIView(
            theme: SparkTheme.shared,
            intent: .success,
            variant: .outlined,
            size: .medium,
            shape: .rounded,
            alignment: .leadingImage
        )
        view.setImage(self.image, for: .normal)
        view.setTitle("My Text", for: .normal)
        return view
    }()

    private lazy var iconButton2View: IconButtonUIView = {
        let view = IconButtonUIView(
            theme: SparkTheme.shared,
            intent: .danger,
            variant: .filled,
            size: .medium,
            shape: .rounded
        )
        view.setImage(self.image, for: .normal)
        return view
    }()

    private func buttonViewStackView(_ buttonView: UIView, iconButtonView: UIView, title: String) -> UIStackView {
        let label = UILabel()
        label.text = title

        let view = UIStackView(arrangedSubviews: [
            label,
            iconButtonView,
            buttonView
        ])
        view.axis = .horizontal
        view.spacing = 12
        return view
    }

    private var image = UIImage(systemName: "bell")

    private var isAnimated: Bool = false {
        didSet {
            if self.isAnimated {
//                UIView.sparkAnimate(
//                    withType: .bell,
//                    on: self.buttonView.imageView,
//                    delay: 2,
//                    repeat: true,
//                    completion: { _ in
//                        print("LOGROB Animation finished")
//                    })

//                UIView.animate(withDuration: 2, delay: 2, options: .repeat, animations: {
//                    self.loadButton.alpha = 0
//                }, completion: { _ in
//                    self.loadButton.alpha = 1
//                    print("LOGROB Animation finished")
//                })


//                self.animation.start()
//                self.animation3.start(with: 3)
            } else {
//                self.animation.stop()
//                self.animation3.stop()
            }
        }
    }

    private lazy var animation: SparkAnimation = {
        RotateWithDampingAnimation(
            from: self.buttonView.imageView,
            self.iconButtonView.imageView
        )
    }()
    private lazy var animation3: SparkAnimation = {
        RotateWithDampingAnimation(
            from: self.button2View,
            self.iconButton2View
        )
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.contentStackView)
        self.view.backgroundColor = .systemBackground

        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.contentStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.contentStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    deinit {
        print("LOGROB DEINIT VC")
    }
}

// TODO: move into an another repository






















final class IconButtonComponentUIView: ComponentUIView {

    // MARK: - Components

    private let buttonView: IconButtonUIView

    // MARK: - Properties

    private let viewModel: IconButtonComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    private lazy var buttonAction: UIAction = .init { _ in
        self.showAlert(for: .action)
    }
    private lazy var buttonToggleAction: UIAction = .init { _ in
        self.viewModel.isSelectedChanged()
    }
    private var buttonControlCancellable: AnyCancellable?

    // MARK: - Initializer

    init(viewModel: IconButtonComponentUIViewModel) {
        self.viewModel = viewModel
        self.buttonView = .init(
            theme: viewModel.theme,
            intent: viewModel.intent,
            variant: viewModel.variant,
            size: viewModel.size,
            shape: viewModel.shape
        )
        self.buttonView.accessibilityLabel = "My icon button"

        super.init(
            viewModel: viewModel,
            componentView: self.buttonView
        )

        // Setup
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(theme: theme)

            self.buttonView.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.buttonView.intent = intent
        }

        self.viewModel.$variant.subscribe(in: &self.cancellables) { [weak self] variant in
            guard let self = self else { return }
            self.viewModel.variantConfigurationItemViewModel.buttonTitle = variant.name
            self.buttonView.variant = variant
        }

        self.viewModel.$size.subscribe(in: &self.cancellables) { [weak self] size in
            guard let self = self else { return }
            self.viewModel.sizeConfigurationItemViewModel.buttonTitle = size.name
            self.buttonView.size = size
        }

        self.viewModel.$shape.subscribe(in: &self.cancellables) { [weak self] shape in
            guard let self = self else { return }
            self.viewModel.shapeConfigurationItemViewModel.buttonTitle = shape.name
            self.buttonView.shape = shape
        }

        self.viewModel.$contentNormal.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.showRightSpacing = content != .image
            self.setContent(content, for: .normal)
        }

        self.viewModel.$contentHighlighted.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.viewModel.contentHighlightedConfigurationItemViewModel.buttonTitle = content.name
            self.setContent(content, for: .highlighted)
        }

        self.viewModel.$contentDisabled.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.viewModel.contentDisabledConfigurationItemViewModel.buttonTitle = content.name
            self.setContent(content, for: .disabled)
        }

        self.viewModel.$contentSelected.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.viewModel.contentSelectedConfigurationItemViewModel.buttonTitle = content.name
            self.setContent(content, for: .selected)
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) { [weak self] isEnabled in
            guard let self = self else { return }
            self.buttonView.isEnabled = isEnabled
        }

        self.viewModel.$isSelected.subscribe(in: &self.cancellables) { [weak self] isSelected in
            guard let self = self else { return }
            self.buttonView.isSelected = isSelected
        }

        self.viewModel.$isAnimated.subscribe(in: &self.cancellables) { [weak self] isAnimated in
            guard let self = self else { return }
            self.buttonView.isAnimated = isAnimated
        }

        self.viewModel.$controlType.subscribe(in: &self.cancellables) { [weak self] controlType in
            guard let self = self else { return }
            self.viewModel.controlTypeConfigurationItemViewModel.buttonTitle = controlType.name
            self.setControl(from: controlType)
        }
    }

    // MARK: - Setter

    private func setContent(_ content: IconButtonContentDefault, for state: ControlState) {
        switch content {
        case .image:
            self.buttonView.setImage(self.image(for: state), for: state)

        case .none:
            self.buttonView.setImage(nil, for: state)
        }
    }

    private func setControl(from controlType: ButtonControlType) {
        // Publisher ?
        if controlType == .publisher {
            self.buttonControlCancellable = self.buttonView.tapPublisher.sink { _ in
                self.showAlert(for: .publisher)
            }
        } else {
            self.buttonControlCancellable?.cancel()
            self.buttonControlCancellable = nil
        }

        // Action ?
        if controlType == .action {
            self.buttonView.addAction(self.buttonAction, for: .touchUpInside)
        } else {
            self.buttonView.removeAction(self.buttonAction, for: .touchUpInside)
        }

        // Target ?
        if controlType == .target {
            self.buttonView.addTarget(self, action: #selector(self.touchUpInsideTarget), for: .touchUpInside)
        } else {
            self.buttonView.removeTarget(self, action: #selector(self.touchUpInsideTarget), for: .touchUpInside)
        }

        // Toggle ?
        if controlType == .toggle {
            self.buttonView.addAction(self.buttonToggleAction, for: .touchUpInside)
        } else {
            self.buttonView.removeAction(self.buttonToggleAction, for: .touchUpInside)
        }
    }

    // MARK: - Getter

    private func image(for state: ControlState) -> UIImage? {
        switch state {
        case .normal: return UIImage(named: "arrow")
        case .highlighted: return UIImage(named: "close")
        case .disabled: return UIImage(named: "check")
        case .selected: return UIImage(named: "alert")
        }
    }

    // MARK: - Action

    @objc func touchUpInsideTarget() {
        self.showAlert(for: .target)
    }

    // MARK: - Alert

    func showAlert(for controlType: ButtonControlType) {
        let alertController = UIAlertController(
            title: "Button tap from " + controlType.name,
            message: nil,
            preferredStyle: .alert
        )
        alertController.addAction(.init(title: "Ok", style: .default))
        self.viewController?.present(alertController, animated: true)
    }
}
