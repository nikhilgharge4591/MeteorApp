//
//  ViewController.swift
//  MeteorApp
//
//  Created by Nikhil Gharge on 13/10/21.
//

import UIKit
import Foundation

class MeteorListVC: UIViewController {
    
    // Initialize the varibales and outlets
    @IBOutlet weak var MeteorListTableView: UITableView!
    private var repository = MeteorRepository()
    var meteorList = [Meteor]()
    private var selectedMeteor: Meteor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMeteors(filter: nil)
    }
    
    // Here get the new filter and call the getMeteors(filter)
    // method with the new filters
    // func calledOnSegmentChange or filterValueChnaged
    // {
    //    getMeteors(filter: newFilters)
    // }
    
    
    func getMeteors(filter: Int?) {
        repository.getMeteors(filter: filter) { result in
            switch result {
            case.success(let meteors):
                self.meteorList = meteors
                DispatchQueue.main.async {
                    self.MeteorListTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showMapSegue") {
            if let vc: MapViewController = segue.destination as? MapViewController {
                vc.meteor = self.selectedMeteor
            }
        }
    }
    
}


extension MeteorListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"MeteorCell", for:indexPath)
        
        let meteorObjData = meteorList[indexPath.row]
        
        let formatter = DateFormatter.toStringFormatter
        let meteorYearData = meteorList[indexPath.row].year ?? Date()
        
        cell.textLabel?.text = meteorObjData.name
        cell.detailTextLabel?.text = formatter.string(from: meteorYearData)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedMeteor = self.meteorList[indexPath.row]
        self.performSegue(withIdentifier: "showMapSegue", sender: self)
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier:"MeteorCell", for:indexPath)
    //        let meteorObjData = viewModel[indexPath.row]
    //        cell.textLabel?.text = viewModel.name
    //        cell.detailTextLabel?.text = viewModel.subtitle
    //        return cell
    //    }
}



