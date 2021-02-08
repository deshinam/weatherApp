import Foundation

class PreferenseStorage {

    private let currentCityKey = "currentCity"
    private var userDefaults: UserDefaults

    init(userDefaults: UserDefaults = Foundation.UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func setCurrentCity(currentCity: CityWeather) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currentCity) {
            userDefaults.set(encoded, forKey: currentCityKey)
        }
    }

    func getCurrentCity() -> CityWeather? {
        if let cityWeatherData = userDefaults.object(forKey: currentCityKey) as? Data {
            let decoder = JSONDecoder()
            if let cityWeather = try? decoder.decode(CityWeather.self, from: cityWeatherData) {
                print(cityWeather.name)
                return cityWeather
            }
        }
        return nil
    }
}
