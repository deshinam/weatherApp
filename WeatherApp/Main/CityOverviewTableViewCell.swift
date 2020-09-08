import UIKit
import SwipeCellKit

final class CityOverviewTableViewCell: SwipeTableViewCell {
    
    // MARK: — Public Properties
    var city : CityWeather? {
        didSet {
        cityNameLabel.text = city?.name
        cityTemputureLabel.text =  city?.temputure
        cityWeatherImage.image = UIImage(systemName: city?.conditionName ?? "no")
        }
    }
    
    // MARK: — Private Properties
    private var cityNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.text = "111"
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
    }()
    
    private var cityTemputureLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "25"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
    return label
    
    }()
    
    private var cityWeatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
    return image
    }()
    
    // MARK: — Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cityNameLabel)
        addSubview(cityTemputureLabel)
        addSubview(cityWeatherImage)
        
        // city label constraints
        print(contentView.frame.width)
        let cityLeftConstraint = NSLayoutConstraint(item: cityNameLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 25)
        let cityCenterYConstraint = NSLayoutConstraint(item: cityNameLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
        let cityWidthConstraint = NSLayoutConstraint(item: cityNameLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.6, constant: 0)
        let cityHeightConstraint = NSLayoutConstraint(item: cityNameLabel, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: 20)
        
        // image weather constraints
        let imageLeftConstraint = NSLayoutConstraint(item: cityWeatherImage, attribute: .left, relatedBy: .equal, toItem: cityNameLabel, attribute: .right, multiplier: 1, constant: 5)
        let imageCenterYConstraint = NSLayoutConstraint(item: cityWeatherImage, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
        let imageWidthConstraint = NSLayoutConstraint(item: cityWeatherImage, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self, attribute: .width, multiplier: 0.1, constant: 0)
        let imageHeightConstraint = NSLayoutConstraint(item: cityWeatherImage, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0)
        
        // temp weather constraints
        let tempLeftConstraint = NSLayoutConstraint(item: cityTemputureLabel, attribute: .left, relatedBy: .equal, toItem: cityWeatherImage, attribute: .right, multiplier: 1, constant: 25)
        let tempCenterYConstraint = NSLayoutConstraint(item: cityTemputureLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
        let tempWidthConstraint = NSLayoutConstraint(item: cityTemputureLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.2, constant: 0)
        let tempHeightConstraint = NSLayoutConstraint(item: cityTemputureLabel, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: 0)
        
       NSLayoutConstraint.activate([
            cityLeftConstraint, cityCenterYConstraint, cityWidthConstraint,  cityHeightConstraint,
            imageLeftConstraint, imageCenterYConstraint, imageWidthConstraint, imageHeightConstraint,
            tempLeftConstraint, tempCenterYConstraint, tempWidthConstraint, tempHeightConstraint
            ])
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
