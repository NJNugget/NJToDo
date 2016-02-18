//
//  AboutViewController.swift
//  NJToDo
//
//  Created by Nugget Jiang on 16/2/17.
//  Copyright © 2016年 Nugget Jiang. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About me"
        profileImage.backgroundColor = UIColor.blackColor()
        profileImage.layer.cornerRadius = 60.0
        profileImage.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
