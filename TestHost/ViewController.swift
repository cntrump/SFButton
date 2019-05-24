//
//  ViewController.swift
//  TestHost
//
//  Created by vvveiii on 2019/5/9.
//  Copyright © 2019 lvv. All rights reserved.
//

import UIKit
import SFButton

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = makeButton()
        button.spacing = 10
        button.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        button.setTitle("direction: row", for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
            ])

        let button2 = makeButton()
        button2.spacing = 10
        button2.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        button2.direction = .rowReverse
        button2.setTitle("direction: rowReverse", for: .normal)
        view.addSubview(button2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: button2, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button2, attribute: .top, relatedBy: .equal, toItem: button, attribute: .bottom, multiplier: 1, constant: 10)
            ])

        let button3 = makeButton()
        button3.spacing = 5
        button3.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button3.direction = .column
        button3.setTitle("direction: column", for: .normal)
        view.addSubview(button3)
        button3.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: button3, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button3, attribute: .top, relatedBy: .equal, toItem: button2, attribute: .bottom, multiplier: 1, constant: 10)
            ])

        let button4 = makeButton()
        button4.spacing = 5
        button4.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button4.direction = .columnReverse
        button4.setTitle("direction: columnReverse", for: .normal)
        view.addSubview(button4)
        button4.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: button4, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button4, attribute: .top, relatedBy: .equal, toItem: button3, attribute: .bottom, multiplier: 1, constant: 10)
            ])
    }

    func makeButton() -> SFButton {
        let btnNormalBGImage = UIImage(named: "button_normal")!.resizableImage(withCapInsets: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        let btnHighlightedBGImage = UIImage(named: "button_highlighted")!.resizableImage(withCapInsets: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))

        let button = SFButton(frame: .zero)
        button.setImage(UIImage(named: "icon-test"), for: .normal)
        button.setBackgroundImage(btnNormalBGImage, for: .normal)
        button.setBackgroundImage(btnHighlightedBGImage, for: .highlighted)

        return button
    }
}

