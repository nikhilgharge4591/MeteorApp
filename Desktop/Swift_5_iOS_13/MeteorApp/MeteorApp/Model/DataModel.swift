//
//  DataModel.swift
//  MeteorApp
//
//  Created by Nikhil Gharge on 13/10/21.
//

import Foundation

struct Meteor: Codable {
    var name: String
//    var weight: Int?
    var year: Date?
    var geolocation: GeoLocation?
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
//        case weight = "mass"
        case year = "year"
        case geolocation = "geolocation"
    }
}

struct GeoLocation: Codable {
    var type: String
    var coordinates: [Double]
    
    enum CodingKeys: String, CodingKey{
        case type = "type"
        case coordinates = "coordinates"
    }
}


struct Filter {
    var year: Int
    var size: Int
}
