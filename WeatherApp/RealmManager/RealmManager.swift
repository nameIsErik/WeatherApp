//
//  RealmManager.swift
//  WeatherApp
//
//  Created by Ольга Ерохина on 7/14/21.
//

import Foundation
import RealmSwift

class RealmManager {
    
    let realm = RealmManager.realmInstance()
    lazy var listOfWeather: Results<Weather> = { realm.objects(Weather.self) }()
    var notificationToken: NotificationToken?
    
    static func realmInstance() -> Realm {
        do {
            let newRealm = try Realm()
            return newRealm
        } catch {
            // code to handle error
            print(error)
            fatalError("Unable to create an instance of Realm")
        }
    }
    
    func toRealm(weather: Weather) {
        
        for localWeather in listOfWeather {
            if localWeather.cityName == weather.cityName {
                return
            }
        }
        do {
            try self.realm.write() {
                self.realm.add(weather)
            }
        } catch {
            print(error)
        }
        
        listOfWeather = realm.objects(Weather.self)
    }
    
    func getObjects() -> [Weather] {
        
        var objects = [Weather]()
        let weatherCollection = try? realm.objects(Weather.self)
        
        if let weatherCollection = weatherCollection {
            for weather in weatherCollection {
                objects.append(weather)
            }
        }
        return objects
    }
}
