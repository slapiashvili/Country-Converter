//
//  File.swift
//  CountryConverter
//
//  Created by Salome Lapiashvili on 06.01.24.
//

import Foundation

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
