import Foundation

class SearchCityRouter: SearchCityRouterProtocol {
    
    var searchCityVC: SearchCityViewControllerProtocol!
    
    init(searchCityVC: SearchCityViewControllerProtocol) {
        self.searchCityVC = searchCityVC
    }
    func dismissSearchScreen() {
        searchCityVC.dismiss()
    }
}
