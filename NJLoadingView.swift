//
//  NJLoadingView.swift
//  NJToDo
//
//  Created by Nugget Jiang on 15/12/17.
//  Copyright © 2015年 Nugget Jiang. All rights reserved.
//

import UIKit
import Foundation

public class NJLoadingView{
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    class var sharedInstace:NJLoadingView{
        struct Static{
            static var onceToken : dispatch_once_t = 0
            static var instance : NJLoadingView? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = NJLoadingView()
        }
        return Static.instance!
    }
    
    public func showOverlayView(view:UIView!){
        overlayView = UIView(frame: UIScreen.mainScreen().bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityIndicator.center = overlayView.center
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.addSubview(overlayView)
    }
    public func hideOverlayView(){
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }

}


