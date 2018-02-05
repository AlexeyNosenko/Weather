//
//  FilePList.swift
//  Weather
//
//  Created by Админ on 19.06.17.
//  Copyright © 2017 neva-software. All rights reserved.
//

import Foundation

class FilePlist {
    var flag: Any? {
        get{
            return UserDefaults.standard.object(forKey: "flag") as Any?
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "flag")
            UserDefaults.standard.synchronize()
        }
    }
}
