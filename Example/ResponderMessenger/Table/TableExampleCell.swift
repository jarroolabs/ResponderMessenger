//
//  TableExampleCell.swift
//  ResponderMessenger_Example
//
//  Created by Alex on 22/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class TableExampleCell: UITableViewCell {
    static let identifier = "TableExampleCell"

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            // makeMessenger(..) returns a messenger based on this cell's current responder chain
            let messenger = makeMessenger(for: TableExampleMessenger.self)

            // Sending the message will walk the chain, looking for an object conforming to TableExampleMessenger.
            // When found, you are give the instance, so you can invoke the method call.
            messenger.send(to: { $0.receive() })
        }
    }

}
