import UIKit
import SwipeCellKit

class CitiesViewController: UIViewController, CitiesViewControllerProtocol {

    var addCityButton: AddElementButton?
    var citiesPresenter: CitiesPresenterProtocol?
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        setupTableView()
        setupAddCityButton()
        citiesPresenter = CitiesPresenter(listOfCitiesProtocol: self)
        NotificationCenter.default.addObserver(self, selector: #selector(createArray(_:)), name: NSNotification.Name(rawValue: "updateCities"), object: nil)
        createArray()
    }
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CityOverviewTableViewCell.self, forCellReuseIdentifier: "CityOverviewTableViewCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var defaultScreen : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()
    
    var defaultLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.text = "Choose a city to see the weather forecast"
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
    }()
    
    @objc func createArray(_ sender: Any? = nil) {
        citiesPresenter?.loadUserCities()
    }

    func setupTableView () {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let tableViewTopConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 30)
        let tableViewBottomConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -80)
        let tableViewLeftConstraint = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let tableViewRightConstraint = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([
            tableViewTopConstraint, tableViewBottomConstraint, tableViewLeftConstraint, tableViewRightConstraint
        ])
    }
    
    func setupAddCityButton() {
        addCityButton = AddElementButton(frame: .zero)
        view.addSubview(addCityButton!)
        let addCityButtonCenterXConstraint = NSLayoutConstraint(item: addCityButton as Any, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let addCityButtonWidthConstraint = NSLayoutConstraint(item: addCityButton as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 40)
        let addCityButtonHeightConstraint = NSLayoutConstraint(item: addCityButton as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40)
        let addCityButtonBottomConstraint = NSLayoutConstraint(item: addCityButton as Any, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -20)

        NSLayoutConstraint.activate([
                addCityButtonWidthConstraint, addCityButtonHeightConstraint, addCityButtonBottomConstraint,
                addCityButtonCenterXConstraint
        ])
        addCityButton?.addTarget(self, action: #selector(addCityButtonTapped(sender:)), for: .touchUpInside)
    }
    
    func setupDefaultScreen() {
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
    
    @objc func addCityButtonTapped (sender: AddElementButton!) {
        let router = CitiesRouter()
        router.goToSearch(citiesViewController: self)
//        let searchCityVC = SearchCityViewController()
//        searchCityVC.modalPresentationStyle = .popover
//        let configurator = SearchCityConfigurator()
//        configurator.configure(viewController: searchCityVC)
//        self.present(searchCityVC, animated: true, completion: nil)
      }
    func updateCitiesWeather() {
        tableView.reloadData()
    }
    
    func setupUI() {
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
    
    func setPresenter(citiesPresenter: CitiesPresenterProtocol) {
        self.citiesPresenter = citiesPresenter
    }
    
}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setupUI()
        return citiesPresenter!.cityWeatherCount()
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityOverviewTableViewCell", for: indexPath) as! CityOverviewTableViewCell
//            cell.delegate = self
//        if citiesPresenter?.citiesWeather?[indexPath.row] != nil {
//            cell.city = citiesPresenter?.citiesWeather![indexPath.row]
//        } else {
//                cell.city = nil
//        }
        return cell

    }
}

//extension CitiesViewController: SwipeTableViewCellDelegate {
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//            self.citiesPresenter?.deleteCity(cityId: self.citiesPresenter!.citiesWeather![indexPath.row].id)
//        }
//
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "trash")
//        return [deleteAction]
//    }
//}


