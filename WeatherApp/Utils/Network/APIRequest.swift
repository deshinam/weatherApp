import Foundation

public enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public enum RequestType {
    case byName
    case byIds
}

struct Request {
    let HTTPMethodType: HTTPMethodType
    let requestType: RequestType
    let url: String
}


