//
//  Weather.swift
//  WeatherApp
//
//  Created by Ольга Ерохина on 7/14/21.
//

import Foundation
import RealmSwift

class Weather: Object, Decodable {
    @objc dynamic var cod = 0.0
    @objc dynamic var cityName = ""
    @objc dynamic var weatherTemperature: WeatherTemperature!
    
    private enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case cityName = "name"
        case weatherTemperature = "main"
    }
    
    override required init() {
        super.init()
    }
        
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cod = try container.decode(Double.self, forKey: .cod)
        cityName = try container.decode(String.self, forKey: .cityName)
        
        weatherTemperature = try container.decode(WeatherTemperature.self, forKey: .weatherTemperature)
    }

}
