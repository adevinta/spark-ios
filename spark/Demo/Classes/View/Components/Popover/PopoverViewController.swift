//
//  PopoverViewController.swift
//  PopupUIKit
//
//  Created by alican.aycil on 01.03.24.
//

// swiftlint:disable all
import UIKit

final class PopoverViewController: UIViewController {

    let popoverView = PopoverView()

    override func loadView() {
        super.loadView()
        view = popoverView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        popoverView.closeButton.addTarget(self, action: #selector(close(sender:)), for: .touchUpInside)
    }

    init(sourceView: UIView) {
        super.init(nibName: nil, bundle: nil)

        //First time that I set preferredContentSize
        preferredContentSize = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        modalPresentationStyle = .popover

        guard let controller = popoverPresentationController else { return }

        // we can set the position of arrow manually
        controller.permittedArrowDirections = .unknown

        controller.delegate = self
        controller.sourceView = sourceView

        // Our custom backgroundView for popover.
        controller.popoverBackgroundViewClass = CustomPopoverBackgroundView<Medium>.self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLayoutSubviews() {
        //Second time that I set preferredContentSize (It cant calculate label height for first time properly)
        preferredContentSize = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    @objc func close(sender: UIButton?) {
        print("CLOSE BUTTON TAPPED")
        self.dismiss(animated: true)
    }
}

//MARK: Delegate
extension PopoverViewController: UIPopoverPresentationControllerDelegate {

    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        print("PREPARE FOR PRESENTATION")
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        print("ADAPTIVE STYLE")
        return .none
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        print("SHOULD PRESENT")
        return true
    }

    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print("PRESENT")
    }
}
