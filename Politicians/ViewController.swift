//
//  ViewController.swift
//  Politicians
//
//  Created by GUOQIANG PAN on 7/13/16.
//  Copyright © 2016 GUOQIANG PAN. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var politicianTable: UITableView!
    var politicianList = Array<Dictionary<String, AnyObject>>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://fp-politicians.herokuapp.com/api/politician"
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, AnyObject>{
//                print("\(json)")
                if let politicians = json["politicians"] as? Array<Dictionary<String, AnyObject>>{
                    print("\(politicians)")
                   
                    for politician in politicians {
                        self.politicianList.append(politician)
                    }
                   
                    self.politicianTable.reloadData()
                }
            }
            
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.politicianList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                let politician = self.politicianList[indexPath.row]
        
                let cellId = "cellId"
                if let cell = tableView.dequeueReusableCellWithIdentifier(cellId){
                    cell.textLabel?.text = politician["firstName"] as? String   //"\(indexPath.row)"
                    return cell
                }
        
                let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
                cell.textLabel?.text = politician["firstName"] as? String   //"\(indexPath.row)"
                return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

