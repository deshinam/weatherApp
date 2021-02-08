import Foundation

final class CitiesConfigurator {
    func configure (viewController: CitiesViewControllerProtocol) {
        let presenter = CitiesPresenter(citiesViewControllerProtocol: viewController)
        let interactor = CitiesInteractor()
        presenter.setInteractor(citiesInteractor: interactor)
        viewController.setPresenter(citiesPresenter: presenter)
    }
}
