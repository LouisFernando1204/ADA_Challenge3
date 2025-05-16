//
//  Profile.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 12/05/25.
//

import Foundation

struct Profile : Codable {
    var name: String
    var role: String
    var age: Int
    var hometown: String
    var bio: String
    var contacts: [Contact]
    var image: String
}
