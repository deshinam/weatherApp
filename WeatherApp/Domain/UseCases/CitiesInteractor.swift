import Foundation
import PromiseKit

final class CitiesIntercator {

    // MARK: — Private Properties
    private var citiesDataRepository = CitiesDataRepository()
    private var citiesWeather: [CityWeather]?
}

extension CitiesIntercator: CitiesInteractorProtocol {

    private func loadUserCities() -> Promise<[CityWeather]?> {
        let citiesIdsFromRealm = citiesDataRepository.loadCities()
        let stringWithCities = citiesIdsFromRealm?.map {String($0.cityId)}.joined(separator: ",") ?? ""

        if stringWithCities == "" {
            return .value(nil)
        } else {
            return self.citiesDataRepository.fetchWeatherById(cityId: stringWithCities)
        }
    }

    func cityWeatherCount() -> Int? {
        return self.citiesWeather?.count
    }

    func setUserCities () -> Promise<Void> {
        loadUserCities().done { data in
            self.citiesWeather = data
        }
    }

    func deleteCity(index: Int) -> Promise<Void> {
        let cityId = citiesWeather![index].cityWeatherId
        if let deletedCity = citiesDataRepository.findCityById(cityId: cityId ) {
            if  citiesDataRepository.deleteCity(city: deletedCity) {
                 return setUserCities()
            }
        }
        return Promise<Void>()
    }

func getDeletedCityById(index: Int) -> UserCities? {
    var deletedCity: UserCities?
    if let cityId = citiesWeather?[index].cityWeatherId {
        deletedCity = citiesDataRepository.findCityById(cityId: cityId)
    }
    return deletedCity
}

    func getCityWeather(id: Int) -> CityWeather? {
        return citiesWeather?[id]
    }
}
