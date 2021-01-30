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
        let url = URL(string: request.url)!
        return firstly {
             URLSession.shared.dataTask(.promise, with: url)
        }.compactMap {
            let decodedData = try JSONDecoder().decode(R.T.self, from: $0.data)
            let cityWeathers = request.transformDataToCityWeatherArray(decodedData: decodedData)
            return cityWeathers
        }.map {cityWeathers in
            return cityWeathers
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
