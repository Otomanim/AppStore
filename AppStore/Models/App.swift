//
//  App.swift
//  AppStore
//
//  Created by Evandro Rodrigo Minamoto on 21/11/23.
//

import Foundation

struct App: Decodable, Hashable {
    let id: UUID = UUID()
    let tagline: String
    let name: String
    let subheading: String
    
    enum CodingKeys: String, CodingKey {
        case tagline
        case name
        case subheading
    }
}
