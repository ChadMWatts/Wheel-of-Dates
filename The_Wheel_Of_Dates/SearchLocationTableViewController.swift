//
//  SearchLocationTableViewController.swift
//  The_Wheel_Of_Dates
//
//  Created by Chad Watts on 8/31/16.
//  Copyright © 2016 Chad Watts. All rights reserved.
//

import UIKit
import MapKit

class SearchLocationTableViewController: UITableViewController, UISearchControllerDelegate {
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var handleMapSearchDelegate: HandleMapSearch? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    func sortAddress(sortedItem: MKPlacemark) -> String {
        
        // Creates a space
        let firstSpace = (sortedItem.subThoroughfare != nil && sortedItem.subThoroughfare != nil) ? " " : ""
        let comma = (sortedItem.subThoroughfare != nil || sortedItem.subThoroughfare != nil) && (sortedItem.subAdministrativeArea != nil || sortedItem.subAdministrativeArea != nil) ? " " : ""
        let secondSpace = (sortedItem.subAdministrativeArea != nil && sortedItem.subAdministrativeArea != nil) ? " " : ""
        let adressLine = String(format: "%@%@%@%@%@%@%@",
                                sortedItem.subThoroughfare ?? "",
                                firstSpace,
                                sortedItem.subThoroughfare ?? "",
                                secondSpace,
                                sortedItem.subThoroughfare ?? "",
                                comma,
                                sortedItem.subAdministrativeArea ?? "")
                                return adressLine
        
        
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

extension SearchLocationTableViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        guard let mapView = mapView,
            searchBarText = searchController.searchBar.text else {return}
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { response, _ in
            guard let response = response else {return}
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

extension SearchLocationTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return matchingItems.count
    }
 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCelll")!
        
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = sortAddress(selectedItem)
        return cell
    }
}
 




