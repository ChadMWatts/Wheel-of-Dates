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
    var selectedPin: MKPlacemark? = nil
    var mapView = MKMapView()
    
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
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }
    
    func getDirections() {
        
        if let selectedPin = selectedPin {
            
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMapsWithLaunchOptions(launchOptions)
            
        }
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

// Mark: - Delegate

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark)
}

// Mark: - Locations Extention

extension LocationsViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let locations = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: locations.coordinate, span: span)
            locationsMapOutlet.setRegion(region, animated: true)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error: (error)")
    }
}

// Mark: - Map search Handler for pin drop

extension LocationsViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark: MKPlacemark) {
        
        selectedPin = placemark
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "(city) (state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
       
    }
}

extension LocationsViewController: MKMapViewDelegate {
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {return nil}
        
        let reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as? MKPinAnnotationView
        
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
        pinView?.pinTintColor = UIColor.cyanColor()
        pinView?.canShowCallout = true
        
        let samllSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPointZero, size: samllSquare))
        button.setBackgroundImage(UIImage(named: "GoKarts"), forState: .Normal)
        button.addTarget(self, action: #selector(LocationsViewController.getDirections), forControlEvents: .TouchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}



