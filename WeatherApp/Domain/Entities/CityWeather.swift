import Foundation

struct CityWeather: RequestObject {

    var cityWeatherId: Int
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
    init (decodedData: Any) {
        let decodedDataCity = decodedData as? City
        conditionId = decodedDataCity?.weather[0].id ?? 0
        temputure = String((decodedDataCity)?.main.temp ?? 0)
        cityWeatherId = decodedDataCity?.id ?? 0
        name = decodedDataCity?.name ?? ""
    }
}
