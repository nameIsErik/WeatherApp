//
//  WeatherCollection.swift
//  WeatherApp
//
//  Created by Ольга Ерохина on 7/15/21.
//

import Foundation


struct WeatherCollection: Hashable {
    let name: String
    var weatherItems: [Weather] = []
    var identifier = UUID().uuidString
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: WeatherCollection, rhs: WeatherCollection) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init(name: String, weatherItems: [Weather]) {
        self.name = name
        self.weatherItems = weatherItems
    }
}
