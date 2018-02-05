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
    
    func LoadJSON(_ city: String){
        let Online_w = City()
        let file = FilePlist()
        let url = "http://api.openweathermap.org/data/2.5/forecast"
        let param = ["q": city, "units": "metric", "appid": "cc43de317c7b45042d6dd7d09ee12d74"]
        
        print("LoadJSON")
        Alamofire.request(url, method: .get, parameters: param).validate().responseJSON { response in
            print(response.result)
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    Online_w.City_name = json["city"]["name"].stringValue
                    //print(json["city"]["name"].stringValue)
                    //print("JSON: \(json)")
                    
                    for (_,subJson):(String, JSON) in json["list"] {
                        let ot = Temp()
                        ot.t = subJson["main"]["temp"].doubleValue
                        //  print(ot.t)
                        ot.t_time = subJson["dt_txt"].stringValue
                        ot.t_icon = subJson["weather"][0]["icon"].stringValue
                        Online_w.templst.append(ot)
                        
                    }
                    try! self.realm.write {
                        self.realm.add(Online_w)
                        print("add")
                    }
                    file.flag = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func LoadDB() -> [String] {
        var City_list: [String] = []
        let last_data = self.realm.objects(City.self)
        for  i  in 0..<last_data.count {
            City_list.append(last_data[i].City_name)
        }
        return City_list
    }
    
    private func getCity(_ city: String) -> Results<City>{
        return self.realm.objects(City.self).filter("City_name BEGINSWITH %@", city)
    }
    
    func CityLoadDB(_ city: String) -> Results<City> {
        return getCity(city)
    }
    
    func CityRemoveDB(_ city: String) {
        try! realm.write {
            realm.delete(getCity(city))
        }
    }
}
