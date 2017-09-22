//
//  MessageResponderTests.swift
//  Hivemind
//
//  Created by Alex on 19/09/2017.
//  Copyright © 2017 Hivemind. All rights reserved.
//

import XCTest
import ResponderMessenger

class ResponderMessengerTests: XCTestCase {
    
    func testMessageSend() {
        let exp = expectation(description: "expMessageReceived")

        // Wait for message to arrive on parent responder
        let responder3 = ParentResponder()
        responder3.messageReceivedHandler = {
            exp.fulfill()
        }

        let responder2 = IntermediateResponder(with: responder3)
        let responder1 = IntermediateResponder(with: responder2)

        let messageResponder = responder1.makeMessenger(for: TestMessengerInterface.self)
        messageResponder.send(to: { $0.sendReceived() })

        waitForExpectations(timeout: 5)
    }
}
