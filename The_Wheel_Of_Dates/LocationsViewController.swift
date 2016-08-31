//
//  LocationsViewController.swift
//  The_Wheel_Of_Dates
//
//  Created by Chad Watts on 8/30/16.
//  Copyright © 2016 Chad Watts. All rights reserved.
//

import UIKit
import MapKit

class LocationCell: UITableViewCell, UISearchControllerDelegate {
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationAddress: UILabel!
    @IBOutlet weak var locationRating: UILabel!
}

class LocationsViewController: UIViewController {

    @IBOutlet weak var locationsMapOutlet: MKMapView!
    @IBOutlet weak var locationInfoTableView: UITableViewCell!
    
    var searchResults: UISearchController? = nil
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let locationSearchTable = storyboard!.instantiateViewControllerWithIdentifier("locationSearchTable") as! SearchLocationTableViewController
        searchResults = UISearchController(searchResultsController: locationSearchTable)
        searchResults?.searchResultsUpdater = locationSearchTable
        searchResults?.hidesNavigationBarDuringPresentation = false
        searchResults?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        let searchBar = searchResults?.searchBar
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Find Date Location Near Me"
        navigationItem.titleView = searchResults?.searchBar
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LocationsViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let locations = locations.first {
            let span = MKCoordinateSpanMake(0.07, 0.07)
            let region = MKCoordinateRegion(center: locations.coordinate, span: span)
            locationsMapOutlet.setRegion(region, animated: true)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error: (error)")
    }
}

