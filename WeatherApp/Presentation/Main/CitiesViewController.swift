import UIKit

final class CitiesViewController: UIViewController {

    // MARK: — Private Properties
    private var addCityButton: AddElementButton?
    private var citiesPresenter: CitiesPresenterProtocol?

    private struct Constants {
        static let deleteIcon = "trash"
        static let defaultScreenColor: UIColor = .white
        static let fontLabelSize: CGFloat = 18
        static let defaultLabelColor: UIColor = .black
        static let defaultLabelText = "Choose a city to see the weather forecast"
        static let cellIdentifier = "CityOverviewTableViewCell"
    }

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CityOverviewTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    lazy private var defaultScreen: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.defaultScreenColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()

    lazy private var defaultLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = Constants.defaultLabelColor
        lbl.font = UIFont.boldSystemFont(ofSize: Constants.fontLabelSize)
        lbl.text = Constants.defaultLabelText
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
    }()

    // MARK: — Lifecycle
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = Constants.defaultScreenColor
        setupTableView()
        setupAddCityButton()
        NotificationCenter.default.addObserver(self, selector: #selector(createArray(_:)), name: NSNotification.Name(rawValue: PublicConstants.notificationUpdateCities), object: nil)
        createArray()
    }

    // MARK: — Private Methods
    private func setupTableView () {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let tableViewTopConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 70)
        let tableViewBottomConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -80)
        let tableViewLeftConstraint = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let tableViewRightConstraint = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([
            tableViewTopConstraint, tableViewBottomConstraint, tableViewLeftConstraint, tableViewRightConstraint
        ])
    }

    private func setupAddCityButton() {
        addCityButton = AddElementButton(type: .system)
        view.addSubview(addCityButton!)
        let addCityButtonCenterXConstraint = NSLayoutConstraint(item: addCityButton as Any, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let addCityButtonWidthConstraint = NSLayoutConstraint(item: addCityButton as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 40)
        let addCityButtonHeightConstraint = NSLayoutConstraint(item: addCityButton as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40)
        let addCityButtonBottomConstraint = NSLayoutConstraint(item: addCityButton as Any, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -40)

        NSLayoutConstraint.activate([
                addCityButtonWidthConstraint, addCityButtonHeightConstraint, addCityButtonBottomConstraint,
                addCityButtonCenterXConstraint
        ])
        addCityButton?.addTarget(self, action: #selector(addCityButtonTapped(sender:)), for: .touchUpInside)
    }

    private func setupDefaultScreen() {
        view.addSubview(defaultScreen)
        if addCityButton != nil {
            view.bringSubviewToFront(addCityButton!)
        }
        view.addSubview(defaultLabel)
        let defaultScreenTopConstraint = NSLayoutConstraint(item: defaultScreen, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let defaultScreenBottomConstraint = NSLayoutConstraint(item: defaultScreen, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let defaultScreenLeftConstraint = NSLayoutConstraint(item: defaultScreen, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let defaultScreenRightConstraint = NSLayoutConstraint(item: defaultScreen, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)

        let defaultLabelLeftConstraint = NSLayoutConstraint(item: defaultLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        let defaultLabelRightConstraint = NSLayoutConstraint(item: defaultLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
        let defaultLabelCenterYConstraint = NSLayoutConstraint(item: defaultLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)

         NSLayoutConstraint.activate([
             defaultScreenTopConstraint, defaultScreenBottomConstraint, defaultScreenLeftConstraint, defaultScreenRightConstraint,
             defaultLabelLeftConstraint, defaultLabelRightConstraint, defaultLabelCenterYConstraint
         ])
    }

    private func setupUI() {
        if citiesPresenter?.isEmptyCityWeather() ?? true {
            setupDefaultScreen()
            defaultScreen.isHidden = false
            defaultLabel.isHidden = false
            tableView.isHidden = true
        } else {
            defaultScreen.isHidden = true
            defaultLabel.isHidden = true
            tableView.isHidden = false
        }
    }

    @objc private func createArray(_ sender: Any? = nil) {
        citiesPresenter?.loadUserCities()
    }

    @objc private func addCityButtonTapped (sender: AddElementButton!) {
        let router = CitiesRouter()
        router.openSearchModule(citiesViewController: self)
    }
}

extension CitiesViewController: CitiesViewControllerProtocol {
    func setPresenter(citiesPresenter: CitiesPresenterProtocol) {
        self.citiesPresenter = citiesPresenter
    }

    func getTableView() -> UITableView {
        return tableView
    }

    func updateCitiesWeather() {
        tableView.reloadData()
    }
}

// MARK: — Table Data Sourse
extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setupUI()
        return citiesPresenter!.cityWeatherCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesPresenter?.getCell(indexPath: indexPath)
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let rightAction = UIContextualAction(style: .normal, title: "Delete", handler: { [weak self] (_: UIContextualAction, _: UIView, success: (Bool) -> Void) in
            self?.citiesPresenter?.deleteCity(index: indexPath.row)
            success(true)
        })

        rightAction.image = UIImage(systemName: Constants.deleteIcon)
        rightAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [rightAction])
    }
}
