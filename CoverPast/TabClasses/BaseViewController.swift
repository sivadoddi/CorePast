//
//  BaseViewController.swift
//  CoverPast
//
//  Created by SivaSankar on 08/10/14.
//  Copyright (c) 2014 Paradim Creatives. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController, xmlResultDelegate{

    var xmlDict = Dictionary<String, String>()
    var xmlListArray:NSMutableArray = []
    
    @IBOutlet var itemsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var urlString = NSBundle.mainBundle().pathForResource("xml_List", ofType: "xml")
        LoadXMLList.sharedInstance.xmlDelegate = self
        LoadXMLList.sharedInstance.loadXmlData(urlString!)
        
    }
    func xmlResultSuccessWithArray(itemsArray: NSMutableArray) {
         println("list of items array \(itemsArray)")
        xmlListArray = itemsArray
        itemsTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension BaseViewController{
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if xmlListArray.count > 0{
            return xmlListArray.count
        }
        return 0
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let row = indexPath.row
        var cell = tableView?.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
       
        if xmlListArray.count>0{
            let dict:AnyObject = xmlListArray[row]
            
            cell.textLabel?.text = dict["name"] as? String
            cell.detailTextLabel?.text = dict["designation"] as? String
        }
        return cell
        
        
    }
}

