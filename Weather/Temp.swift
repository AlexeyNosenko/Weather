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
    dynamic var t_time: String = ""
    dynamic var t_icon: String = ""
}
