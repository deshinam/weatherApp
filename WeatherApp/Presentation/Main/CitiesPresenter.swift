import Foundation
import PromiseKit

final class CitiesPresenter {
    
    // MARK: — Private Properties
    private weak var citiesViewControllerProtocol: CitiesViewControllerProtocol?
    private var citiesInteractor: CitiesInteractorProtocol!
    private var cellFactory: CellFactory
    
    // MARK: — Initializers
    init (citiesViewControllerProtocol: CitiesViewControllerProtocol) {
        self.citiesViewControllerProtocol = citiesViewControllerProtocol
        cellFactory = CellFactory(tableView: citiesViewControllerProtocol.getTableView() )
    }
}

extension CitiesPresenter: CitiesPresenterProtocol {
    // MARK: — Public Methods
    func loadUserCities () {
        citiesInteractor.setCityWeather()
            .done {
                self.updateTableView()
            }
    }
    
    func deleteCity (index: Int) {
        citiesInteractor.deleteCity(index: index)
            .done {
                self.updateTableView()
            }
    }
    
    
    func isEmptyCityWeather() -> Bool {
        return citiesInteractor.cityWeatherCount() == nil
    }
    
    func cityWeatherCount() -> Int {
        return citiesInteractor.cityWeatherCount() ?? 1
    }
    
    func updateTableView() {
        if self.citiesViewControllerProtocol != nil {
            self.citiesViewControllerProtocol!.updateCitiesWeather()
        }
    }
    
    func setInteractor(citiesInteractor: CitiesInteractorProtocol) {
        self.citiesInteractor = citiesInteractor
    }
    
    func getCityWeather(id: Int) -> CityWeather? {
        return citiesInteractor.getCityWeather(id: id)
    }
    
    func getCell(indexPath: IndexPath)-> CityOverviewTableViewCell {
        return cellFactory.createCell(type: .cityWeather, indexPath: indexPath, cityWeather: getCityWeather(id: indexPath.row)) as! CityOverviewTableViewCell
    }
}
