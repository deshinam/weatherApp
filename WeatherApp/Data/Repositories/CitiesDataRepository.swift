import Foundation
import RealmSwift
import PromiseKit

class CitiesDataRepository {
    // MARK: — Private Properties
    private let networkManager: NetworkManager = NetworkManager.sharedNetworkManager
    private var dataBaseManager: DataBaseManager = DataBaseManager.sharedUserCitiesManager

    // MARK: — Public Methods
    func fetchWeatherByName(cityName: String ) -> Promise<CityWeather?> {
        return networkManager.performRequestObject(cityName: cityName)
    }

    func fetchWeatherById(cityId: String) -> Promise<[CityWeather]?> {
        return networkManager.performRequestArray(cityIds: cityId)
    }

    func loadCities () -> Results <UserCities>? {
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
