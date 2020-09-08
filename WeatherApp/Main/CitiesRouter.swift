import UIKit

final class CitiesRouter: CitiesRouterProtocol {
    
    private weak var searchCityVC: SearchCityViewController!
    
    func openSearchModule(citiesViewController: CitiesViewController) {
        let searchCityVC = SearchCityViewController()
        searchCityVC.modalPresentationStyle = .popover
        let configurator = SearchCityConfigurator()
        configurator.configure(viewController: searchCityVC)
        citiesViewController.present(searchCityVC, animated: true, completion: nil)
    }
}
