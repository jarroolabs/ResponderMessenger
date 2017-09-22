//
//  MessageResponder.swift
//
//  Created by Alex on 19/09/2017.
//

import Foundation
import UIKit

/// Interface to send messages using the responder chain.
/// `EndpointType` defines the protocol the receiving end should adopt.
/// Use the `send(to:)` and `send(bubbling:)` methods to send messages.
///
/// You should spawn an instance of this class using the `UIResponder.makeMessenger()` extension method.
/// Doing so inserts the messenger in the object's current responder chain.
public class ResponderMessenger<EndpointType>: UIResponder {
    public typealias EndpointMessenger = (EndpointType) -> Void

    /// Do not initialize yourself, use `UIResponder.makeMessenger()` instead.
    fileprivate override init() {}

    // MARK: API

    /// Send a message to the target, and stop once/if it's handled.
    ///
    /// - Parameter target: Closure that sends the message on the target
    public func send(to endpoint: EndpointMessenger) {
        self.send(to: endpoint, shouldBubble: false)
    }

    /// Send a message to the target, and travel up the chain to let every compliant target handle the message, in turn.
    ///
    /// - Parameter target: Closure that sends the message on the targets
    public func send(toAny endpoint: EndpointMessenger) {
        self.send(to: endpoint, shouldBubble: true)
    }

    // MARK: - Internal

    private func send(to messenger: EndpointMessenger, shouldBubble: Bool) {
        var responder: UIResponder? = self

        // Walk the responder chain to find an endpoint which conforms to the EndpointType protocol
        while responder?.nextMessageResponder != nil {
            // If found, pass the message
            if let endpoint = responder?.nextMessageResponder as? EndpointType {
                messenger(endpoint)

                // Bubble further up the chain if handled, or not
                if !shouldBubble { return }
            }

            // Move on to the next, if available
            responder = responder?.nextMessageResponder
        }

        // Developer warning: trap if sending to a single endpoint, but none is found. You may forgotten to conform to
        // the right protocol, or the chain doesn't give you a path to the endpoint.
        if !shouldBubble {
            // TODO: Print the offending responder chain
            assert(responder == nil, "ResponderMessenger: No next responder available to deliver message")
        }
    }
}

// MARK: - Extend `UIResponder`s to surface the `makeMessenger()` method for spawning messengers based on the current object's responder chain.
extension UIResponder {
    private struct AssociatedKeys {
        static var nextMessagingResponder = "NextMessageResponder"
    }

    /// The next responder in the chain to potentially handle any message sent (if the responder has adopted the `EndpointType`
    /// protocol defined by the messenger.
    ///
    /// You can set this yourself if necessary, e.g. in the case of table/collection view cells that want to pass messages
    /// to their parent controller.
    public var nextMessageResponder: UIResponder? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.nextMessagingResponder) as? UIResponder ?? next }
        set { objc_setAssociatedObject(self, &AssociatedKeys.nextMessagingResponder, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    /// Spawns a messenger, conforming to a given protocol for the endpoint target to conform to.
    ///
    /// - Parameter endpointType: The protocol the endpoint should conform to
    /// - Returns: A messenger that allows you to send messages to any endpoint that conforms to the endpoint type protocol.
    public func makeMessenger<T>(for endpointType: T.Type) -> ResponderMessenger<T> {
        let messagingChannel = ResponderMessenger<T>()
        messagingChannel.nextMessageResponder = self

        return messagingChannel
    }
}
