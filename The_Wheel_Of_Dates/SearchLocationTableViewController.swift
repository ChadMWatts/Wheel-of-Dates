//
//  SearchLocationTableViewController.swift
//  The_Wheel_Of_Dates
//
//  Created by Chad Watts on 8/31/16.
//  Copyright © 2016 Chad Watts. All rights reserved.
//

import UIKit
import MapKit

class LocationTableSearch: UITableViewController, UISearchControllerDelegate {
    
    static let sharedLocationController = LocationTableSearch()
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView?
    weak var handleMapSearchDelegate: HandleMapSearch?
    static let sharedController = LocationTableSearch()

    func sortAddress(sortedItem: MKPlacemark) -> String {
        
        // Creates a space
        let firstSpace = (sortedItem.subThoroughfare != nil &&
            sortedItem.thoroughfare != nil) ? " " : ""
        
        let comma = (sortedItem.subThoroughfare != nil || sortedItem.thoroughfare != nil) &&
            (sortedItem.subAdministrativeArea != nil || sortedItem.administrativeArea != nil) ? " " : ""
        
        let secondSpace = (sortedItem.subAdministrativeArea != nil &&
            sortedItem.administrativeArea != nil) ? " " : ""
        
        let adressLine = String(format: "%@%@%@%@%@%@%@",
                                
                                sortedItem.subThoroughfare ?? "",
                                firstSpace,
                                
                                sortedItem.locality ?? "",
                                secondSpace,
                                
                                sortedItem.thoroughfare ?? "",
                                comma,
                                
                                sortedItem.administrativeArea ?? "")
                                return adressLine
    }

    
}

extension LocationTableSearch: UISearchResultsUpdating {
    
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

extension LocationTableSearch {
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell")!
        
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = sortAddress(selectedItem)
        return cell
    }
}

// Mark: - placemark for selected destination

extension LocationTableSearch {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(selectedItem)
        dismissViewControllerAnimated(true, completion: nil)
    }
}
 




