//
//  City.swift
//  Weather
//
//  Created by Алексей on 28.06.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import Foundation
import RealmSwift

class City: Object {
  dynamic var cityName: String = ""
  var templst = List<Temp>()
  
  override static func primaryKey() -> String? {
    return "cityName"
  }
}
