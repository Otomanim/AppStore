//
//  Decodable+Parse.swift
//  AppStore
//
//  Created by Evandro Rodrigo Minamoto on 21/11/23.
//

import UIKit

extension Decodable {
    
    static func parse(jsonFile: String) -> Self {
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Error to find json file \(jsonFile)")
        }
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch {
            fatalError("Error to decode json: \(error.localizedDescription)")
        }
    }
}
