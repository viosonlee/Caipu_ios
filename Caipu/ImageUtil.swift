//
//  ImageUtil.swift
//  Caipu
//
//  Created by 李峰 on 16/8/6.
//  Copyright © 2016年 李峰. All rights reserved.
//

import UIKit

class ImageUtil{

    class var sharedUtil : ImageUtil{
        struct Static {
            static let intance :ImageUtil = ImageUtil()
        }
        return Static.intance
    }
    
    func getImageUrl(url:String,width:Int,height:Int)->String{
        let HOST = "http://tnfs.tngou.net/image"
        
        let imgUrl = "\(HOST)\(url)_\(width)x\(height)"
        
        return imgUrl
    }
    func getCaipuUrl(id:Int)->String{
        let HOST = "http://www.tngou.net/cook/show/"
        
        let url = "\(HOST)\(id)"
        
        return url
    }
}
