import Foundation

final class SearchCityConfigurator {
    func configure(viewController: SearchCityViewControllerProtocol) {
        let presenter = SearchCityPresenter (searchCityViewControllerProtocol: viewController)
        let interactor = SearchCityInteractor()
        let router = SearchCityRouter(searchCityVC: viewController)
        viewController.setPresenter(presenter: presenter)
        presenter.setInteractor(interactor: interactor)
        presenter.setRouter(router: router)
    }
}
