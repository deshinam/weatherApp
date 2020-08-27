import UIKit

class CellFactory {
    
    private var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func createCell (type: CellType, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type.rawValue, for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = .systemGray3
        return cell
    }
}

enum CellType: String {
    case searchCell =  "CityCell"
    case cityWeather = "WeatherCell"
}
