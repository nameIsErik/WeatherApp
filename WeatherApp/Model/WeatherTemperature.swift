//
//  WeatherTemperature.swift
//  WeatherApp
//
//  Created by Ольга Ерохина on 7/14/21.
//

import Foundation
import RealmSwift

class WeatherTemperature: Object, Decodable {
    @objc dynamic var temp = 0.0
    @objc dynamic var temp_min = 0.0
    @objc dynamic var temp_max = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
    }

    override required init() {
        super.init()
    }
        
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        temp = try container.decode(Double.self, forKey: .temp)
        temp_min = try container.decode(Double.self, forKey: .temp_min)
        temp_max = try container.decode(Double.self, forKey: .temp_max)
    }
}
