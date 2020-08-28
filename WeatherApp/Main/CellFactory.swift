import UIKit

class CellFactory {
    
    private var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func createCell (type: CellType, indexPath: IndexPath, cityWeather: CityWeather? = nil) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type.rawValue, for: indexPath)
        if type == .searchCell {
            return usualCell(cell: cell)
        } else if type == .cityWeather {
            return cityOverviewCell(cell: cell as! CityOverviewTableViewCell, cityWeather: cityWeather)
        }
        
        return cell
    }
    
    private func usualCell (cell: UITableViewCell) -> UITableViewCell {
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = .systemGray3
        return cell
    }
    
    private func cityOverviewCell(cell: CityOverviewTableViewCell, cityWeather: CityWeather?) -> CityOverviewTableViewCell {
            cell.city = cityWeather
        return cell
    }
}

enum CellType: String {
    case searchCell =  "CityCell"
    case cityWeather = "CityOverviewTableViewCell"
}
