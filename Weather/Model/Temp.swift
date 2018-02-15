//
//  Temp.swift
//  Weather
//
//  Created by Админ on 19.06.17.
//  Copyright © 2017 neva-software. All rights reserved.
//

import Foundation
import RealmSwift

class Temp: Object {
    dynamic var t: Double = 0
    dynamic var tTime: String = ""
    dynamic var tIcon: String = ""
}
