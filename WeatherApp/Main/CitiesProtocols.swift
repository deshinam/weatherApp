import Foundation

protocol CitiesViewControllerProtocol {
    func updateCitiesWeather()
    func setPresenter(citiesPresenter: CitiesPresenterProtocol)
}

protocol CitiesPresenterProtocol {
    func updateTableView()
    func setInteractor(citiesInteractor: CitiesInteractorProtocol)
    func cityWeatherCount() -> Int
    func loadUserCities()
    func isEmptyCityWeather() -> Bool
}

protocol CitiesInteractorProtocol {
    func cityWeatherCount() -> Int?
    func deleteCity (cityId: Int)
    func loadUserCities ()
}

protocol CitiesRouterProtocol {
    
}


