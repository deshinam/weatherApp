import UIKit

final class SearchCityPresenter: SearchCityPresenterProtocol {

    private weak var searchCityViewControllerProtocol: SearchCityViewControllerProtocol?
    private var searchCityInteractor: SearchCityInteractorProtocol!
    private var searchCityRouter: SearchCityRouterProtocol!
    private var cellFactory: CellFactory
    
    init (searchCityViewControllerProtocol: SearchCityViewControllerProtocol) {
        self.searchCityViewControllerProtocol = searchCityViewControllerProtocol
               cellFactory = CellFactory(tableView: searchCityViewControllerProtocol.getTableView() )
    }

    func searchCityWeather(cityName: String)  {
        searchCityInteractor.searchCity(cityName: cityName)
    }
    
    
    func setInteractor(interactor: SearchCityInteractor) {
        searchCityInteractor = interactor
    }
    
    func setRouter(router: SearchCityRouter) {
        searchCityRouter = router
    }
    
    func cellTapped () {
        if searchCityInteractor?.addCity() ?? true {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateCities"), object: nil)
            dismissScreen()
            }
        }
    
    func getCurrentCityName () -> String? {
        return searchCityInteractor.getCurrentCityName()
    }
    
    func updateTableView() {
        if self.searchCityViewControllerProtocol != nil {
            self.searchCityViewControllerProtocol!.updateTableView()
        }
        
    }
    func dismissScreen() {
        searchCityRouter.closeSearchModule()
    }
    
    func getCell(indexPath: IndexPath)-> UITableViewCell {
        return cellFactory.createCell(type: .searchCell, indexPath: indexPath)
    }
    
}

