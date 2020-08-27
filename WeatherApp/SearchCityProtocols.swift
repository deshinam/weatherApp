import Foundation

protocol SearchCityViewControllerProtocol {
    func updateTableView()
    func setPresenter (presenter: SearchCityPresenter)
    func dismiss ()
}

protocol SearchCityPresenterProtocol {
    
    func searchCityWeather(cityName: String)
    func cellTapped ()
    func getCurrentCityName() -> String?
    func setInteractor(interactor: SearchCityInteractor)
    func updateTableView()
}

protocol SearchCityInteractorProtocol {
    func saveCity(newCity: UserCities)
    func searchCity(cityName: String)
    func getCurrentCityName() -> String?
    func addCity() -> Bool
}
