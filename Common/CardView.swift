//
//  CardView.swift
//  NJToDo
//
//  Created by Nugget Jiang on 15/12/16.
//  Copyright © 2015年 Nugget Jiang. All rights reserved.
//

import UIKit

class CardView: UIView {
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var lastminuteTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        lastminuteTitle.text = "12345"
        
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetRGBFillColor(context, 0, 0.25, 0, 0.5);
        CGContextFillRect(context, CGRectMake(2, 2, 270, 270));
        CGContextStrokePath(context);
        
    }
}
