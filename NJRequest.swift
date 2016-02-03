//
//  NJRequest.swift
//  NJToDo
//
//  Created by Nugget Jiang on 15/12/15.
//  Copyright © 2015年 Nugget Jiang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let BaseURL = "http://open.qyer.com/"

class NJRequest: NSObject {
    typealias NJRequestSuccessBlock = (data:NSData)->Void
    typealias NJRequestFailureBlock = (error:NSError)->Void
    
    override init() {
        super.init()
        let headdict = NSMutableDictionary(capacity: 0)
        let client_id = "qyer_discount_ios"
        let client_secret = "44c86dbde623340b5e0a"
        let access_token = NSUserDefaults.standardUserDefaults().objectForKey("user_access_token")
        headdict.setObject(client_id, forKey: "client_id")
        headdict.setObject(client_secret, forKey: "client_secret")
        if(access_token != nil && access_token?.length>0){
            headdict.setObject(access_token!, forKey: "oauth_token")
        }
        
    }
    func getServerTime(SuccessBlock:NJRequestSuccessBlock,FailureBlock:NJRequestFailureBlock){
        self.sendRequest("app/time", method: ".GET", params: nil, success: SuccessBlock, failure: FailureBlock)
    }
    func getLastminuteList(page:NSInteger,size:NSInteger,SuccessBlock:NJRequestSuccessBlock,FailureBlock:NJRequestFailureBlock){
        let params = NSMutableDictionary(capacity: 0)
        params.setObject(page, forKey: "page")
        params.setObject(size, forKey: "pageSize")
        self.sendRequest("lastminute/app_selected_product", method: ".GET", params: params, success: SuccessBlock, failure: FailureBlock)
    }
    
    func sendRequest(var path:String,method:String,params:NSDictionary?,success:NJRequestSuccessBlock,failure:NJRequestFailureBlock){
        
        path = BaseURL + path
        switch method{
        case ".GET":
            Alamofire.request(.GET, path, parameters: params as? [String:AnyObject])
                .responseData { response in
                    if let json = response.data {
                        success(data: json)
                        
                    }
                    if let error = response.result.error{
                        failure(error: error)
                    }
                    
                        
                    
            }
        case ".POST":
            Alamofire.request(.POST, path, parameters: params as? [String : AnyObject], encoding: .URL, headers: nil).response { (_, _, data, error) -> Void in
                if((error) != nil){
                    print(error)
                    failure(error: error!)
                }else{
                    print("post")
                    success(data: data!)
                }
            }
        default:print("123")
        }

    }
    
    class var sharedInstace:NJRequest{
        struct Static{
            static var onceToken : dispatch_once_t = 0
            static var instance : NJRequest? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = NJRequest()
        }
        return Static.instance!
    }
}
