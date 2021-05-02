//
//  WeatherMapViewModel.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 01/05/21.
//

import Foundation

protocol WeatherMapModel {
    var filiterDataListByDate:[DataViewModel] { get }
}

extension WeatherMap: WeatherMapModel {
    var filiterDataListByDate: [DataViewModel] {
        var filteredList: [DataViewModel] = []
        for data in self.list where filteredList.filter({$0.dateString == data.dateString}).count == 0  {
            filteredList.append(data)
        }
        return filteredList
    }
}

protocol DataViewModel {
    var dateString: String { get }
    var tempartureValue: String { get }
    var humidityValue: String { get }
    var rainChanceValue: String { get}
    var windInfo: String { get }
}

extension WeatherMap.Data: DataViewModel {
    var dateString: String {
        let dtText = self.dt_txt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from:dtText) else {
            return ""
        }
        
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "MMM-dd"
        return stringFormatter.string(from: date)
    }
    
    var tempartureValue: String {
        "temparture: \(self.weather.first?.main ?? "")\ntemp: \(self.main.temp)"
    }
    
    var humidityValue: String {
        "humidity: \(self.main.humidity)"
    }
    
    var rainChanceValue: String {
        "Rain: \(self.rain?.key ?? 0)"
    }
    
    var windInfo: String {
        "Wind speed: \(self.wind?.speed ?? 0)\nWind deg: \(self.wind?.deg ?? 0)\nWind gust: \(self.wind?.gust ?? 0)"
    }
}
