import UIKit

class SearchCityViewController: UIViewController, SearchCityViewControllerProtocol {
    
    private var searchCityPresenter: SearchCityPresenterProtocol!
    private var gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray5
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    var searchHeader : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var searchField: UISearchBar = {
        let search = UISearchBar()
        search.showsCancelButton = true
        search.backgroundColor = .darkGray
        search.translatesAutoresizingMaskIntoConstraints = false

        return search
    }()
    
    var headerLabel: UILabel = {
       let label = UILabel()
        label.text = "Enter city"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: label.font.fontName, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var listIfCitiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
        return tableView
    }()
    
    private func configureUI() {
        view.addSubview(searchHeader)
        view.addSubview(listIfCitiesTableView)
        listIfCitiesTableView.delegate = self
        listIfCitiesTableView.dataSource = self
        listIfCitiesTableView.separatorStyle = .none
        listIfCitiesTableView.backgroundColor = UIColor.clear
        searchField.delegate = self
        searchField.becomeFirstResponder()
        searchHeader.addSubview(searchField)
        searchHeader.addSubview(headerLabel)
        setupConstraints()
        changeBackgroundSearchColor()
    }
    
    
    private func changeBackgroundSearchColor() {
        searchField.backgroundImage = UIImage()
        searchField.barTintColor = .darkGray
        searchField.searchTextField.backgroundColor = .gray
        searchField.placeholder = "Search"
        searchField.searchTextField.textColor = .white
        if let cancelButton = searchField.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.setTitleColor(.white,  for: .normal)
        }
    }
    
    private func setupConstraints() {
        let searchHeaderLeftConstraint = NSLayoutConstraint(item: searchHeader, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let searchHeaderRightConstraint = NSLayoutConstraint(item: searchHeader, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let searchHeaderHeightConstraint = NSLayoutConstraint(item: searchHeader, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 90)
        let searchHeaderTopConstraint = NSLayoutConstraint(item: searchHeader, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        
        let searchFieldLeftConstraint = NSLayoutConstraint(item: searchField, attribute: .leading, relatedBy: .equal, toItem: searchHeader, attribute: .leading, multiplier: 1, constant: 10)
        let searchFieldRightConstraint = NSLayoutConstraint(item: searchField, attribute: .trailing, relatedBy: .equal, toItem: searchHeader, attribute: .trailing, multiplier: 1, constant: -10)
        let searchFieldHeightConstraint = NSLayoutConstraint(item: searchField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 45)
        let searchFieldBottomConstraint = NSLayoutConstraint(item: searchField, attribute: .bottom, relatedBy: .equal, toItem: searchHeader, attribute: .bottom, multiplier: 1, constant: -10)
        
        let headerLabelLeftConstraint = NSLayoutConstraint(item: headerLabel, attribute: .leading, relatedBy: .equal, toItem: searchHeader, attribute: .leading, multiplier: 1, constant: 20)
        let headerLabelRightConstraint = NSLayoutConstraint(item: headerLabel, attribute: .trailing, relatedBy: .equal, toItem: searchHeader, attribute: .trailing, multiplier: 1, constant: -20)
        let headerLabelHeightConstraint = NSLayoutConstraint(item: headerLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 15)
        let headerLabelTopConstraint = NSLayoutConstraint(item: headerLabel, attribute: .top, relatedBy: .equal, toItem: searchHeader, attribute: .top, multiplier: 1, constant: 10)
        
        let listOfCitiesTVLeftConstraint = NSLayoutConstraint(item: listIfCitiesTableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        let listOfCitiesTVRightConstraint = NSLayoutConstraint(item: listIfCitiesTableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
        let listOfCitiesTVBottomConstraint = NSLayoutConstraint(item: listIfCitiesTableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 40)
        let listOfCitiesTVTopConstraint = NSLayoutConstraint(item: listIfCitiesTableView, attribute: .top, relatedBy: .equal, toItem: searchHeader, attribute: .bottom, multiplier: 1, constant: 15)
        
        NSLayoutConstraint.activate([
            searchHeaderLeftConstraint, searchHeaderRightConstraint, searchHeaderHeightConstraint, searchHeaderTopConstraint,
            searchFieldLeftConstraint, searchFieldRightConstraint, searchFieldHeightConstraint, searchFieldBottomConstraint,
            headerLabelLeftConstraint, headerLabelRightConstraint, headerLabelHeightConstraint, headerLabelTopConstraint,
            listOfCitiesTVLeftConstraint, listOfCitiesTVRightConstraint, listOfCitiesTVBottomConstraint, listOfCitiesTVTopConstraint
        ])
        
    }
    
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func updateTableView() {
        listIfCitiesTableView.reloadData()
    }
    
    func setPresenter(presenter: SearchCityPresenter) {
        searchCityPresenter = presenter
    }
    
    private func defaultSearchText () -> String {
        if searchField.searchTextField.text?.count == 0 {
            return ""
        } else {
            return "City not found"
        }
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchCityViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print ("cancel")
        searchCityPresenter.dismissScreen()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 2 {
            searchCityPresenter?.searchCityWeather(cityName: searchText)
        }
    }
}

extension SearchCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellFactory = CellFactory(tableView: tableView)
        var cell = cellFactory.createCell(type: .searchCell, indexPath: indexPath)
        cell.textLabel?.text = searchCityPresenter?.getCurrentCityName() ?? defaultSearchText()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchCityPresenter.cellTapped()
    }
    
}
