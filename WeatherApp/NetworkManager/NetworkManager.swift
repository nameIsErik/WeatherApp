//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Ольга Ерохина on 7/14/21.
//

import Foundation

class NetworkManager {
    private init() {}
    
    static let shared: NetworkManager = NetworkManager()
    
    func getWeather(city: String, result: @escaping((Weather?) -> ())) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "appid", value: "91e36935bc6caebbb60f705c6fad3652")]
        
        guard let unwrappedURl = urlComponents.url else { return }

        var request = URLRequest(url: unwrappedURl)
        request.httpMethod = "GET"
        
        let task = URLSession(configuration: .default)
        task.dataTask(with: request) { (data, response, error) in
            if error != nil {
                //code for handling error
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                //code for handling error
                return
            }
            
            let decoder = JSONDecoder()
            var decoderOfferModel: Weather?
            
            if data != nil {
                decoderOfferModel = try? decoder.decode(Weather.self, from: data!)
                result(decoderOfferModel)
            } else {
                //code for handling error
            }
        }.resume()
    }
}
