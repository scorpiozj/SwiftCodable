//: Playground - noun: a place where people can play

import Foundation

let json = """
[
    {
        "product_name": "Bananas",
        "product_cost": 200,
        "description": "A banana grown in Ecuador."
    },
    {
        "product_name": "Oranges",
        "product_cost": 100,
        "description": "A juicy orange."
    }
]
""".data(using: .utf8)!

struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "product_name"
        case points = "product_cost"
        case description
    }
}

let decoder = JSONDecoder()

do {
    let products = try decoder.decode([GroceryProduct].self, from: json)
    print("The following products are available:")
    for product in products {
        print("\t\(product.name) (\(product.points) points)")
        if let description = product.description {
            print("\t\t\(description)")
        }
    }
} catch  {
    print("error: \(error)")
}



