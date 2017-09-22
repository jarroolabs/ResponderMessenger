//
//  TestsSupport.swift
//  ResponderMessenger_Tests
//
//  Created by Alex on 22/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

protocol TestMessengerInterface {
    func sendReceived()
}

class IntermediateResponder: UIResponder {
    private weak var parent: UIResponder?

    init(with parent: UIResponder?) {
        self.parent = parent
    }

    override var next: UIResponder? {
        return parent
    }
}

class ParentResponder: UIResponder, TestMessengerInterface {
    var messageReceivedHandler: (() -> Void)?

    func sendReceived() {
        messageReceivedHandler?()
    }
}
