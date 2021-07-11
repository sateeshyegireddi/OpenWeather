//
//  AddLocationViewController.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import UIKit
import MapKit
import CoreLocation

class AddLocationViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var bookmarksMapView: MKMapView!
    @IBOutlet private weak var addMarkerButton: UIButton!
    
    //MARK: - Variables
    private var viewModel = AddLocationViewModel()
    let locationManager = CLLocationManager()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.title = "Add Location"
        addMarkerButton.roundCorners(5.0)
        
        //Data binding
        bindDataToUI()
        
        //Request location authentication
        requestLocationServices()
        
        //Set region on mapview, the default region is Hyderabad.
        setInitialRegionForMapView()
    }
    
    private func bindDataToUI() {
        viewModel.bookmarkLocation.bind { [weak self] location in
            guard let self = self else { return }
            if location != nil {
                DispatchQueue.main.async {
                    self.addMarkerButton.isSelected = true
                }
            }
        }
    }
    
    //MARK: - Add Annotation
    @IBAction func addAnnotationButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            viewModel.saveBookmarkedLocation()
            navigationController?.popViewController(animated: true)
        } else {
            if let location = viewModel.locations.value.first {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude,
                                                               longitude: location.longitude)
                bookmarksMapView.addAnnotation(annotation)
                viewModel.updateBookmarkLocation(annotation.coordinate)
            }
        }
    }

    //MARK: - Helper
    private func requestLocationServices() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    private func setInitialRegionForMapView() {
        let coordinate = CLLocationCoordinate2DMake(17.385, 78.4867)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.003, longitudeDelta: 0.003)
        let region = MKCoordinateRegion.init(center: coordinate, span: span)
        bookmarksMapView.setRegion(region, animated:true)
    }
    
    //MARK: - Deinit
    deinit {
        print("\(String(describing: self)) is deallocated")
    }
}

//MARK: - CLLocationManagerDelegate
extension AddLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted, .notDetermined:
            print("Location services are disabled.")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        viewModel.updateLocations(locations)
        locationManager.stopUpdatingLocation()
    }
}

//MARK: - MKMapViewDelegate
extension AddLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        let reuseId = "ANNOTATION VIEW"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        guard pinView != nil else {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.animatesDrop = true
            pinView?.isDraggable = true
            return pinView
        }
        pinView?.annotation = annotation
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if newState == .ending {
            let location = view.annotation?.coordinate
            viewModel.updateBookmarkLocation(location)
        }
    }
}
