//
//  RefreshItem.swift
//  Caipu
//
//  Created by 李峰 on 16/8/7.
//  Copyright © 2016年 李峰. All rights reserved.
//

import UIKit
class RefreshItem {
    private var centerEnd: CGPoint
    private var centerStart: CGPoint
    unowned var view: UIView
    
    init(view: UIView, centerEnd: CGPoint,parallaxRatio: CGFloat,sceneHeight:CGFloat){
        self.view = view
        self.centerEnd = centerEnd
        self.centerStart = CGPoint(x: centerEnd.x, y: centerEnd.y+(parallaxRatio*sceneHeight))
        self.view.center = centerStart
    }
    func updatePosition(progress: CGFloat){
        self.view.center = CGPoint(
            x: centerStart.x + (centerEnd.x - centerStart.x)*progress ,
            y: centerStart.y + (centerEnd.y - centerStart.y)*progress)
    }
}
