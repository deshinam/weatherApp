import Foundation
import PromiseKit

final class SearchCityInteractor {

    // MARK: — Private Properties
    private var citiesDataRepository: CitiesDataRepository = CitiesDataRepository()
    private var preferenseStorage = PreferenseStorage()
}

extension SearchCityInteractor: SearchCityInteractorProtocol {
    func saveCity(newCity: UserCities) {
        citiesDataRepository.saveCity(newCity: newCity)
    }

    func searchCity(cityName: String) -> Promise<Void> {
        citiesDataRepository.fetchWeatherByName(cityName: cityName).done { data in
            if data != nil {
                self.preferenseStorage.setCurrentCity(currentCity: data!)
            }
        }
    }

    func getCurrentCityName () -> String? {
        return preferenseStorage.getCurrentCity()?.name
    }

    func addCity() -> Bool {
        guard let currentCity = preferenseStorage.getCurrentCity()
        else {
            return false
        }
        let newCity = UserCities(cityId: currentCity.cityWeatherId, cityName: currentCity.name)
        citiesDataRepository.saveCity(newCity: newCity)
        return true
    }
}
