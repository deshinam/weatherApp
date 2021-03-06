import UIKit
import PromiseKit

protocol CitiesViewControllerProtocol: class {
    func updateCitiesWeather()
    func setPresenter(citiesPresenter: CitiesPresenterProtocol)
    func getTableView() -> UITableView
}

protocol CitiesPresenterProtocol: class {
    func updateTableView()
    func setInteractor(citiesInteractor: CitiesInteractorProtocol)
    func cityWeatherCount() -> Int
    func loadUserCities()
    func deleteCity (index: Int)
    func isEmptyCityWeather() -> Bool
    func getCityWeather(id: Int) -> CityWeather?
    func getCell(indexPath: IndexPath) -> CityOverviewTableViewCell
}

protocol CitiesInteractorProtocol {
    func cityWeatherCount() -> Int?
    func deleteCity (index: Int) -> Promise<Void>
    func setUserCities () -> Promise<Void>
    func getCityWeather(id: Int) -> CityWeather?

}

protocol CitiesRouterProtocol {
}
