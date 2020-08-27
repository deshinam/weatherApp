import UIKit

class CitiesRouter: CitiesRouterProtocol {
    
    weak var searchCityVC: SearchCityViewController!
    
    func goToSearch(citiesViewController: CitiesViewController) {
        searchCityVC.modalPresentationStyle = .popover
        let configurator = SearchCityConfigurator()
        configurator.configure(viewController: searchCityVC)
        citiesViewController.present(searchCityVC, animated: true, completion: nil)
    }
}
