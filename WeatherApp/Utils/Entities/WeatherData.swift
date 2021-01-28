import Foundation

struct WeatherData: Codable {
    let list: [City]
    
}

struct City: Codable {
    let id: Int
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
