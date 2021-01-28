import Foundation

final class SearchCityInteractor {
    
    // MARK: — Private Properties
    private var citiesDataRepository: CitiesDataRepository = CitiesDataRepository()
    private var currentCity: CityWeather?
}

extension SearchCityInteractor: SearchCityInteractorProtocol {
    func saveCity(newCity: UserCities) {
        citiesDataRepository.saveCity(newCity: newCity)
    }
    
    func searchCity(cityName: String, onComplete: @escaping () -> Void?) {
        citiesDataRepository.fetchWeather(cityName: cityName, onComplete: { [weak self]  data in
            DispatchQueue.main.async {
                self?.currentCity = data?[0]
                onComplete()
            }
        })
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
