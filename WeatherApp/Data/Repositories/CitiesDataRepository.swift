import Foundation
import RealmSwift

class CitiesDataRepository {
    // MARK: — Private Properties
    private let networkManager: NetworkManager = NetworkManager.sharedNetworkManager
    private var dataBaseManager: DataBaseManager = DataBaseManager.sharedUserCitiesManager
    
    // MARK: — Public Methods
    func fetchWeather(cityName: String, onComplete: @escaping ([CityWeather]?) -> Void ) {
        networkManager.fetchWeather(cityName: cityName, onComplete: onComplete)
    }
    
    func fetchWeatherById(cityId: String, onComplete: @escaping ([CityWeather]?) -> Void) {
        networkManager.fetchWeatherById(cityId: cityId, onComplete: onComplete)
    }
    
    func loadCities () -> Results <UserCities>?  {
        return dataBaseManager.loadCities()
    }

    func saveCity (newCity: UserCities) {
        dataBaseManager.saveCity(newCity: newCity)
    }
    
    func findCityById (cityId: Int) -> UserCities? {
        return dataBaseManager.findCityById(cityId: cityId)
    }
    
    func deleteCity (city: UserCities) -> Bool {
        return dataBaseManager.deleteCity(city: city)
    }
    
}
