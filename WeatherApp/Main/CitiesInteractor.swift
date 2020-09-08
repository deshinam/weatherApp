import Foundation

final class CitiesIntercator: CitiesInteractorProtocol {
    
    private var networkManager = NetworkManager()
    private var citiesWeather: [CityWeather]?
    private weak var presenter: CitiesPresenterProtocol!
    
    init(presenter: CitiesPresenterProtocol) {
        self.presenter = presenter
    }
    
    func isEmptyCityWeather() -> Bool {
        return self.citiesWeather?.count == nil
    }
    
    func cityWeatherCount() -> Int? {
        return self.citiesWeather?.count
    }
    
    func loadUserCities () {
        let citiesIdsFromRealm = DataBaseManager.sharedUserCitiesManager.loadCities()
        var stringWithCities = ""
        citiesIdsFromRealm?.forEach({
            stringWithCities += "\($0.cityId),"
        })
        print(stringWithCities.count)
        if citiesIdsFromRealm != nil {
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.networkManager.fetchWeatherById(cityId: stringWithCities, onComplete: { data in self?.citiesWeather = data
                    DispatchQueue.main.async {
                        self?.presenter.updateTableView()
                    }
                })
            }
        }
    }
    
    func deleteCity (index: Int) {
        let cityId = citiesWeather![index].id
        if let deletedCity = DataBaseManager.sharedUserCitiesManager.findCityById(cityId: cityId ) {
            if  DataBaseManager.sharedUserCitiesManager.deleteCity(city: deletedCity) {
                loadUserCities()
            }
        }
        
    }
    
    func getCityWeather(id: Int) -> CityWeather? {
        return citiesWeather?[id]
    }
    
}

