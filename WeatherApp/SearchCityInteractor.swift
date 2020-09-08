import Foundation

final class SearchCityInteractor {
    
    // MARK: — Private Properties
    private weak var presenter: SearchCityPresenterProtocol!
    private var networkManager: NetworkManager = NetworkManager()
    private var dataBaseManager: DataBaseManager = DataBaseManager.sharedUserCitiesManager
    private var currentCity: CityWeather?
    
    // MARK: — Initializers
    init(presenter: SearchCityPresenterProtocol) {
        self.presenter = presenter
    }
}

extension SearchCityInteractor: SearchCityInteractorProtocol {
    func saveCity(newCity: UserCities) {
        dataBaseManager.saveCity(newCity: newCity)
    }
    
    func searchCity(cityName: String) {
        networkManager.fetchWeather(cityName: cityName, onComplete: { [weak self]  data in
             DispatchQueue.main.async {
                 self?.currentCity = data?[0]
                self?.presenter.updateTableView()

             }
         })
    }
    
    func getCurrentCityName () -> String? {
           return currentCity?.name
    }
    
    func addCity() -> Bool {
        guard currentCity != nil else {
            return false
        }
        let newCity = UserCities(cityId: currentCity!.id, cityName: currentCity!.name)
        dataBaseManager.saveCity(newCity: newCity)
            return true
    }
}
