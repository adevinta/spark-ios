//
//  ViewController.swift
//  PopupUIKit
//
//  Created by Michael Zimmermann on 20.02.24.
//

// swiftlint:disable all
import UIKit

class PopoverDemoViewController: UIViewController {

    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var button3: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var button4: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(button)
        self.scrollView.addSubview(button1)
        self.scrollView.addSubview(button2)
        self.scrollView.addSubview(button3)

        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80).isActive = true
        button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 300).isActive = true

        button1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 280).isActive = true
        button1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 100).isActive = true

        button2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button2.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 580).isActive = true
        button2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true

        button3.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button3.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1100).isActive = true
        button3.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
        button3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 250).isActive = true


        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        button1.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }

    @objc func buttonTapped(sender: UIView?) {
        guard let sender = sender else { return }

        let controller = PopoverViewController(sourceView: sender)

        print("BUTTON TAPPED")

        self.present(controller, animated: true, completion: {
            print("pop over is visible")
        })
    }
}
