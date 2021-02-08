import Foundation
import RealmSwift
import PromiseKit

struct DataBaseManager {

    // MARK: — Private Properties
    private var realm = try? Realm()

    // MARK: — Public Properties
    static var sharedUserCitiesManager = DataBaseManager()
    var currentUserCities: Results <UserCities>?

    // MARK: — Initializers
    private init() {}

    // MARK: — Public Methods
    mutating func loadCities () -> Results <UserCities>? {
        currentUserCities = realm?.objects(UserCities.self)
        return currentUserCities
    }

    mutating func saveCity(newCity: UserCities) {
        do {
            try realm?.write {
                realm?.add(newCity, update: .modified)
            }
        } catch {
        }
    }

    func findCityById(cityId: Int) -> Promise<UserCities?> {
        var cityById: UserCities?
        return firstly { () -> Promise<UserCities?> in
            cityById = currentUserCities?.filter({ $0.cityId == cityId}).first
            return .value(cityById)
        }
    }

    mutating func deleteCity (city: UserCities) -> Promise<Bool> {
        var result = false
        return firstly { () -> Promise<Bool> in
            do {
                try realm?.write {
                    realm?.delete(city)
                    result = true
                }} catch {}
            return .value(result)
        }
    }
}
