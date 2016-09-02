//
//  CitiesViewController.swift
//  NJToDo
//
//  Created by Nugget Jiang on 16/4/11.
//  Copyright © 2016年 Nugget Jiang. All rights reserved.
//

import UIKit
import SwiftyJSON

class CitiesViewController: UIViewController {

    @IBOutlet weak var Cities: UITableView!
    var dict = NSMutableDictionary(capacity: 0)
    var titleDict:[String] = []
    var comicDict:[String] = []
    var comicIdDict:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func configMenuView(){
        NJDropMenuSetting.columnTitles = ["海贼标题","话数","没用"]
        NJDropMenuSetting.rowTitles =  [
            self.titleDict,
            self.comicDict,
            ["申通","圆通速递","韵达","德邦"]
        ]
        NJDropMenuSetting.maxShowCellNumber = 10
        NJDropMenuSetting.columnEqualWidth = true
        NJDropMenuSetting.cellTextLabelSelectColoror = UIColor.redColor()
        NJDropMenuSetting.showDuration = 0.2
        let menuView = NJDropMenuView(frame:CGRectMake(0,0,UIScreenWidth,44))
        menuView.delegate = self
        view.addSubview(menuView)
    }
    func loadCountries(){
        NJLoadingView.sharedInstace.showOverlayView(self.view)
//        NJRequest.sharedInstace.getCountryList({ (data) in
//            self.dict = try!NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSMutableDictionary
//            if(self.dict.objectForKey("data") != nil){
//                let json = JSON(self.dict.objectForKey("data")!)
//                for key in 0...json["hot"].count{
//                    self.contriesDict.append(json["hot"][key]["cn_name"].stringValue)
//                }
//                
//            }
//            
//            }) { (error) in
//                debugPrint("error")
//        }
        NJRequest.sharedInstace.getChapterList(0, id: 2, SuccessBlock: { (data) in
            self.dict = try!NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSMutableDictionary
            if(self.dict.objectForKey("Return") != nil){
                let json = JSON(self.dict.objectForKey("Return")!)
                for key in 0...json["List"].count{
                    self.titleDict.append(json["List"][key]["Title"].stringValue)
                    self.comicDict.append(json["List"][key]["Sort"].stringValue)
                    self.comicIdDict.append(json["List"][key]["Id"].stringValue)
                }
                print(json)
                self.configMenuView()
            }
            NJLoadingView.sharedInstace.hideOverlayView()
            }) { (error) in
                debugPrint("error")
        }
    }

}

extension CitiesViewController:NJDropMenuDelegate{
    func dropMenuClick(column: Int, row: Int) {
        debugPrint("点击了第\(column)列第\(row)行")
        showVenue(comicIdDict[row])
    }
    func showVenue(comicId:String) {
        let webViewController = WebViewController()
        let instructionsURL = "http://www.ishuhui.net/ComicBooks/ReadComicBooksToIsoV1/\(comicId).html"
        webViewController.url = NSURL(string: instructionsURL)!
        webViewController.displayTitle = "海贼王最新漫画"
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

extension CitiesViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CitiesCardCell()
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 153
    }
}
