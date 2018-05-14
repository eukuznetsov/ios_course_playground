//
//  CurrentWeather.swift
//  Weather
//
//  Created by Evgeney Kuznetsov on 14/05/2018.
//  Copyright © 2018 Evgeney Kuznetsov. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
    let location: Location
    let current: Current
    
}

struct Location:Decodable {
    let name: String
    let country: String
}

struct Current:Decodable {
    let temperature: Double
    
    enum CodingKeys:String, CodingKey {
        case temperature = "temp_c"
    }
}

struct ErrorResponse:Decodable {
    let error: ErrorObject
}

struct ErrorObject: Decodable {
    let message: String
}
