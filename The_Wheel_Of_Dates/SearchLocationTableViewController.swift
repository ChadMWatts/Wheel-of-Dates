//
//  SearchLocationTableViewController.swift
//  The_Wheel_Of_Dates
//
//  Created by Chad Watts on 8/31/16.
//  Copyright © 2016 Chad Watts. All rights reserved.
//

import UIKit

class SearchLocationTableViewController: UITableViewController, UISearchControllerDelegate {
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
}

extension SearchLocationTableViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //
    }
}



