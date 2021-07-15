//
//  WeatherViewCell.swift
//  WeatherApp
//
//  Created by Ольга Ерохина on 7/15/21.
//

import UIKit

class WeatherViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: WeatherViewCell.self)
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temeratureLabel: UILabel!
    
}
