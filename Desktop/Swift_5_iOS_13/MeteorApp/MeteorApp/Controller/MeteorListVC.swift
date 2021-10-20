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
    var meteorList = [Meteor]()
    var metorNameArr = [String]()
    var meteorYearArr = [String]()
    typealias MeteorsListCallBack =  ([Meteor]?, _ status:Bool, _ message:String) -> Void
    var getMeteorListData: ((MeteorsListCallBack)-> Void)?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callAPI()
    }
    
    func callAPI(){
        
        //Property Injection
            
        Service.instance.getMeteorListData { (meteorArr,meteorName, meteorYear,status,message) in
                if status{
                    guard let meteorArr = meteorArr else{return}
                    self.meteorList = meteorArr
                    self.metorNameArr = meteorName
                    self.meteorYearArr = meteorYear
                    self.MeteorListTableView.reloadData()
                }
            }
        }
   }


extension MeteorListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"MeteorCell", for:indexPath)
        
        let meteorObjData = meteorList[indexPath.row]
        let meteorYearData = meteorYearArr[indexPath.row]
        cell.textLabel?.text = meteorObjData.name
        cell.detailTextLabel?.text = meteorYearData
        return cell
        
    }
    
    
    
    
}



