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
    
    var citys_list = [String]()
    
    static var firstStart = true
    static var update = false
    
    @IBAction func goBack(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        citys_list = loadViewData()
        print("city = \(citys_list)")
    }
    
    func loadViewData() -> [String] {
        if file.flag == nil {
            print("loaded...")
            for city in citys_list {
                loader.LoadJSON(city)
            }
        }
        return loader.LoadDB()
    }
    
    func addNewCity(city: String){
        if !citys_list.contains(city){
            loader.LoadJSON(city)
            citys_list.append(city)
            tableView.reloadData()
            print("count city \(citys_list)")
        }
    }
    
    // MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citys_list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath)
        cell.textLabel?.text = citys_list[indexPath.row]
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            loader.CityRemoveDB(citys_list[indexPath.row])
            citys_list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let value = citys_list.remove(at: fromIndexPath.row)
        citys_list.insert(value, at: to.row)
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
                vc.city = citys_list[indexPath.row]
            }
        }
    }
    
    
}
