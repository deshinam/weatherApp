import Foundation

final class SearchCityRouter: SearchCityRouterProtocol {
    
    private var searchCityVC: SearchCityViewControllerProtocol!
    
    init(searchCityVC: SearchCityViewControllerProtocol) {
        self.searchCityVC = searchCityVC
    }
    func closeSearchModule() {
        searchCityVC.dismiss()
    }
}
