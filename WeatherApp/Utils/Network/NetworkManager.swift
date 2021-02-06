import Foundation
import CoreLocation
import PromiseKit

struct NetworkManager {

    private struct Constants {
        static let weatherAPIKey = "04d9b06b9d3a43d2680c28c9f90e9ed2"
        static let weatherAPIObject = "https://api.openweathermap.org/data/2.5/weather?appid=\(Constants.weatherAPIKey)&units=metric&q="
        static let weatherAPIArrayPart1 = "https://api.openweathermap.org/data/2.5/group?id="
        static let weatherAPIArrayPart2 = "&units=metric&appid=\(Constants.weatherAPIKey)"
    }

    // MARK: — Public Properties
    static var sharedNetworkManager = NetworkManager()

    // MARK: — Initializers
    private init() { }

    // MARK: — Public Methods
    func performRequestObject(cityName: String) -> Promise<CityWeather?> {
        if let url = URL(string: "\(Constants.weatherAPIObject)\(cityName)") {
            return firstly {
                URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                var weather: CityWeather?
                do {
                    let decodedData = try JSONDecoder().decode(City.self, from: $0.data)
                    weather = CityWeather(decodedData: decodedData)
                } catch {
                    print(error)
                }
                return weather
            }
        } else {
            return .value(nil)
        }
    }

    func performRequestArray(cityIds: String) -> Promise<[CityWeather]?> {
        if let url = URL(string: "\(Constants.weatherAPIArrayPart1)\(cityIds)\(Constants.weatherAPIArrayPart2)") {
            return firstly {
                URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                var cityWeathers =  [CityWeather]()
                do {
                    let decodedData = try JSONDecoder().decode(WeatherData.self, from: $0.data)
                    decodedData.list.forEach({item in
                        let weather = CityWeather(decodedData: item)
                        cityWeathers.append(weather)
                    })
                } catch {
                    print(error)
                }
                return cityWeathers
            }
        } else {
            return .value(nil)
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
