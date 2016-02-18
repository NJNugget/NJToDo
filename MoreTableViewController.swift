//
//  MoreTableViewController.swift
//  NJToDo
//
//  Created by Nugget Jiang on 16/2/16.
//  Copyright © 2016年 Nugget Jiang. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {

    private enum MoreSection: Int {
        case EventDetails, Acknowledgements
    }
    
    private enum EventDetailsRow: Int {
        case About, Venue, CodeOfConduct
    }
    
    private enum AcknowledgementsRow: Int {
        case Organizers, Libraries
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "More"
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch MoreSection(rawValue: section)! {
        case .EventDetails:
            return 3
        case .Acknowledgements:
            return 2
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath)
        switch MoreSection(rawValue: indexPath.section)! {
        case .EventDetails:
            switch EventDetailsRow(rawValue: indexPath.row)! {
            case .About:
                cell.textLabel?.text = "About"
            case .Venue:
                cell.textLabel?.text = "Venue"
            case .CodeOfConduct:
                cell.textLabel?.text = "Code of Conduct"
            }
        case .Acknowledgements:
            switch AcknowledgementsRow(rawValue: indexPath.row)! {
            case .Organizers:
                cell.textLabel?.text = "Organizers"
            case .Libraries:
                cell.textLabel?.text = "Acknowledgements"
            }
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch MoreSection(rawValue: indexPath.section)! {
        case .EventDetails:
            switch EventDetailsRow(rawValue: indexPath.row)! {
            case .Venue:
                showVenue()
            case .About:
                showAbout()
            default:
                print("123")
            }
        default:
            print("123")
        }

    }


}
private extension MoreTableViewController {
    
    func showVenue() {
        let webViewController = WebViewController()
        let instructionsURL = "http://www.baidu.com"
        webViewController.url = NSURL(string: instructionsURL)!
        webViewController.displayTitle = "Venue"
        navigationController?.pushViewController(webViewController, animated: true)
    }
    func showAbout(){
        self.performSegueWithIdentifier("showAbout", sender: self)
    }
    
}
