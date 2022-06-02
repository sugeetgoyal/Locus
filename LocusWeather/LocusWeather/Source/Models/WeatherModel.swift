//
//  WeatherModel.swift
//  LocusWeather
//
//  Created by Sugeet Goyal on 16/05/22.
//

import Foundation

struct WeatherModel: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ListItem]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case cod, message, cnt, list, city
    }
}

struct ListItem: Codable {
    let dt: Double
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dt_txt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys, dt_txt
    }
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, feels_like, temp_min, temp_max, pressure, sea_level, grnd_level, humidity, temp_kf
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main, description,icon
    }
}

struct Clouds: Codable {
    let all: Int
    
    enum CodingKeys: String, CodingKey {
        case all
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
    
    enum CodingKeys: String, CodingKey {
        case speed, deg, gust
    }
}

struct Sys: Codable {
    let pod: String
    
    enum CodingKeys: String, CodingKey {
        case pod
    }
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let timezone: Int
    let sunrise: Int
    let sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, coord, country, timezone, sunrise, sunset
    }
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat, lon
    }
}
