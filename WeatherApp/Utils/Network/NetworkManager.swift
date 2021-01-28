import Foundation
import CoreLocation

struct NetworkManager {
    // MARK: — Public Properties
    let weatherURLByCityName = "https://api.openweathermap.org/data/2.5/weather?appid=04d9b06b9d3a43d2680c28c9f90e9ed2&units=metric"
    let weatherURLById = "https://api.openweathermap.org/data/2.5/group?id="
    static var sharedNetworkManager = NetworkManager()
    
    enum RequestType {
        case byName
        case byIds
    }
    
    // MARK: — Initializers
    private init()  {}
    
    // MARK: — Public Methods
    func fetchWeather(cityName: String, onComplete: @escaping ([CityWeather]?) -> Void ) {
        let urlString = "\(weatherURLByCityName)&q=\(cityName)"
        performRequest(with: urlString, performRequestOnComplete: onComplete, requestType: .byName)
    }
    
    func fetchWeatherById(cityId: String, onComplete: @escaping ([CityWeather]?) -> Void) {
        let urlString = "\(weatherURLById)\(cityId)&units=metric&appid=04d9b06b9d3a43d2680c28c9f90e9ed2"
        performRequest(with: urlString, performRequestOnComplete: onComplete, requestType: .byIds)
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



