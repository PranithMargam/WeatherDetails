//
//  WeatherAPIClient.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 01/05/21.
//

import Foundation

enum APIResult<T: Decodable> {
    case sucesss(T)
    case failure(APIError)
}

enum APIError: Error {
    case connectionError(Error)
    case responseFormateInvalid(String)
    case serverError(Int)
}

typealias APICompletionBlock<T: Decodable> = (APIResult<T>) -> Void

enum UnitSystem: String,CaseIterable {
    case metric
    case imperial
    var stringValue: String {
        self.rawValue
    }
    
    static func lastSavedUnit() -> UnitSystem {
        UnitSystem(rawValue: SaveLocationDataUtility.lastSavedUnitValue()) ?? .metric
    }
}
class WeatherAPIClient {
    let session: URLSession
    static var unitValue: UnitSystem = UnitSystem.lastSavedUnit()

    init(session: URLSession) {
        self.session = session
    }
    
    func fetchWeatherForecast(atLocation location: Location, completion: @escaping APICompletionBlock<WeatherMap>) {
        let apiKey: String = "fae7190d7e6433ec3a45285ffcf55c86"
        let apiURLString =  "http://api.openweathermap.org/data/2.5/forecast?lat=\(location.latitude )&lon=\(location.longitude)&appid=\(apiKey)&units=\(WeatherAPIClient.unitValue.stringValue)"
        
        let url = URL(string: apiURLString)!
        let req = URLRequest(url: url)
        
        let task = session.dataTask(with: req) { (data, response, error) in
            if let e = error {
                self.resultOnMainThread(result: APIResult.failure(.connectionError(e)), completion: completion)
            } else if let http = response as? HTTPURLResponse {
                switch http.statusCode {
                case 200:
                    //sucess
                    let jsonDecoder = JSONDecoder()
                    do {
                        let apod = try jsonDecoder.decode(WeatherMap.self, from: data!)
                        self.resultOnMainThread(result: APIResult.sucesss(apod), completion: completion)
                    } catch let err {
                        print(err)
                        let bodyString = String(data: data!, encoding: .utf8)
                        self.resultOnMainThread(result: APIResult.failure(.responseFormateInvalid(bodyString ?? "nobody found")), completion: completion)
                    }
                default:
                    self.resultOnMainThread(result: APIResult.failure(.serverError(http.statusCode)), completion: completion)
                }
            }
        }
        task.resume()
    }
    
    func resultOnMainThread<T>(result: APIResult<T>, completion: @escaping APICompletionBlock<T>) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
