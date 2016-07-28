//
//  FilterViewController.swift
//  Natura
//
//  Created by Gerlandio on 7/28/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var listOfPlaces = PlacesTypesEnum.listOfObjects()
    var filteredPlaces = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredPlaces = listOfPlaces
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPlaces.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        
        cell?.textLabel?.text = filteredPlaces[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let index = listOfPlaces.indexOf(filteredPlaces[indexPath.row] ?? "") {
            if let _ = PlacesTypesEnum(rawValue: index+1) {
                NotificationBase.FilteredPlaces.notifyWithObject(index+1)
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}

extension FilterViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        filteredPlaces = listOfPlaces.filter({ $0.containsString(searchBar.text ?? "")})
        tableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredPlaces = listOfPlaces
        } else {
            filteredPlaces = listOfPlaces.filter({ $0.containsString(searchText)})
        }
        
        tableView.reloadData()
    }
}

extension FilterViewController {
    
    @IBAction func dismissFilter(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
