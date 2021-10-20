//
//  DataModel.swift
//  MeteorApp
//
//  Created by Nikhil Gharge on 13/10/21.
//

import Foundation

struct Meteor: Decodable {
    var name: String?
    var weight: String?
    var year:String?
    var geolocation: geoLocation?
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case weight = "mass"
        case year = "year"
        case geolocation = "geolocation"
    }
}

struct geoLocation: Decodable{
    var type: String?
    var coordinates: [Double]?
    
    enum CodingKeys: String, CodingKey{
        case type = "type"
        case coordinates = "coordinates"
    }
    
}
