//
//  Weather.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 01/05/21.
//

import Foundation

struct WeatherMap: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [Data]
    let city: City
    struct Data: Decodable {
        let dt: Int
        let dt_txt: String
        let rain: Rain?
        let wind: Wind?
        let main: Main
        let weather: [Weather]
        let sys:Sys
        struct Main: Decodable {
            let temp: Double
            let feels_like: Double
            let pressure: Int
            let sea_level: Int
            let humidity: Int
        }
        
        struct Weather : Decodable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        struct Rain: Decodable {
            let key: Double
            enum CodingKeys: String, CodingKey {
                case key = "3h"
            }
        }
        struct Sys: Decodable {
            let pod: String
        }
        
        struct Wind: Decodable {
            let speed: Double
            let deg: Double
            let gust: Double
        }
    }
    
    struct City: Decodable {
        let id: Int
        let name: String
    }
}


