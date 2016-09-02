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

enum URLtype:String{
    case QYER,NORIKAE,SHUHUI
}

let BaseURLQY = "http://open.qyer.com/"
let BaseURLNK = "http://mbapi.jorudan.co.jp/"
let BaseURLSH = "http://www.ishuhui.net/ComicBooks/GetChapterList/"

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
        self.sendRequest(.QYER,path: "app/time", method: ".GET", params: nil, success: SuccessBlock, failure: FailureBlock)
    }
    func getLastminuteList(page:NSInteger,size:NSInteger,SuccessBlock:NJRequestSuccessBlock,FailureBlock:NJRequestFailureBlock){
        let params = NSMutableDictionary(capacity: 0)
        params.setObject(page, forKey: "page")
        params.setObject(size, forKey: "pageSize")
        self.sendRequest(.QYER,path:"lastminute/app_selected_product", method: ".GET", params: params, success: SuccessBlock, failure: FailureBlock)
    }
    func getCountryList(SuccessBlock:NJRequestSuccessBlock,FailureBlock:NJRequestFailureBlock){
        let params = NSMutableDictionary(capacity: 0)
        let client_id = "qyer_planner_ios"
        let client_secret = "e24e75dbf6fa3c49651f"
        params.setObject(client_id, forKey: "client_id")
        params.setObject(client_secret, forKey: "client_secret")
        self.sendRequest(.QYER, path: "plan/country/list", method: ".GET", params: params, success: SuccessBlock, failure: FailureBlock)
    }
    func getRailPath(start:String,end:String,SuccessBlock:NJRequestSuccessBlock,FailureBlock:NJRequestFailureBlock){
        let params = NSMutableDictionary(capacity: 0)
        let startstr:String = "R" + start
        let endstr:String = "R" + end
        let c = "10"
        let p = "0"
        let bg = "1"
        let tashainfo = "1"
        let plusmode = "0"
        params.setObject(plusmode, forKey: "plusmode")
        params.setObject(NKVersion,forKey: "apv")
        params.setObject(startstr,forKey: "t")
        params.setObject(endstr,forKey: "f")
        params.setObject(c,forKey: "c")
        params.setObject(p,forKey: "p")
        params.setObject(bg,forKey: "bg")
        params.setObject(tashainfo,forKey: "tashainfo")
        self.sendRequest(.NORIKAE, path: "iph/noriapl.cgi", method: ".GET", params: params, success: SuccessBlock, failure: FailureBlock)
        
    }
    func getChapterList(PageIndex:Int,id:Int,SuccessBlock:NJRequestSuccessBlock,FailureBlock:NJRequestFailureBlock){
        let params = NSMutableDictionary(capacity: 0)
        params.setObject(PageIndex,forKey: "PageIndex")
        params.setObject(id,forKey: "id")
        self.sendRequest(.SHUHUI, path: "GetChapterList/", method: ".POST", params: params, success: SuccessBlock, failure: FailureBlock)
    }
    func sendRequest( type:URLtype,var path:String,method:String,params:NSDictionary?,success:NJRequestSuccessBlock,failure:NJRequestFailureBlock){
        switch type{
        case .QYER:
            path = BaseURLQY + path
        case .NORIKAE:
            path = BaseURLNK + path
        case .SHUHUI:
            path = BaseURLSH + path
        default:
            path = BaseURLQY + path
        }
        
        switch method{
        case ".GET":
            Alamofire.request(.GET, path, encoding:.URLEncodedInURL,parameters: params as? [String:AnyObject])
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
