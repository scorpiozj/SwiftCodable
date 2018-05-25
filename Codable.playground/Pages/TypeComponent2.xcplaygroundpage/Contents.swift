//: [Previous](@TypeComponent)

import Foundation

struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    var latitude: Double
    var longitude: Double
    
    private enum CodingKeys:String, CodingKey {
        case name
        case detail
        
    }
    private enum DetailKeys: String, CodingKey{
        case foundingYear
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        let detailInfo = try values.nestedContainer(keyedBy: DetailKeys.self, forKey: .detail)
        foundingYear = try detailInfo.decode(Int.self, forKey: .foundingYear)
        latitude = try detailInfo.decode(Double.self, forKey: .latitude)
        longitude = try detailInfo.decode(Double.self, forKey: .longitude)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        var detailInfo = container.nestedContainer(keyedBy: DetailKeys.self, forKey: .detail)
        try detailInfo.encode(foundingYear, forKey: .foundingYear)
        try detailInfo.encode(latitude, forKey: .latitude)
        try detailInfo.encode(longitude, forKey: .longitude)
    }
}


let json = """
[
    {
        "name":"Suny Island",
        "detail":{
            "foundingYear":1976,
            "latitude": 102.9870,
            "longitude": 32.9870
        }
    },
    {
        "name":"Green park",
        "detail": {
            "foundingYear":2008,
            "latitude": 32.9870,
            "longitude": 27.9870
        }
    }
]
"""

let jsonData = json.data(using: .utf8)!

let decoder = JSONDecoder()

do {
    let placesInterest = try decoder.decode([Landmark].self, from: jsonData)
    for place in placesInterest {
        print("\(place) ")
    }

    let encoder = JSONEncoder()

    do {
        let placesToEncode = placesInterest
        let data = try encoder.encode(placesToEncode)
        let string = String(data: data, encoding: .utf8) ?? "empty"
        print("string=:\n \(string)")

    } catch{
        print("encode error: \(error)")
    }

} catch {
    print("error:\(error)")
}

//: [Next](@next)
