//
//  App.swift
//  AppStore
//
//  Created by Evandro Rodrigo Minamoto 
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
