//
//  Service.swift
//  MeteorApp
//
//  Created by Nikhil Gharge on 13/10/21.
//

import Foundation
import Alamofire

class Service{
    
    fileprivate var baseURL = "https://data.nasa.gov/resource/"
    
    static let instance = Service(baseURL:"https://data.nasa.gov/resource/")
    typealias MeteorsListCallBack =  ([Meteor]?,_ meteorNameArr: [String],_ meteorYearArr: [String], _ status:Bool, _ message:String) -> Void
    var coordinatesArray = [Any]()
    var meteorName = [String]()
    var meteorYear = [String]()
    
    private init(baseURL:String) {
        self.baseURL = baseURL
    }
    
    func execute(completionHandler: @escaping MeteorsListCallBack){
        var endPoint = "y77d-th95.json"
        print(baseURL)
        AF.request(baseURL + endPoint, method:.get, parameters:nil, encoding:URLEncoding.default, headers:nil, interceptor:nil, requestModifier:nil).response { (responseData) in
            //
            print("Yes we got the response \(responseData)")
            guard let data = responseData.data else {
                //self.callBack?(nil, false, "")
                completionHandler(nil, [] , [], false, "")
                return}
            do{
                let meteorsArr = try JSONDecoder().decode([Meteor].self, from:data)
                let coordinates = meteorsArr.compactMap{ $0.geolocation?.coordinates}
                self.coordinatesArray.append(contentsOf: coordinates as [Any])
                print("Meteor Objects == \(meteorsArr)")
                for val in meteorsArr{
                    let meteorYear = val.year ?? "0000"
                    let year = String(meteorYear.prefix(4))
                    if Int(year)! >= 1900{
                        self.meteorName.append(val.name ?? "Not Available")
                        self.meteorYear.append(year ?? "Not Available")
                    }
                }
                
                // Filter Data
                
                //self.callBack?(meteorsArr, true, "nil")
                completionHandler(meteorsArr,self.meteorName, self.meteorYear, true,"")
            }catch{
                print("Error decoding == \(error)")
                //self.callBack?(nil, false, error.localizedDescription)
                completionHandler(nil, [], [], false, error.localizedDescription)
            }
            
        }

    }
  
}

extension Service{
    // List Meteor List Implementation
    
    //MARK: getMeteorsList
    func getMeteorListData(completionHandler: @escaping MeteorsListCallBack){

        execute{ (meteorsArr,meteorName, meteorYear,status,message) in
            //
            completionHandler(meteorsArr,meteorName, meteorYear,status, message)
        }
    }
}
        
