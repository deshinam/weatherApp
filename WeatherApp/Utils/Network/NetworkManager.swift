import Foundation
import CoreLocation
import PromiseKit

struct NetworkManager {
    // MARK: — Public Properties
    static var sharedNetworkManager = NetworkManager()
    
    // MARK: — Initializers
    private init()  {}
    
    // MARK: — Public Methods
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
