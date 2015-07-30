//
//  AlertViewController.swift
//  AlertApp
//
//  Created by Tanya Sahin on 4/17/15.
//  Copyright (c) 2015 Seidenberg Creative Labs. All rights reserved.
//

import UIKit
import CoreLocation

class AlertViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    let kAccuracyInKm = CLLocationAccuracy(0.001)//in kilometer -> have to check whether the high accuracy is necessary; higher accuracy eats up battery
    let kDistanceFilter = CLLocationDistance(1)//in meter
    
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLocationUpdates()
    }
    
    func startLocationUpdates() {

        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.requestWhenInUseAuthorization()

            locationManager.delegate = self
            locationManager.desiredAccuracy = kAccuracyInKm
            locationManager.distanceFilter = kDistanceFilter
            
            locationManager.stopUpdatingLocation()//necessary??
            locationManager.startUpdatingLocation()
            
        } else {
            latitudeLabel.text = "N/A"
            longitudeLabel.text = "N/A"
        }
    }
    
    func locationManager(manager: CLLocationManager!,
        didUpdateLocations locations: [AnyObject]!) {
            var latitude = manager.location.coordinate.latitude
            var longitude = manager.location.coordinate.longitude
    
            latitudeLabel.text = latitude.description
            longitudeLabel.text = longitude.description
            
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        latitudeLabel.text = "Error: \(error)"
        longitudeLabel.text = "Error: \(error)"
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
