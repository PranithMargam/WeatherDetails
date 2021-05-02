//
//  HomeViewController+Navigation.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 02/05/21.
//

import UIKit

extension HomeViewController {
    func navigateToLocationViewController(withLocation location: Location) {
        let detailsViewController = LocationDetailsViewController()
        detailsViewController.selectedLocation = location
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func navigateToHelpViewController() {
        let helpViewController = HelpViewController()
       //helpViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(helpViewController, animated: true, completion: nil)
    }
    
    func navigateToSettingsViewController() {
        let helpViewController = SettingsViewController()
       //helpViewController.modalPresentationStyle = .fullScreen
        helpViewController.resetBookmarksBlock = {
            self.setData()
        }
        
        self.navigationController?.present(helpViewController, animated: true, completion: nil)
    }
}
