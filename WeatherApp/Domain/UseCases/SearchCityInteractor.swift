import Foundation
import PromiseKit

final class SearchCityInteractor {

    // MARK: — Private Properties
    private var citiesDataRepository: CitiesDataRepository = CitiesDataRepository()
    private var currentCity: CityWeather?
}

extension SearchCityInteractor: SearchCityInteractorProtocol {
    func saveCity(newCity: UserCities) {
        citiesDataRepository.saveCity(newCity: newCity)
    }

    func searchCity(cityName: String) -> Promise<Void> {
        citiesDataRepository.fetchWeatherByName(cityName: cityName).done { data in
            self.currentCity = data
        }
    }

    func getCurrentCityName () -> String? {
        return currentCity?.name
    }

    func addCity() -> Bool {
        guard currentCity != nil else {
            return false
        }
        let newCity = UserCities(cityId: currentCity!.cityWeatherId, cityName: currentCity!.name)
        citiesDataRepository.saveCity(newCity: newCity)
        return true
    }
}
