import Foundation


class CitiesConfigurator {

    func configure (viewController: CitiesViewControllerProtocol) {
        let presenter = CitiesPresenter(listOfCitiesProtocol: viewController)
        let interactor = CitiesIntercator(presenter: presenter)
        presenter.setInteractor(citiesInteractor: interactor)
        viewController.setPresenter(citiesPresenter: presenter)
    }
}
