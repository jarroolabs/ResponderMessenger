//
//  ViewModel.swift
//  ResponderMessenger_Example
//
//  Created by Alex on 22/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ResponderMessenger

protocol ViewModelMessenger {
    func receive()
}

class ViewModel {
    let messenger: ResponderMessenger<ViewModelMessenger>

    init(with messenger: ResponderMessenger<ViewModelMessenger>) {
        self.messenger = messenger
    }

    func sendMessage() {
        messenger.send(to: { $0.receive() })
    }
}
