import Foundation

final class CitiesIntercator {
    
    // MARK: — Private Properties
    private var citiesDataRepository = CitiesDataRepository()
    private var citiesWeather: [CityWeather]?
}

extension CitiesIntercator: CitiesInteractorProtocol {
    func cityWeatherCount() -> Int? {
        return self.citiesWeather?.count
    }
    
    func loadUserCities (onComplete: @escaping () -> Void?) {
        let citiesIdsFromRealm = citiesDataRepository.loadCities()
        var stringWithCities = ""
        let stringCitiesArray = citiesIdsFromRealm?.map{String($0.cityId)}
        stringWithCities = stringCitiesArray?.joined(separator: ",") ?? ""
        if citiesIdsFromRealm != nil {
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.citiesDataRepository.fetchWeatherById(cityId: stringWithCities, onComplete: { data in self?.citiesWeather = data
                    DispatchQueue.main.async {
                        onComplete()
                    }
                })
            }
        }
    }
    
    func deleteCity (index: Int, onComplete: @escaping () -> Void? ) {
        let cityId = citiesWeather![index].id
        if let deletedCity = citiesDataRepository.findCityById(cityId: cityId ) {
            if  citiesDataRepository.deleteCity(city: deletedCity) {
                loadUserCities(onComplete: onComplete)
            }
        }
    }
    
    func getCityWeather(id: Int) -> CityWeather? {
        return citiesWeather?[id]
    }
}

