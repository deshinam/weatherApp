import UIKit

protocol SearchCityViewControllerProtocol: class {
    func updateTableView()
    func setPresenter (presenter: SearchCityPresenter)
    func dismiss ()
    func getTableView() -> UITableView
}

protocol SearchCityPresenterProtocol: class {
    
    func searchCityWeather(cityName: String)
    func cellTapped ()
    func getCurrentCityName() -> String?
    func setInteractor(interactor: SearchCityInteractor)
    func updateTableView()
    func setRouter(router: SearchCityRouter)
    func dismissScreen()
    func getCell(indexPath: IndexPath)-> UITableViewCell
}

protocol SearchCityInteractorProtocol {
    func saveCity(newCity: UserCities)
    func searchCity(cityName: String, onComplete: @escaping () -> Void?)
    func getCurrentCityName() -> String?
    func addCity() -> Bool
}

protocol SearchCityRouterProtocol {
    func closeSearchModule()
}
