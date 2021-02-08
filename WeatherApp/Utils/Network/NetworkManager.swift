import Foundation
import CoreLocation
import PromiseKit

protocol RequestObject: Codable {
    init(decodedData: Any)
}

protocol DecodableList: Decodable {
    associatedtype T: Decodable
    var list: [T] {get set}
}

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
    func performRequestObject<T: RequestObject, K: Decodable>(cityName: String, objectType: T.Type, decodableObjectType: K.Type) -> Promise<T?> {
        if let url = URL(string: "\(Constants.weatherAPIObject)\(cityName)") {
            return firstly {
                URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                var weather: T?
                do {
                    let decodedData = try JSONDecoder().decode(K.self, from: $0.data)
                    weather = T(decodedData: decodedData)
                } catch {
                    print(error)
                }
                return weather
            }
        } else {
            return .value(nil)
        }
    }

    func performRequestArray<T: RequestObject, K: DecodableList >(cityIds: String, objectType: T.Type, decodableObjectType: K.Type) -> Promise<[T]?> {
        if let url = URL(string: "\(Constants.weatherAPIArrayPart1)\(cityIds)\(Constants.weatherAPIArrayPart2)") {
            return firstly {
                URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                var cityWeathers =  [T]()
                do {
                    let decodedData = try JSONDecoder().decode(K.self, from: $0.data)
                    for i in 0..<decodedData.list.count {
                        let weather = T(decodedData: decodedData.list[i])
                        cityWeathers.append(weather)
                    }
                } catch {
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
