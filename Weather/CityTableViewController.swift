//
//  CityTableViewController.swift
//  Weather
//
//  Created by Алексей on 20.06.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    // MARK: - VAriables
    var file = FilePlist()
    let loader = LoadData()
    
    var cities = [String]()
    
    static var firstStart = true
    static var update = false
    
    @IBAction func goBack(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        cities = loadViewData()
        print("city = \(cities)")
    }
    
    func loadViewData() -> [String] {
        if file.flag == nil {
            print("loaded...")
            for city in cities {
                loader.loadJSONAlamofire(cityName: city)
            }
        }
        return loader.LoadDB()
    }
    
    func addNewCity(city: String){
        if !cities.contains(city){
            loader.loadJSONAlamofire(cityName: city)
            cities.append(city)
            tableView.reloadData()
            print("count city \(cities)")
        }
    }
    
    // MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row]
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            loader.cityRemoveDB(cities[indexPath.row])
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let value = cities.remove(at: fromIndexPath.row)
        cities.insert(value, at: to.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "detailCity", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailCity"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let vc = segue.destination as! CityCollectionViewController
                vc.city = cities[indexPath.row]
            }
        }
    }
    
    
}
