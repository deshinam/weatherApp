import Foundation
import CoreLocation
import PromiseKit

struct NetworkManager {
    // MARK: — Public Properties
    static var sharedNetworkManager = NetworkManager()
    
    // MARK: — Initializers
    private init()  {}
    
    // MARK: — Public Methods
    func performRequest<R: RequestProtocol> (with request: R, performRequestOnComplete: @escaping ([CityWeather]?) -> Void) {
        if let url = URL(string: request.url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {  (data, response, error) in
                if error != nil {
                    performRequestOnComplete(nil)
                }
                if let safeData = data {
                    guard let decodedData: R.T = self.parseJSON(safeData) else {
                        performRequestOnComplete(nil)
                        return
                    }
                    let cityWeathers = request.transformDataToCityWeatherArray(decodedData: decodedData)
                    performRequestOnComplete(cityWeathers)
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



