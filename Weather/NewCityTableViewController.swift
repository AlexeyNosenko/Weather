//
//  NewCityTableViewController.swift
//  Weather
//
//  Created by Алексей on 27.06.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

class NewCityTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var cityName: UITextField!
    
    // MARK: - Variables
    let segueName = "goBack"
    
    // MARK: - Action
    @IBAction func click(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: segueName, sender: nil)
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueName,
            let vc = segue.destination as? CityTableViewController,
            let name = cityName.text{
            vc.addNewCity(city: name.firstUpperCase)
        }
    }
}

extension String{
    var firstUpperCase: String{
        return prefix(1).uppercased() + dropFirst().lowercased()
    }
}
