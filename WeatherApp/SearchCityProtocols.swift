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
    func setRouter(router: SearchCityRouter)
    func dismissScreen()
}

protocol SearchCityInteractorProtocol {
    func saveCity(newCity: UserCities)
    func searchCity(cityName: String)
    func getCurrentCityName() -> String?
    func addCity() -> Bool
}

protocol SearchCityRouterProtocol {
    func dismissSearchScreen()
}
