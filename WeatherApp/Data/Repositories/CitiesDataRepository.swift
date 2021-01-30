import Foundation
import RealmSwift

class CitiesDataRepository {
    // MARK: — Private Properties
    private let networkManager: NetworkManager = NetworkManager.sharedNetworkManager
    private var dataBaseManager: DataBaseManager = DataBaseManager.sharedUserCitiesManager
    
    // MARK: — Public Methods
    func fetchWeather(cityName: String, onComplete: @escaping ([CityWeather]?) -> Void ) {
        let request = CityByNameRequest(cityName: cityName)
        networkManager.performRequest(with: request, performRequestOnComplete: onComplete)
    }
    
    func fetchWeatherById(cityId: String, onComplete: @escaping ([CityWeather]?) -> Void) {
        let request = CityByIdRequest(cityIds: cityId)
        networkManager.performRequest(with: request, performRequestOnComplete: onComplete)
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
