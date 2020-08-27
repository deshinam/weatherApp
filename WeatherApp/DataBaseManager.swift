import Foundation
import RealmSwift

struct DataBaseManager {

    private var realm = try! Realm()
    static var sharedUserCitiesManager = DataBaseManager()
    var currentUserCities: Results <UserCities>?

    private init()  {}

    mutating func loadCities () -> Results <UserCities>?  {
        currentUserCities = realm.objects(UserCities.self)
        return currentUserCities
    }

    mutating func saveCity (newCity: UserCities) {
        do {
            try realm.write()  {
                realm.add(newCity, update: .modified)
            }
        } catch {
            print (error)
        }
    }
    
    func findCityById (cityId: Int) -> UserCities? {
        return DataBaseManager.sharedUserCitiesManager.currentUserCities?.filter({ $0.cityId == cityId}).first
    }
    
    mutating func deleteCity (city: UserCities) -> Bool {
        
        var result = false
        do {
            try realm.write()  {
                realm.delete(city)
                result = true
                
            }
        } catch {
            print (error)
            
        }
        return result
        
    }

}
