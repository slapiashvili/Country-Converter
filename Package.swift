// swift-tools-version: 5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CountryConverter
import Foundation


let package = Package(
    name: "CountryConverter",
    platforms: [
        .iOS(.v14), 
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "CountryConverter",
            targets: ["CountryConverter"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CountryConverter",
            dependencies: []),
        .testTarget(
            name: "CountryConverterTests",
            dependencies: ["CountryConverter"]),
    ]
)



public struct CountryConverter {
    
    private static let apiUrl = "https://restcountries.com/v3.1/alpha?codes="

    public static func convertCodeToName(_ code: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "\(apiUrl)\(code.lowercased())") else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                let countryName = countries.first?.name?.common
                completion(countryName)
            } catch {
                completion(nil)
            }
        }

        task.resume()
    }
}

struct Country: Decodable {
    let name: Name?
}

struct Name: Decodable {
    let common: String?
}
