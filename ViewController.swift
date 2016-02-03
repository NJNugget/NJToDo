//
//  ViewController.swift
//  NJToDo
//
//  Created by Nugget Jiang on 15/12/11.
//  Copyright © 2015年 Nugget Jiang. All rights reserved.
//

import UIKit
import Koloda
import SwiftyJSON
import Kingfisher
import SnapKit

private var numberOfCards: UInt = 0

class ViewController: UIViewController,UIAlertViewDelegate {
    @IBOutlet var kolodaView: KolodaView!
    var loadDiscountsRequestPage:NSInteger = 1
    var dict = NSMutableDictionary(capacity: 0)
    var titleDict:[String] = []
    var imageDict:[String] = []
    var priceDict:[String] = []
    var iconDict:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.loadCards(loadDiscountsRequestPage)
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.Left)
    }
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.Right)
        let title = "收藏成功"
        let message = "您已收藏成功"
//        let alert = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: "知道了")
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.viewDidLoad()
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }

    func loadCards(listPage:NSInteger){
//        let request:NJRequest = NJRequest()
        NJLoadingView.sharedInstace.showOverlayView(self.view)
        NJRequest.sharedInstace.getLastminuteList(listPage, size: 5, SuccessBlock: { (data) -> Void in
            self.dict = try!NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSMutableDictionary
            self.titleDict.removeAll()
            self.imageDict.removeAll()
            self.priceDict.removeAll()
            self.iconDict.removeAll()
            if (self.dict.objectForKey("data") != nil){
                
                let json = JSON(self.dict.objectForKey("data")!)
                print(json)
                for key in 0...json.count{
                    if(json.count>0){
                        self.titleDict.append(json[key]["title"].stringValue)
                        self.imageDict.append(json[key]["imgUrl"].stringValue)
                        let price = json[key]["price"].stringValue
                        var tmparray = price.componentsSeparatedByString("<em>")
                        if(tmparray.count>1){
                            var newtmparray = tmparray[1].componentsSeparatedByString("</em>")
                            print("price:\(newtmparray[0])")
                            self.priceDict.append(newtmparray[0]+newtmparray[1])
                        }else{
                            self.priceDict.append("没有价格")
                        }
                    }
                }
                numberOfCards = UInt(json.count)
            }
            self.kolodaView.resetCurrentCardNumber()
            NJLoadingView.sharedInstace.hideOverlayView()
            }) { (error) -> Void in
                print("error")
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController: KolodaViewDelegate {
    
    func koloda(koloda: KolodaView, didSwipedCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        //Example: loading more cards
//        if index >= 3 {
//            numberOfCards = 6
//            kolodaView.reloadData()
//        }
        if(direction == .Left){
            print("left")
        }
        if(direction == .Right){
            print("right")
        }
        
    }
    
    func koloda(kolodaDidRunOutOfCards koloda: KolodaView) {
        //Example: reloading
        loadDiscountsRequestPage += 1
        if(loadDiscountsRequestPage>5){
            loadDiscountsRequestPage = 1
        }
        self.loadCards(loadDiscountsRequestPage)
//        kolodaView.resetCurrentCardNumber()
        
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
}

//MARK: KolodaViewDataSource
extension ViewController: KolodaViewDataSource {
    
    func koloda(kolodaNumberOfCards koloda:KolodaView) -> UInt {
        return numberOfCards
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
//        return UIImageView(image: UIImage(named: "Card_like_\(index + 1)"))
//        绘制CardView
        let cardFrame = CGRectMake(0, 0, 200, 200)
        let cardView = UIView(frame: cardFrame)
        cardView.backgroundColor = UIColor.whiteColor()
        cardView.layer.cornerRadius = 18.0
//        绘制imageView
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 18.0
        imageView.kf_setImageWithURL(NSURL(string: self.imageDict[Int(index)])!)
        cardView.addSubview(imageView)
        imageView.snp_makeConstraints { (make) -> Void in
//            make.edges.equalTo(cardView)
            make.top.equalTo(cardView)
            make.left.equalTo(cardView)
            make.right.equalTo(cardView)
            make.bottom.equalTo(cardView).multipliedBy(0.8)
        }
//        绘制contentView
        let contentView = UIView()
        contentView.backgroundColor = UIColor.whiteColor()
        cardView.addSubview(contentView)
        contentView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cardView).offset(230)
            make.right.equalTo(cardView)
            make.left.equalTo(cardView)
            make.bottom.equalTo(cardView).offset(-20)
        }
        
//        绘制标题标签
        let titleLabel:UILabel = UILabel()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.text = self.titleDict[Int(index)]
        titleLabel.font = UIFont(name: "Arial-boldMT", size: 16)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Center
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 5.0
        cardView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        
//        绘制价格标签
        let priceLabel:UILabel = UILabel()
//        var priceText = NSString.localizedStringWithFormat("<boldFont>\(self.priceDict[Int(index)])</boldFont>")
        let priceText:NSMutableAttributedString = NSMutableAttributedString(string: self.priceDict[Int(index)],attributes: [NSFontAttributeName:UIFont(
            name: "ArialMT",
            size: 48.0)!,NSForegroundColorAttributeName:UIColor.redColor()])
        priceText.addAttributes([NSFontAttributeName:UIFont(
            name: "HelveticaNeue",
            size: 21.0)!,NSForegroundColorAttributeName:UIColor.grayColor()], range: NSRange(location: priceText.length-2, length: 2))
        priceLabel.attributedText = priceText
        cardView.addSubview(priceLabel)
        priceLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(cardView).offset(-20)
            make.bottom.equalTo(cardView).offset(-15)
        }
        
        return cardView
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("OverlayView",
            owner: self, options: nil)[0] as? OverlayView
    }
}


