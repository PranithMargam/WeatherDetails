//
//  HomeViewController+TableView.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 01/05/21.
//

import UIKit

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkedLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.cellId, for: indexPath) as? LocationCell else {
            return UITableViewCell()
        }
        cell.setUpData(location: self.bookmarkedLocations[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("called")
        if editingStyle == .delete {
            self.removeAnnotation(forLocation: self.bookmarkedLocations[indexPath.row])
            bookmarkedLocations.remove(at: indexPath.row)
            SaveLocationDataUtility.saveBookmarkedlocations(self.bookmarkedLocations)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToLocationViewController(withLocation: self.bookmarkedLocations[indexPath.row])
    }
}
