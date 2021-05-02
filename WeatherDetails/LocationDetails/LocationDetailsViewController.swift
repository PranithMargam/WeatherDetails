//
//  LocationDetailsViewController.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 01/05/21.
//

import UIKit

class LocationDetailsViewController: UIViewController {
    var selectedLocation: Location?
    
    private let titleLabel = UILabel()
    private let tempartureLabel = UILabel()
    private let humidityLabel = UILabel()
    private let rainChanceLabel = UILabel()
    private let windInformationLabel = UILabel()
    private var segmentControl: UISegmentedControl!
    
    let items = ["day1","day2","day3","day4","day5"]
    var filteredList: [DataViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loadData()
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .systemBackground
        
        addTitleLabel()
        addSegmentControl()
        addVerticalStackView()
    }
    
    private func addTitleLabel() {
        titleLabel.numberOfLines = 0
        self.view.addSubview(titleLabel)
        titleLabel.text = "Weather forecast in \(selectedLocation?.name ?? "")"
        titleLabel.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor,padding: .init(top: 12, left: 24, bottom: 0, right: 24))
        setUp(label: titleLabel, withFont: .preferredFont(forTextStyle: .largeTitle), color: .label)
    }
    
    private func addSegmentControl() {
        segmentControl =  UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        self.view.addSubview(segmentControl)
        segmentControl.anchor(top: titleLabel.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 24, left: 24, bottom: 0, right: 24), size: .init(width: 0, height: 36))
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
    }
    
    private func addVerticalStackView() {
        let verticalStackView = createVerticalStackView()
        self.view.addSubview(verticalStackView)
        verticalStackView.anchor(top: segmentControl.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 12, left: 24, bottom: 0, right: 24))
        
        [tempartureLabel,humidityLabel,rainChanceLabel,windInformationLabel].forEach { (label) in
            setUp(label: label, withFont: .preferredFont(forTextStyle: .headline), color: .label)
            verticalStackView.addArrangedSubview(label)
        }
    }
    
    private func createVerticalStackView() -> UIStackView {
        let verticalStack = UIStackView()
        
        verticalStack.axis = .vertical
        verticalStack.alignment = .fill
        verticalStack.distribution = .fill
        verticalStack.spacing = 6
        return verticalStack
    }
    
    private func setUp(label: UILabel,withFont font: UIFont,color: UIColor) {
        label.font = font
        label.textColor = color
        label.textAlignment = .left
        label.numberOfLines = 0
    }
    
    private func loadData() {
        guard let location = selectedLocation else {
            return
        }
        WeatherAPIClient(session: URLSession.shared).fetchWeatherForecast(atLocation: location) { (result) in
            self.handleResponse(with: result)
        }
    }
    
    fileprivate func handleResponse(with result:APIResult<WeatherMap>) {
        switch result {
        case .sucesss(let weatherMap):
            self.filteredList = weatherMap.filiterDataListByDate
            setSegmentItemsTitle()
            setForecastData(withIndex: 0)
        case .failure( _): break
        }
    }
    
    private func setSegmentItemsTitle() {
        let maxListItem = min(items.count, filteredList.count)
        for i in 0...maxListItem-1 {
            let title = filteredList[i].dateString
            segmentControl.setTitle(title, forSegmentAt: i)
        }
    }
    
    private func setForecastData(withIndex index: Int) {
        guard filteredList.count > 0 else {
            return
        }
        let max = min(filteredList.count-1, index)
        let data = filteredList[max]
        tempartureLabel.text = data.tempartureValue
        humidityLabel.text = data.humidityValue
        rainChanceLabel.text = data.rainChanceValue
        windInformationLabel.text = data.windInfo
    }
}
//MARK:- Button Action Methods
extension LocationDetailsViewController {
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl) {
        setForecastData(withIndex: sender.selectedSegmentIndex)
    }
}
