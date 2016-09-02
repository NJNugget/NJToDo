//
//  ProfileViewController.swift
//  NJToDo
//
//  Created by Nugget Jiang on 16/1/21.
//  Copyright © 2016年 Nugget Jiang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    private func setupNavigationBar() {
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.translucent = true
        navigationController!.navigationBar.titleTextAttributes = [
            //            NSFontAttributeName: UIFont(name: "GothamPro", size: 20)!,
            NSForegroundColorAttributeName: UIColor.blackColor()
        ]
    }
    private var profileDetailViewController: ProfileDetailViewController!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let settings = segue.destinationViewController as? ProfileDetailViewController {
            profileDetailViewController = settings
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
