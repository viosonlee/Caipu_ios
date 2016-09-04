//
//  Caipu.swift
//  Caipu
//
//  Created by 李峰 on 16/8/6.
//  Copyright © 2016年 李峰. All rights reserved.
//

import UIKit

class Caipu : NSObject{
    var title:String
    var des: String
    var shortDes:String
    var iconURL : String
    var id:Int
    init(title:String,shortDes:String,des:String,iconURL:String,id:Int) {
        self.title=title
        self.des=des
        self.iconURL=iconURL
        self.shortDes=shortDes
        self.id=id
    }
}