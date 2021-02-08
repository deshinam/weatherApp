import Foundation
import PromiseKit
import RealmSwift

final class CitiesInteractor {

    // MARK: — Private Properties
    private var citiesDataRepository = CitiesDataRepository()
    private var citiesWeather: [CityWeather]?
}

extension CitiesInteractor: CitiesInteractorProtocol {
    private func loadUserCities() -> Promise<[CityWeather]?> {
        return firstly {() -> Promise<Results<UserCities>?> in
            let citiesIdsFromRealm = citiesDataRepository.loadCities()
            return .value(citiesIdsFromRealm)
        }.compactMap { (citiesIdsFromRealm) -> Promise<String> in
            let stringWithCities = citiesIdsFromRealm?.map {String($0.cityId)}.joined(separator: ",") ?? ""
            return .value(stringWithCities)
        }.then {(stringWithCities) -> Promise<[CityWeather]?>  in
            if stringWithCities.value == "" {
                return .value(nil)
            } else {
                return self.citiesDataRepository.fetchWeatherById(cityId: stringWithCities.value ?? "")
            }
        }
    }

    func cityWeatherCount() -> Int? {
        return self.citiesWeather?.count
    }

    func setUserCities () -> Promise<Void> {
        loadUserCities().map { data in
            self.citiesWeather = data
        }
    }

    func deleteCity(index: Int) -> Promise<Void> {
        return firstly { () -> Promise<UserCities?> in
            if let cityId = citiesWeather?[index].cityWeatherId {
                return citiesDataRepository.findCityById(cityId: cityId)
            } else {
                return .value(nil)
            }
        }.compactMap { (deletedCity) -> Promise<Bool> in
            var result: Promise<Bool> = .value(true)
            guard deletedCity != nil else {
                result =  .value(false)
                return  result
            }
            let deletedResult = self.citiesDataRepository.deleteCity(city: deletedCity!)
            return deletedResult
        }.then {(result) -> Promise<Void> in
            if result.value ?? false {
                return self.setUserCities()
            }
            return Promise<Void>()
        }
    }

    func getDeletedCityById(index: Int) -> Promise<UserCities?> {
        if let cityId = citiesWeather?[index].cityWeatherId {
            return firstly {() -> Promise<UserCities?> in
                return citiesDataRepository.findCityById(cityId: cityId)
            }
        } else {
            return .value(nil)
        }
    }

    func getCityWeather(id: Int) -> CityWeather? {
        return citiesWeather?[id]
    }
}
