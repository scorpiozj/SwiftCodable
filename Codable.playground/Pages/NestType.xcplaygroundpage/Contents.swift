//: [Previous](@Basic)

import Foundation


struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct Landmark: Codable {
    var name: String
    var founding: Int
    
    // Landmark now supports the Codable methods init(from:) and encode(to:),
    // even though they aren't written as part of its declaration.
    var location: Coordinate
    
    private enum CodingKeys:String, CodingKey {
        case name
        case founding = "foundingYear"
        case latitude
        case longitude
    }
//    private enum AdditionalInfoKeys:String, CodingKeys {
//        case location
//    }
    init?(intValue: Int) {
        return nil
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        founding = try values.decode(Int.self, forKey: .founding)
        location = try Coordinate(from: decoder)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(founding, forKey: .founding)
        try container.encode(location.latitude, forKey: .latitude)
        try container.encode(location.longitude, forKey: .longitude)
    }
}


let json = """
[
    {
        "name":"Suny Island",
        "foundingYear":1976,
        "latitude": 102.9870,
        "longitude": 32.9870
    },
    {
        "name":"Green park",
        "foundingYear":2008,
        "latitude": 32.9870,
        "longitude": 27.9870
    }
]
"""

let jsonData = json.data(using: .utf8)!

let decoder = JSONDecoder()

do {
    let placesInterest = try decoder.decode([Landmark].self, from: jsonData)
    for place in placesInterest {
        print("\(place.name) at \(place.founding)")
        print("\(place.location)")
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
