//
//  HomeViewController+MapView.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 01/05/21.
//

import Foundation
import MapKit

struct Location: Codable,Equatable {
    let name: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}

extension HomeViewController {
    func determineCurrentLocation() {
        self.locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled(),isLocationAuthorised() {
            locationManager?.startUpdatingLocation()
        }
    }
    
    private func isLocationAuthorised() -> Bool {
        return CLLocationManager().authorizationStatus == .authorizedAlways || CLLocationManager().authorizationStatus == .authorizedWhenInUse
    }
    
    func addAnnotation(forLocation location: Location) {
        // Add annotation:
        let annotation = MKPointAnnotation()
        //let annotation1 = CityAnnotation(title: location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        annotation.coordinate = coordinate
        annotation.title = location.name
        
        self.mapView.addAnnotation(annotation)
    }
    
    func removeAnnotation(forLocation location: Location) {
        let annotations = self.mapView.annotations.filter({$0.title == location.name})
        self.mapView.removeAnnotations(annotations)
    }
}

extension HomeViewController: MKMapViewDelegate,CLLocationManagerDelegate {
    
    //MARK:- CLLocationManagerDelegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 20.0))
        
        self.mapView.setRegion(mRegion, animated: true)
        
    }
    
    //MARK:- Intance Methods
    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)
        var currentLocationStr = ""
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in

            if let mPlacemark = placemarks {
                if let name = mPlacemark[0].name,let city = mPlacemark[0].locality {
                    currentLocationStr = name + ", " + city
                }
            }
        }
        return currentLocationStr
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
          let identifier = "Annotation"
          var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

          if annotationView == nil {
              annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
              annotationView!.canShowCallout = true
          } else {
              annotationView!.annotation = annotation
          }
        let btn = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = btn
        return annotationView
    }
    
    @objc  func mapViewTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        let locationOnView = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(locationOnView, toCoordinateFrom: mapView)
            
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            if let mPlacemark = placemarks {
                if let cityName = mPlacemark[0].locality {
                    self.updateViewOnCitySelection(withCity: cityName, coordinate: coordinate)
                }
            }
        }
    }
}
