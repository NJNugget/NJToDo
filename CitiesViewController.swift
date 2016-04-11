//
//  CitiesViewController.swift
//  NJToDo
//
//  Created by Nugget Jiang on 16/4/11.
//  Copyright © 2016年 Nugget Jiang. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configMenuView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func configMenuView(){
        NJDropMenuSetting.columnTitles = ["国家","城市","景点"]
        NJDropMenuSetting.rowTitles =  [
            ["日本","美国","中国","德国","法国"],
            ["热销的咯","推荐","进口保证","美国"],
            ["申通","圆通速递","韵达","德邦"]
        ]
        NJDropMenuSetting.maxShowCellNumber = 4
        NJDropMenuSetting.columnEqualWidth = true
        NJDropMenuSetting.cellTextLabelSelectColoror = UIColor.redColor()
        NJDropMenuSetting.showDuration = 0.2
        let menuView = NJDropMenuView(frame:CGRectMake(0,0,UIScreenWidth,44))
        menuView.delegate = self
        view.addSubview(menuView)
    }

}

extension CitiesViewController:NJDropMenuDelegate{
    func dropMenuClick(column: Int, row: Int) {
        debugPrint("点击了第\(column)列第\(row)行")
    }
}
