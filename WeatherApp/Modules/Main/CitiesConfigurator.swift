import Foundation

final class CitiesConfigurator {
    func configure (viewController: CitiesViewControllerProtocol) {
        let presenter = CitiesPresenter(citiesViewControllerProtocol: viewController)
        let interactor = CitiesIntercator(presenter: presenter)
        presenter.setInteractor(citiesInteractor: interactor)
        viewController.setPresenter(citiesPresenter: presenter)
    }
}
