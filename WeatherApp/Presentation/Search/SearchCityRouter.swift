import Foundation

final class SearchCityRouter {

    // MARK: — Private Properties
    private var searchCityVC: SearchCityViewControllerProtocol!

    // MARK: — Initializers
    init(searchCityVC: SearchCityViewControllerProtocol) {
        self.searchCityVC = searchCityVC
    }
}

extension SearchCityRouter: SearchCityRouterProtocol {
    func closeSearchModule() {
        searchCityVC.dismiss()
    }
}
