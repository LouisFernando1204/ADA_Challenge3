//
//  Strength.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 12/05/25.
//

import Foundation

struct Strength : Identifiable, Codable {
    var id = UUID()
    var name: String
    var recommendations: [Colleague]
    var icon: String
}
