import Foundation

final class CitiesPresenter: CitiesPresenterProtocol {
    
    private weak var citiesViewControllerProtocol: CitiesViewControllerProtocol?
    private var citiesInteractor: CitiesInteractorProtocol!
    private var cellFactory: CellFactory
    
    
    init (citiesViewControllerProtocol: CitiesViewControllerProtocol) {
        self.citiesViewControllerProtocol = citiesViewControllerProtocol
        cellFactory = CellFactory(tableView: citiesViewControllerProtocol.getTableView() )
    }
    
    func loadUserCities () {
        citiesInteractor.loadUserCities()
    }
    
    func deleteCity (index: Int) {
        citiesInteractor.deleteCity(index: index)
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
