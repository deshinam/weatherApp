import Foundation
import RealmSwift
import PromiseKit

class CitiesDataRepository {
    // MARK: — Private Properties
    private let networkManager: NetworkManager = NetworkManager.sharedNetworkManager
    private var dataBaseManager: DataBaseManager = DataBaseManager.sharedUserCitiesManager

    // MARK: — Public Methods
    func fetchWeatherByName(cityName: String ) -> Promise<CityWeather?> {
        return networkManager.performRequestObject(cityName: cityName, objectType: CityWeather.self, decodableObjectType: City.self)
    }

    func fetchWeatherById(cityId: String) -> Promise<[CityWeather]?> {
        return networkManager.performRequestArray(cityIds: cityId, objectType: CityWeather.self, decodableObjectType: WeatherData.self)
    }

    func loadCities () -> Results <UserCities>? {
        return dataBaseManager.loadCities()
    }

    func saveCity (newCity: UserCities) {
        dataBaseManager.saveCity(newCity: newCity)
    }

    func findCityById (cityId: Int) -> Promise<UserCities?> {
        return dataBaseManager.findCityById(cityId: cityId)
    }

    func deleteCity (city: UserCities) -> Promise<Bool> {
        return dataBaseManager.deleteCity(city: city)
    }
}
