import Foundation

protocol RequestProtocol {
    associatedtype T: Decodable
    var url: String {get}
    func transformDataToCityWeatherArray(decodedData: T) ->[CityWeather]?
}

class CityByIdRequest: RequestProtocol {
    typealias T = WeatherData
    var cityIds: String
    var url: String
    
    // MARK: — Initializers
    init(cityIds: String) {
        self.url =  "https://api.openweathermap.org/data/2.5/group?id=\(cityIds)&units=metric&appid=04d9b06b9d3a43d2680c28c9f90e9ed2"
        self.cityIds = cityIds
    }
    
    // MARK: — Public Methods
    func transformDataToCityWeatherArray(decodedData: WeatherData) ->[CityWeather]? {
        var cityWeathers =  [CityWeather]()
        decodedData.list.forEach( { item in
            let weather = CityWeather(decodedData: item)
            cityWeathers.append(weather)
        })
        return cityWeathers
    }
}

class CityByNameRequest: RequestProtocol {
    typealias T = City
    var cityName: String
    var url: String
    
    // MARK: — Initializers
    init(cityName: String) {
        self.url = "https://api.openweathermap.org/data/2.5/weather?appid=04d9b06b9d3a43d2680c28c9f90e9ed2&units=metric&q=\(cityName)"
        self.cityName = cityName
    }
    
    // MARK: — Public Methods
    func transformDataToCityWeatherArray(decodedData: City) ->[CityWeather]? {
        let weather = CityWeather(decodedData: decodedData)
        return [weather]
    }
}
