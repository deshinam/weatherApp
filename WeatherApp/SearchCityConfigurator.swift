import Foundation

class SearchCityConfigurator {
    func configure(viewController: SearchCityViewControllerProtocol) {
        let presenter = SearchCityPresenter (searchCityViewControllerProtocol: viewController)
        let interactor = SearchCityInteractor(presenter: presenter)
        viewController.setPresenter(presenter: presenter)
        presenter.setInteractor(interactor: interactor)
    }
}
