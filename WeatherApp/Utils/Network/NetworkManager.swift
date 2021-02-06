import Foundation
import CoreLocation
import PromiseKit

struct NetworkManager {
    // MARK: — Public Properties
    static var sharedNetworkManager = NetworkManager()

    // MARK: — Initializers
    private init() { }

    // MARK: — Public Methods
//    func performRequestObject() -> Promise<CityWeather?>  {
//
//    }

    func performRequestArray(cityIds: String) -> Promise<[CityWeather]?> {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/group?id=\(cityIds)&units=metric&appid=04d9b06b9d3a43d2680c28c9f90e9ed2") {
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

    func performRequest<R: RequestProtocol> (with request: R) -> Promise<[CityWeather]?> {
        if let url = URL(string: request.url) {
            return firstly {
                URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                var cityWeathers: [CityWeather]?
                do {
                    let decodedData = try JSONDecoder().decode(R.T.self, from: $0.data)
                    cityWeathers = request.transformDataToCityWeatherArray(decodedData: decodedData)
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
