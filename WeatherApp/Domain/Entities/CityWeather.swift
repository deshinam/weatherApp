import Foundation

struct CityWeather {
    
    var id: Int
    var name: String
    var temputure: String
    var conditionId: Int = 200
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}

extension CityWeather {
    init (decodedData: City) {
        conditionId = decodedData.weather[0].id
        temputure = String(decodedData.main.temp)
        id = decodedData.id
        name = decodedData.name
    }
}
