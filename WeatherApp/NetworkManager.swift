import Foundation
import CoreLocation

struct NetworkManager {
    let weatherURLByCityName = "https://api.openweathermap.org/data/2.5/weather?appid=04d9b06b9d3a43d2680c28c9f90e9ed2&units=metric"
    let weatherURLById = "https://api.openweathermap.org/data/2.5/group?id="
    
    enum RequestType {
        case byName
        case byIds
    }
    
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
                print(error?.localizedDescription)
                print(String(data:data!, encoding: .utf8))
                if error != nil {
                    performRequestOnComplete(nil)
                }
                if let safeData = data {
                    switch requestType {
                    case .byName:
                        guard let weather = self.parseJSONByName(safeData) else {
                                                       performRequestOnComplete(nil)
                                                       return
                                                   }
                                                   performRequestOnComplete([weather])
                    case .byIds:
                        guard let weather = self.parseJSONById(safeData) else {
                                                   performRequestOnComplete(nil)
                                                   return
                        }
                        performRequestOnComplete(weather)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSONById(_ weatherData: Data) -> [CityWeather]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            var cityWeathers =  [CityWeather]()
            decodedData.list.forEach( { item in
                let conditionId = item.weather[0].id
                let temp = item.main.temp
                let cityId = item.id
                let name = item.name
                let weather = CityWeather(id: cityId, name: name, temputure: String(temp), conditionId: conditionId)
                cityWeathers.append(weather)
            })
            return cityWeathers
        } catch {
            return nil
        }
    }
    
    func parseJSONByName(_ weatherData: Data) -> CityWeather? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(City.self, from: weatherData)
            let conditionId = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityId = decodedData.id
            let name = decodedData.name
            let weather = CityWeather(id: cityId, name: name, temputure: String(temp), conditionId: conditionId)
            
            return weather
            
        } catch {
            //            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}



