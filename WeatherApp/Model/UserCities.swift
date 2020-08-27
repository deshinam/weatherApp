
import Foundation
import RealmSwift

class UserCities: Object {
    @objc dynamic var cityId: Int
    @objc dynamic var cityName: String
    
    override static func primaryKey() -> String? {
        return "cityId"
    }
    
    init (cityId: Int, cityName: String) {
        self.cityId = cityId
        self.cityName = cityName

    }
    
    override required init() {
        cityId = 0
        cityName = ""
    }
}


