//
//  ProfileDetailViewController.swift
//  NJToDo
//
//  Created by Nugget Jiang on 16/1/22.
//  Copyright © 2016年 Nugget Jiang. All rights reserved.
//

import UIKit

private let tableViewOffset: CGFloat = UIScreen.mainScreen().bounds.height < 600 ? 215 : 225
private let beforeAppearOffset: CGFloat = 400

class ProfileDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var backgroundWidthConstraint: NSLayoutConstraint!
    @IBOutlet var backgroundHeightConstraint: NSLayoutConstraint!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var bgHolder: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.bounds = CGRect(x: 0, y: 0, width: UIScreenWidth, height: UIScreenHeight)
        self.view.addSubview(tableView)
        tableView.backgroundView = bgHolder
        tableView.dataSource = self
        tableView.delegate = self
    // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: tableViewOffset, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -beforeAppearOffset)
        
        UIView.animateWithDuration(0.5, animations: {
            self.tableView.contentOffset = CGPoint(x: 0, y: -tableViewOffset)
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        backgroundHeightConstraint.constant = max(navigationController!.navigationBar.bounds.height + scrollView.contentInset.top - scrollView.contentOffset.y, 0)
        print("\(navigationController!.navigationBar.bounds.height + scrollView.contentInset.top)，\(scrollView.contentOffset.y)")
        backgroundWidthConstraint.constant = navigationController!.navigationBar.bounds.height - scrollView.contentInset.top - scrollView.contentOffset.y * 0.8
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
