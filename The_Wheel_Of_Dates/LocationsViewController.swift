//
//  LocationsViewController.swift
//  The_Wheel_Of_Dates
//
//  Created by Chad Watts on 8/30/16.
//  Copyright © 2016 Chad Watts. All rights reserved.
//

import UIKit
import MapKit

//class LocationCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
//
//    let matchedItems: [MKMapItem] = []
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return matchedItems.count
//    }
//
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell")!
//
//        let selectedItem = matchedItems[indexPath.row].placemark
//        cell.textLabel?.text = selectedItem.name
//        cell.detailTextLabel?.text = LocationTableSearch.sharedController.sortAddress(selectedItem)
//
//        return cell
//    }
//}




class LocationsTableViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locoTableView: UITableView!
    
    
    var searchResults: UISearchController!
    let locationManager = CLLocationManager()
    var selectedPin: MKPlacemark?
//    var searchController = UISearchController()
    
    var dates: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dates = dates {
            print(dates)
        }
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        
        let locationSearchTable = storyboard!.instantiateViewControllerWithIdentifier("LocationSearchTable") as! LocationTableSearch
        
        searchResults = UISearchController(searchResultsController: locationSearchTable)
        searchResults.searchResultsUpdater = locationSearchTable
        searchResults.hidesNavigationBarDuringPresentation = false
        searchResults.dimsBackgroundDuringPresentation = true
        
        definesPresentationContext = true
        navigationItem.titleView = searchResults?.searchBar
        
        
        let searchBar = searchResults!.searchBar
        searchBar.sizeToFit()
        searchBar.text = dates
        searchBar.autocorrectionType.rawValue
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.blackColor()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let seconds = Int64(1.0 * Double(NSEC_PER_SEC))
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds), dispatch_get_main_queue()) {
            self.searchResults.searchBar.becomeFirstResponder()
        }
    }
    
    func getDirections() {
        
        guard let selectedPin = selectedPin else {return}
        
        let mapItem = MKMapItem(placemark: selectedPin)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMapsWithLaunchOptions(launchOptions)
        
    }
 
    
    @IBAction func button(sender: AnyObject) {
        
        getDirections()
    }
    
    // MARK: - TableView Required Funcs
    
//  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return LocationTableSearch.sharedLocationController.matchingItems.count
//    }
//    
//  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCellWithIdentifier("locationCell") else {return UITableViewCell()}
//        
//        let selectItem = LocationTableSearch.sharedLocationController.matchingItems[indexPath.row].placemark
//        cell.textLabel?.text = selectItem.name
//        cell.detailTextLabel?.text = LocationTableSearch.sharedController.sortAddress(selectItem)
//        
//        return cell
//    }
    
}

// Mark: - Delegate

protocol HandleMapSearch: class {
    func dropPinZoomIn(placemark: MKPlacemark)
}

// Mark: - Locations Extention

extension LocationsTableViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {return}
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error: \(error)")
    }
}

// Mark: - Map search Handler for pin drop

extension LocationsTableViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark: MKPlacemark) {
        
        selectedPin = placemark
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality, 
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
        
    }
}

// MARK: - MapView Delegate

extension LocationsTableViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else {return nil}
        
        let reuseID = "pin"
        guard let pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as? MKPinAnnotationView else {return nil}
        
        pinView.pinTintColor = UIColor.blackColor()
        pinView.canShowCallout = true
        
        let samllSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPointZero, size: samllSquare))
        
        button.setBackgroundImage(UIImage(named: "car"), forState: .Normal)
        button.addTarget(self, action: #selector(LocationsTableViewController.getDirections), forControlEvents: .TouchUpInside)
        pinView.rightCalloutAccessoryView = button
        
        return pinView
    }
}



