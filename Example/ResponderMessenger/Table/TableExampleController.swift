//
//  TableExampleController.swift
//  ResponderMessenger_Example
//
//  Created by Alex on 22/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

protocol TableExampleMessenger {
    func receive()
}

class TableExampleController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(TableExampleCell.self, forCellReuseIdentifier: TableExampleCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableExampleCell.identifier, for: indexPath) as! TableExampleCell
        cell.textLabel?.text = "Tap to send message from cell to controller"

        // When using the built-in UITableViewController, the following line is not necessary, as the controller
        // sets up the responder chain down to the cell correctly. If you're using your own table view, you will need to
        // hook this up yourself:
        //
        // cell.nextMessageResponder = self

        return cell
    }
}

extension TableExampleController: TableExampleMessenger {
    func receive() {
        let row = (tableView.indexPathForSelectedRow?.row ?? 0) + 1
        let alert = UIAlertController(title: nil, message: "Received message from cell \(row) ✨", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        present(alert, animated: true)
    }
}
