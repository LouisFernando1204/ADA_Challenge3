//
//  Project.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 12/05/25.
//

import Foundation

struct Project : Codable {
    var title: String
    var projectLocation: String
    var year: String
    var description: String
    var role: String
    var thumbnail: String
    var projectVideoId: String
    var images: [String]
}
