//
//  MasterViewController.swift
//  OfflineNavigationBar
//
//  Created by Jorge Bernal Ordovas on 05/01/16.
//  Copyright © 2016 WordPress. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let closeButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "done")
        navigationItem.rightBarButtonItem = closeButton
    }

    func done() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = "Sample cell"
        cell.accessoryType = .DisclosureIndicator
        return cell
    }

}

