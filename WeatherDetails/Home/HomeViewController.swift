//
//  ViewController.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 30/04/21.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {

    var bookmarkedLocations:[Location] = []
    var locationManager:CLLocationManager?

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()

    let mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineCurrentLocation()
        setData()
    }

    private func setUpUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Whether"
        addRightBarButtons()
        addMapView()
        addInfoLabel()
        addTableView()
    }

    private func addRightBarButtons() {
        let rightButton =  UIBarButtonItem(title: "Help", style: .plain, target: self, action: #selector(helpButtonTapped(_:)))
        let reset = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped(_:)))
        self.navigationItem.rightBarButtonItems = [reset,rightButton]
    }
    
    private func addMapView() {
        self.view.addSubview(mapView)
        mapView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor,padding: .zero ,size: CGSize(width: 0, height: 400))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewTapGesture(_:)))
        mapView.addGestureRecognizer(tapGesture)
        mapView.delegate = self
    }
    
    private func addInfoLabel() {
        infoLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        infoLabel.textColor = UIColor.secondaryLabel
        infoLabel.textAlignment = .left
        infoLabel.numberOfLines = 0
        self.view.addSubview(infoLabel)
        infoLabel.anchor(top: self.mapView.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor,padding: .init(top: 6, left: 12, bottom: 0, right: 12),size: .init(width: 0, height: 48))
    }
    
    private func addTableView() {
        self.view.addSubview(tableView)
        tableView.anchor(top: infoLabel.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor,padding: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.cellId)
    }
    
    func updateViewOnCitySelection(withCity cityName: String,coordinate: CLLocationCoordinate2D) {
        if self.bookmarkedLocations.filter({$0.name == cityName}).count == 0 {
            let location = Location(name: cityName, latitude: coordinate.latitude, longitude: coordinate.longitude)
            self.bookmarkedLocations.append(location)
            SaveLocationDataUtility.saveBookmarkedlocations(self.bookmarkedLocations)
            self.addAnnotation(forLocation: location)
            reloadData()
        }
    }
    
    func setData() {
        self.bookmarkedLocations.forEach({ self.removeAnnotation(forLocation: $0)})
        self.bookmarkedLocations = SaveLocationDataUtility.getBookmarkedLocations()
        self.bookmarkedLocations.forEach({ self.addAnnotation(forLocation: $0)})
        reloadData()
    }
    
    private func reloadData() {
        updateInfoLabelText()
        self.tableView.reloadData()
    }
    
    func updateInfoLabelText() {
        if self.bookmarkedLocations.count == 0 {
            self.infoLabel.text = "Please,Tap on City names on Map to add in bookmarks list"
        } else {
            self.infoLabel.text = "Note: To delete city from list,Please swipe left on City tile"
        }
    }
}
//MARK:- Button Action Methods
extension HomeViewController {
    @objc private func helpButtonTapped(_ sender: UIBarButtonItem) {
        self.navigateToHelpViewController()
    }
    
    @objc private func settingsButtonTapped(_ sender: UIBarButtonItem) {
        self.navigateToSettingsViewController()
    }
}


