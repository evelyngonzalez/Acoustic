//
//  MapViewController.swift
//  AppAcoustic
//
//  Created by Evelyn on 13/6/18.
//  Copyright © 2018 Evelyn. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //Outlets
    @IBOutlet weak var mapKit: MKMapView!
    
    var event : Event!

    
    //Load point annotation with event location
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapKit.delegate = self
        self.mapKit.isZoomEnabled = true
       // var eve = event.coords?.lat
        let annotationOne = MKPointAnnotation()
        annotationOne.coordinate = CLLocationCoordinate2D(latitude: (event.coords?.lat)!, longitude: (event.coords?.lon)!)
        self.mapKit.addAnnotation(annotationOne)

    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{
            return nil
        }
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return pin
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
