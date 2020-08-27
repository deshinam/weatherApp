import Foundation

class CitiesPresenter: CitiesPresenterProtocol {
    
    private var listOfCitiesProtocol: CitiesViewControllerProtocol
    private var citiesInteractor: CitiesInteractorProtocol!
    
    
    init (listOfCitiesProtocol: CitiesViewControllerProtocol) {
        self.listOfCitiesProtocol = listOfCitiesProtocol
    }
    
    func loadUserCities () {
        citiesInteractor.loadUserCities()
    }
    
    func deleteCity (cityId: Int) {
        citiesInteractor.deleteCity(cityId: cityId)
    }
    
    
    func isEmptyCityWeather() -> Bool {
        return citiesInteractor.cityWeatherCount() == nil
    }

    func cityWeatherCount() -> Int {
        return citiesInteractor.cityWeatherCount() ?? 1
    }

    func updateTableView() {
        self.listOfCitiesProtocol.updateCitiesWeather()
    }
    
    func setInteractor(citiesInteractor: CitiesInteractorProtocol) {
        self.citiesInteractor = citiesInteractor
    }
    
}


