import Foundation

class SearchCityPresenter: SearchCityPresenterProtocol {

    
    private var searchCityViewControllerProtocol: SearchCityViewControllerProtocol
    private var searchCityInteractor: SearchCityInteractorProtocol!
    
    init (searchCityViewControllerProtocol: SearchCityViewControllerProtocol) {
        self.searchCityViewControllerProtocol = searchCityViewControllerProtocol
    }

    func searchCityWeather(cityName: String)  {
        searchCityInteractor.searchCity(cityName: cityName)
    }
    
    
    func setInteractor(interactor: SearchCityInteractor) {
        searchCityInteractor = interactor
    }
    
    func cellTapped () {
        if searchCityInteractor?.addCity() ?? true {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateCities"), object: nil)
                searchCityViewControllerProtocol.dismiss()
            }
        }
    
    func getCurrentCityName () -> String? {
        return searchCityInteractor.getCurrentCityName()
    }
    
    func updateTableView() {
        self.searchCityViewControllerProtocol.updateTableView()
    }
    
    
}

