//
//  MapDisplayViewController.swift
//  PlaceMap
//
//  Created by demo on 2014/12/06.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
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
            navItem.leftBarButtonItem = svc?.displayModeButtonItem()
            navItem.leftItemsSupplementBackButton = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("Selected = \(selectedIndex)")
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let places = appDelegate.placeDB.places
        let prefName = places[selectedIndex]["pref"] as String
        let capName = places[selectedIndex]["name"] as String

        println("Capital City = \(capName)")
        
        placeName.text = "\(prefName) [\(capName)]"

//        let coordinate = CLLocationCoordinate2D(
//            latitude: places[selectedIndex]["latitude"] as CLLocationDegrees,
//            longitude: places[selectedIndex]["longitude"] as CLLocationDegrees
//        )
//        mapView.centerCoordinate = coordinate
        let coordinate = CLLocationCoordinate2D(
            latitude: places[selectedIndex]["latitude"] as CLLocationDegrees,
            longitude: places[selectedIndex]["longitude"] as CLLocationDegrees
        )
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.region = region
        
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
