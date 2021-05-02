//
//  SettingsViewController.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 02/05/21.
//

import UIKit

class SettingsViewController: UIViewController {
    var resetBookmarksBlock:(() -> Void) = {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .systemBackground
        let resetButton = UIButton()
        self.addResetButton(resetButton: resetButton)
        let horizontolStackView = createHorizontalStackView()
        
        let items = UnitSystem.allCases.map({$0.rawValue})
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = WeatherAPIClient.unitValue == .metric ? 0 : 1
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)

        
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.label
        label.text = "Units System"
        label.textAlignment = .left
        
        self.view.addSubview(horizontolStackView)
        horizontolStackView.anchor(top: resetButton.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor,padding: .init(top: 24, left: 24, bottom: 0, right: 24))
        horizontolStackView.addArrangedSubview(label)
        horizontolStackView.addArrangedSubview(segmentControl)
    }
    
    private func addResetButton(resetButton: UIButton) {
        resetButton.setTitle("Reset Bookmarks", for: .normal)
        resetButton.backgroundColor = .systemBlue
        resetButton.addTarget(self, action: #selector(resetButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(resetButton)
        resetButton.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor,padding: .init(top: 12, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 48))
    }
    
    private func createHorizontalStackView() -> UIStackView {
        let verticalStack = UIStackView()
        
        verticalStack.axis = .horizontal
        verticalStack.alignment = .fill
        verticalStack.distribution = .fill
        verticalStack.spacing = 6
        return verticalStack
    }
}
//MARK:- Button Action Methods
extension SettingsViewController {
    
    @objc private func resetButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Are you sure want to remove all bookmarks", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            self.resetAlertAction()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            WeatherAPIClient.unitValue = .metric
        case 1:
            WeatherAPIClient.unitValue = .imperial
        default:
            break
        }
        SaveLocationDataUtility.saveUnitValue(unit: WeatherAPIClient.unitValue)
    }
    
    private func resetAlertAction() {
        SaveLocationDataUtility.removeAllBookmarks()
        self.resetBookmarksBlock()
        self.dismiss(animated: true, completion: nil)
    }
}
