//
//  MeteorRepository.swift
//  MeteorApp
//
//  Created by Ishmeet Singh Sethi on 2021-10-20.
//

import Foundation


class MeteorRepository {
    private var baseUrl = "https://data.nasa.gov/resource/"
    
    func getMeteors(filter: Int?, completionHandler: @escaping (Result<[Meteor], MeteorFetchError>) -> Void) {
        let endPoint = baseUrl + "y77d-th95.json"
        guard let url = URL(string: endPoint) else { return }
        let request = URLRequest(url: url)
        
        URLSession(configuration: .default).dataTask(with: request) { data, response, error in
            if (error != nil) {
                completionHandler(.failure(.unknown))
                return;
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                var meteorsArr = try decoder.decode([Meteor].self, from:data)
                
                // Filter data here
                meteorsArr = meteorsArr.filter { $0.geolocation != nil && $0.geolocation?.coordinates != nil }
                
                completionHandler(.success(meteorsArr))
            }
            catch let error {
                print(error)
                completionHandler(.failure(.parseError))
            }
            
        }
        .resume()
    }
}

enum MeteorFetchError: Error {
    case invalidData
    case unknown
    case parseError
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let toStringFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    
}
