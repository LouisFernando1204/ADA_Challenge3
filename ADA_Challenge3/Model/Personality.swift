//
//  Personality.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 12/05/25.
//

import Foundation

struct Personality : Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var reason: String
    var image: String
}
