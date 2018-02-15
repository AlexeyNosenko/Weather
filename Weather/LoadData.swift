//
//  LoadData.swift
//  Weather
//
//  Created by Админ on 19.06.17.
//  Copyright © 2017 neva-software. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON

class LoadData {
    let realm = try! Realm()
    
    func createURLWithComponents(cityName name: String) -> URL? {
        let param = ParamURL.init(q: name, units: "metric")
        let urlComponents = NSURLComponents()
        
        urlComponents.scheme = "http"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        
        urlComponents.queryItems = [URLQueryItem.init(name: "q", value: param.q),
                                    URLQueryItem.init(name: "units", value: param.units),
                                    URLQueryItem.init(name: "appid", value: param.appid)]
        return urlComponents.url
    }
    
    func loadJSONURlSession(cityName name: String){
        let url = createURLWithComponents(cityName: name)
        if let url = url {
            var request = URLRequest.init(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
            let task = URLSession.shared.dataTask(with: request, completionHandler: {[weak self] (data, _, error) in
                if error == nil,
                    let data = data{
                    let value = String.init(data: data, encoding: String.Encoding.utf8)
                    self?.save(jsonValue: value as Any)
                } else {
                    print(error.debugDescription)
                }
            })
            task.resume()
        }
    }
    
    func save(jsonValue: Any){
        let json = JSON(jsonValue)
        let city = City()
        let file = FilePlist()
        city.cityName = json["city"]["name"].stringValue
        
        for (_, subJson):(String, JSON) in json["list"] {
            let ot = Temp()
            ot.t = subJson["main"]["temp"].doubleValue
            //  print(ot.t)
            ot.tTime = subJson["dt_txt"].stringValue
            ot.tIcon = subJson["weather"][0]["icon"].stringValue
            city.templst.append(ot)
            
        }
        try! self.realm.write {
            self.realm.add(city)
            print("add")
        }
        file.flag = true
    }
    
    func loadJSONAlamofire(cityName name: String){
        let paramUrl = ParamURL.init(q: name, units: "metric")
        let param = ["q": paramUrl.q, "units": paramUrl.units, "appid": paramUrl.appid]
        
        print("LoadJSONAlamofire")
        Alamofire.request(paramUrl.url, method: .get, parameters: param).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    self.save(jsonValue: value)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func LoadDB() -> [String] {
        var cities: [String] = []
        let lastData = self.realm.objects(City.self)
        for  i  in 0..<lastData.count {
            cities.append(lastData[i].cityName)
        }
        return cities
    }
    
    private func getCity(_ city: String) -> Results<City>{
        return self.realm.objects(City.self).filter("cityName BEGINSWITH %@", city)
    }
    
    func cityLoadDB(_ city: String) -> Results<City> {
        return getCity(city)
    }
    
    func cityRemoveDB(_ city: String) {
        try! realm.write {
            realm.delete(getCity(city))
        }
    }
}

struct ParamURL{
    var q: String
    var units: String
    let appid = "cc43de317c7b45042d6dd7d09ee12d74"
    let url = "http://api.openweathermap.org/data/2.5/forecast"
}
