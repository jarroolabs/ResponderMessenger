//
//  MVVMExampleController.swift
//  ResponderMessenger_Example
//
//  Created by Alex on 22/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ResponderMessenger

class MVVMExampleController: UIViewController {
    lazy var viewModel:ViewModel = ViewModel(with: self.makeMessenger(for: ViewModelMessenger.self))

    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var receiveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        receiveButton.layer.borderWidth = 2
        receiveButton.layer.borderColor = receiveButton.tintColor.cgColor
        receiveButton.layer.cornerRadius = 4
        receiveButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        viewModel.sendMessage()
    }
}

extension MVVMExampleController: ViewModelMessenger {
    func receive() {
        messageLabel.text = "Message received ✨"
    }
}
