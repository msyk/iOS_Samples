//
//  MapDisplayViewController.swift
//  PlaceMap
//
//  Created by Masayuki Nii on 2015/10/04.
//  Copyright © 2015年 Masayuki Nii. All rights reserved.
//

import UIKit
import MapKit

class MapDisplayViewController: UIViewController {
    
    var selectedIndex : Int = 0
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var placeName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UIDevice.currentDevice().userInterfaceIdiom == .Pad) {
            let svc = self.splitViewController
            let navItem = self.navigationItem
            let button = svc?.displayModeButtonItem()
            //button?.title = "33"
            print(button?.title, terminator: "")
            navItem.leftBarButtonItem = button
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("Selected = \(self.selectedIndex)", terminator: "")
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let places = appDelegate.placeDB.places
        
        if let prefName = places[selectedIndex]["pref"],
            capName = places[selectedIndex]["name"],
            lat = places[self.selectedIndex]["latitude"],
            lon = places[self.selectedIndex]["longitude"] {
                self.placeName.text = "\(prefName) [\(capName)]"
                if let wLat = CLLocationDegrees(lat), wLon = CLLocationDegrees(lon) {
                    let coordinate = CLLocationCoordinate2D(latitude: wLat,longitude: wLon)
                    self.mapView.centerCoordinate = coordinate
                    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    let region = MKCoordinateRegion(center: coordinate, span: span)
                    self.mapView.region = region
                }
        }
        
        
        //        let prefName = places[selectedIndex]["pref"] as! String
        //        let capName = places[selectedIndex]["name"] as! String
        //
        //        print("Capital City = \(capName)")
        //
        //        self.placeName.text = "\(prefName) [\(capName)]"
        //
        //        let coordinate = CLLocationCoordinate2D(
        //            latitude: places[self.selectedIndex]["latitude"] as! CLLocationDegrees,
        //            longitude: places[self.selectedIndex]["longitude"] as! CLLocationDegrees
        //        )
        //self.mapView.centerCoordinate = coordinate
//        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//        self.mapView.region = region
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
