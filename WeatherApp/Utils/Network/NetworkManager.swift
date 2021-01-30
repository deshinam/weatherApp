import Foundation
import CoreLocation

public enum RequestType: String {
    case byName
    case byIds
    
    public var rawValue: String {
         switch self {
         case .byName: return "https://api.openweathermap.org/data/2.5/weather?appid=04d9b06b9d3a43d2680c28c9f90e9ed2&units=metric"
         case .byIds: return "https://api.openweathermap.org/data/2.5/group?id="
         }
     }
}


public struct Request {
    let requestType: RequestType
    var url: String {
        switch requestType {
        case .byName:
            return "\(requestType.rawValue)&q=\(city)"
        case .byIds:
            return "\(requestType.rawValue)\(city)&units=metric&appid=04d9b06b9d3a43d2680c28c9f90e9ed2"
        }
    }
    let city: String
//    
//    func performRequest() {
//        
//    }
}

struct NetworkManager {
    // MARK: — Public Properties
    let weatherURLByCityName = "https://api.openweathermap.org/data/2.5/weather?appid=04d9b06b9d3a43d2680c28c9f90e9ed2&units=metric"
    let weatherURLById = "https://api.openweathermap.org/data/2.5/group?id="
    static var sharedNetworkManager = NetworkManager()
    
    // MARK: — Initializers
    private init()  {}
    
    // MARK: — Public Methods
    
    func fetchWeather(cityName: String, onComplete: @escaping ([CityWeather]?) -> Void ) {
        let request = Request(requestType: .byName, city: cityName)
        performRequest(with: request.url, performRequestOnComplete: onComplete, requestType: .byName)
    }

    func fetchWeatherById(cityId: String, onComplete: @escaping ([CityWeather]?) -> Void) {
        let request = Request(requestType: .byIds, city: cityId)
        performRequest(with: request.url, performRequestOnComplete: onComplete, requestType: .byIds)
    }
    
    func performRequest (with urlString: String, performRequestOnComplete: @escaping ([CityWeather]?) -> Void, requestType: RequestType) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {  (data, response, error) in
                if error != nil {
                    performRequestOnComplete(nil)
                }
                if let safeData = data {
                    switch requestType {
                    case .byName:
                        guard let decodedData: City = self.parseJSON(safeData) else {
                            performRequestOnComplete(nil)
                            return
                        }
                        let weather = CityWeather(decodedData: decodedData)
                        performRequestOnComplete([weather])
                    case .byIds:
                        guard let decodedData:WeatherData = self.parseJSON(safeData) else {
                            performRequestOnComplete(nil)
                            return
                        }
                        var cityWeathers =  [CityWeather]()
                        decodedData.list.forEach( { item in
                            let weather = CityWeather(decodedData: item)
                            cityWeathers.append(weather)
                        })
                        performRequestOnComplete(cityWeathers)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON<T: Decodable>(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
}



