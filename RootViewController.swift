//
//  RootViewController.swift
//  NJToDo
//
//  Created by Nugget Jiang on 15/12/21.
//  Copyright © 2015年 Nugget Jiang. All rights reserved.
//

import UIKit

enum TabBarButton {
    case Main
    case Mine
    case Custom 
}


class RootViewController: UIViewController {
    
    var footView = UIView()
    let headView = UIView()
    let currentViewController = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        initFootView()
        // Do any additional setup after loading the view.
    }

    func initFootView(){
        if(iOS7){
            footView = UIView(frame: CGRect(x: 0, y: UIScreenWidth-TabBarHeight - StatusBarHeight + 20, width: UIScreenWidth, height: TabBarHeight))
        }else{
            footView = UIView(frame: CGRect(x: 0, y: (UIScreenWidth-20) - TabBarHeight  , width: UIScreenWidth, height: TabBarHeight))
        }
        self.view.addSubview(footView)
        initButtonInFootView()
    }
    func initButtonInFootView(){
        let buttonW:CGFloat = UIScreenWidth/4
        let buttonH:CGFloat = TabBarHeight
        let space:CGFloat = ((buttonW - (320/4)) / 2)
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: UIScreenWidth, height: 0.5))
        topLine.backgroundColor = RGBA(31,g: 32,b: 35,a: 24)
        footView.addSubview(topLine)
        
        let button = UIButton(type: UIButtonType.Custom)
        button.frame = CGRect(x: 0, y: 0, width: buttonW, height: buttonH)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
        button.setImage(UIImage(named: "btn_like_normal"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "btn_like_pressed"), forState: UIControlState.Highlighted)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
