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
        var stringWithCities = ""
        let stringCitiesArray = citiesIdsFromRealm?.map{String($0.cityId)}
        stringWithCities = stringCitiesArray?.joined(separator: ",") ?? ""
        return self.citiesDataRepository.fetchWeatherById(cityId: stringWithCities)
    }
    
    private func deleteActions(index: Int) -> Promise<Void>  {
        let cityId = citiesWeather![index].id
        if let deletedCity = citiesDataRepository.findCityById(cityId: cityId ) {
            if  citiesDataRepository.deleteCity(city: deletedCity) {
                return setCityWeather()
            }
        }
        return Promise<Void>()
    }
    
    func cityWeatherCount() -> Int? {
        return self.citiesWeather?.count
    }
    
    func setCityWeather () -> Promise<Void> {
        loadUserCities().done { data -> Void in
            self.citiesWeather = data
        }
    }
    
    func deleteCity (index: Int)-> Promise<Void> {
        deleteActions(index: index).done {
        }
    }
    
    func getCityWeather(id: Int) -> CityWeather? {
        return citiesWeather?[id]
    }
}
