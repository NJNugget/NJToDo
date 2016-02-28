//
//  AboutViewController.swift
//  NJToDo
//
//  Created by Nugget Jiang on 16/2/17.
//  Copyright © 2016年 Nugget Jiang. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var profileTableView: UITableView!
    @IBOutlet var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About me"
        profileImage.backgroundColor = UIColor.blackColor()
        profileImage.layer.cornerRadius = 60.0
        profileImage.layer.masksToBounds = true
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AboutCell", forIndexPath: indexPath)
        cell.textLabel?.text = "1233"
        return cell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let urlString = "乗換案内"
        let start = "-東京"
        let end = "-大阪"
        let startJis = start.stringByAddingPercentEscapesUsingEncoding(NSShiftJISStringEncoding)
        
        let endJis = end.stringByAddingPercentEscapesUsingEncoding(NSShiftJISStringEncoding)
        NJLoadingView.sharedInstace.showOverlayView(self.view)
        NJRequest.sharedInstace.getRailPath(startJis!, end: endJis!, SuccessBlock: { (data) -> Void in
            let str = String(data: data, encoding: NSShiftJISStringEncoding)
//            print(str)
            let datadict = str?.componentsSeparatedByString("\n\n")
            for(var i=0;i<datadict?.count;i++){
                print("第\(i)行:\(datadict![i])")
                
            }
            NJLoadingView.sharedInstace.hideOverlayView()
            }) { (error) -> Void in
                print("error")
        }
    }
}
