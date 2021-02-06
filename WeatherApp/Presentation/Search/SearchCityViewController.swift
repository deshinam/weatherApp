import UIKit

final class SearchCityViewController: UIViewController {

    // MARK: — Private Properties
    private var searchCityPresenter: SearchCityPresenterProtocol?
    private var gradientLayer = CAGradientLayer()

    private struct Constants {
        static let searchFieldBackgroundColor: UIColor = .darkGray
        static let headerLabelText = "Enter city"
        static let headerLabelColor: UIColor = .white
        static let headerFontSize: CGFloat = 14
        static let cellIdentifier = "CityCell"
        static let viewBackgroundColor = UIColor.systemGray5
        static let searchTextFieldBackgroundColor: UIColor = .gray
        static let searchFieldPlaceholderText = "Search"
        static let searchTextFieldTextColor: UIColor = .white
        static let defaultTextForSearchResult = "City is not found"
        static let backgroundGradientColorTop = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
        static let backgroundGradientColorBottom = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0).cgColor
        static let countOfSymbolsInSearchText = 2
        static let numberOfRowsInSearchSection = 1
    }

    lazy private var searchHeader: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.searchFieldBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy private var searchField: UISearchBar = {
        let search = UISearchBar()
        search.showsCancelButton = true
        search.backgroundColor = Constants.searchFieldBackgroundColor
        search.translatesAutoresizingMaskIntoConstraints = false
        search.barTintColor = Constants.searchFieldBackgroundColor
        search.searchTextField.backgroundColor = Constants.searchTextFieldBackgroundColor
        search.backgroundImage = UIImage()
        search.placeholder = Constants.searchFieldPlaceholderText
        search.searchTextField.textColor = Constants.searchTextFieldTextColor
        return search
    }()

    lazy private var headerLabel: UILabel = {
       let label = UILabel()
        label.text = Constants.headerLabelText
        label.textAlignment = .center
        label.textColor = Constants.headerLabelColor
        label.font = UIFont(name: label.font.fontName, size: Constants.headerFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var listIfCitiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        return tableView
    }()

    // MARK: — Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.viewBackgroundColor
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }

    // MARK: — Private Methods
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
        setCancelButton()
    }

    private func setCancelButton() {
        if let cancelButton = searchField.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.setTitleColor(.white, for: .normal)
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
        let colorTop =  Constants.backgroundGradientColorTop
        let colorBottom = Constants.backgroundGradientColorBottom
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func defaultSearchText () -> String {
        if searchField.searchTextField.text?.count == 0 {
            return ""
        } else {
            return Constants.defaultTextForSearchResult
        }
    }
}

extension SearchCityViewController: SearchCityViewControllerProtocol {
    func updateTableView() {
        listIfCitiesTableView.reloadData()
    }

    func setPresenter(presenter: SearchCityPresenter) {
        searchCityPresenter = presenter
    }

    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }

    func getTableView() -> UITableView {
        return listIfCitiesTableView
    }
}

extension SearchCityViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchCityPresenter?.dismissScreen()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= Constants.countOfSymbolsInSearchText {
            searchCityPresenter?.searchCityWeather(cityName: searchText)
        }
    }
}

extension SearchCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfRowsInSearchSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchCityPresenter?.getCell(indexPath: indexPath)
        cell?.textLabel?.text = searchCityPresenter?.getCurrentCityName() ?? defaultSearchText()
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchCityPresenter?.cellTapped()
    }
}
