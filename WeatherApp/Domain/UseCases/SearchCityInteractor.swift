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
            if data == nil {
                
            } else {
                self.currentCity = data?[0]
            }
            
        }
    }
    
    func getCurrentCityName () -> String? {
        return currentCity?.name
    }
    
    func addCity() -> Bool {
        guard currentCity != nil else {
            return false
        }
        let newCity = UserCities(cityId: currentCity!.id, cityName: currentCity!.name)
        citiesDataRepository.saveCity(newCity: newCity)
        return true
    }
}
