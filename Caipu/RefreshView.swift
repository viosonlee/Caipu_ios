//
//  RefreshView.swift
//  Caipu
//
//  Created by 李峰 on 16/8/7.
//  Copyright © 2016年 李峰. All rights reserved.
//

import UIKit
protocol RefreshViewDelegate: class {
    func refreshViewDidRefresh(refreshView: RefreshView)
}

private let kScreenHeight :CGFloat = 120.0
class RefreshView : UIView , UIScrollViewDelegate{
    var isRefreshing: Bool = false
    
    weak var refreshViewDelegate: RefreshViewDelegate?
    private unowned var scrollView:UIScrollView
    private var progress: CGFloat = 0.0
    
    var refreshItems = [RefreshItem]()
    
    init(frame: CGRect,scrollView: UIScrollView) {
        self.scrollView = scrollView
        super.init(frame:frame)
        //        backgroundColor = UIColor.greenColor()
        updateUI()
        setupRefreshItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRefreshItems(){
        let buildImageView = UIImageView(image: UIImage(named: "buildings"))
        let groundImageView = UIImageView(image: UIImage(named: "ground"))
        let catImageView = UIImageView(image:
            UIImage(named:"cat"))
        let capeBackImageView = UIImageView(image:
            UIImage(named:"cape_back"))
        let capeFrontImageView = UIImageView(image:
            UIImage(named:"cape_front"))
        let sunImageView = UIImageView(image:
            UIImage(named:"sun"))
        //        let cloud1ImageView = UIImageView(image:
        //            UIImage(named:"cloud_1"))
        //        let cloud2ImageView = UIImageView(image:
        //            UIImage(named:"cloud_2"))
        //        let cloud3ImageView = UIImageView(image:
        //            UIImage(named:"cloud_3"))
        //        let signImageView = UIImageView(image:
        //            UIImage(named:"sign"))
        refreshItems = [
            RefreshItem(view: buildImageView, centerEnd: CGPoint(x:CGRectGetMidX(bounds),y: CGRectGetHeight(bounds)-CGRectGetHeight(groundImageView.bounds)-CGRectGetHeight(buildImageView.bounds)/2), parallaxRatio: 1.5, sceneHeight: kScreenHeight),
            RefreshItem(view: sunImageView, centerEnd: CGPoint(x:CGRectGetWidth(bounds)*0.1,y: CGRectGetHeight(bounds)-CGRectGetHeight(groundImageView.bounds)-CGRectGetHeight(sunImageView.bounds)), parallaxRatio: 3.0, sceneHeight: kScreenHeight),
            //            RefreshItem(view: cloud1ImageView, centerEnd: CGPoint(x:CGRectGetWidth(bounds)*0.1,y: CGRectGetHeight(bounds)-CGRectGetHeight(groundImageView.bounds)-CGRectGetHeight(cloud1ImageView.bounds)), parallaxRatio: 3.0, sceneHeight: kScreenHeight),
            //            RefreshItem(view: cloud2ImageView, centerEnd: CGPoint(x:CGRectGetWidth(bounds)*0.1,y: CGRectGetHeight(bounds)-CGRectGetHeight(groundImageView.bounds)-CGRectGetHeight(cloud2ImageView.bounds)), parallaxRatio: 3.0, sceneHeight: kScreenHeight),
            //            RefreshItem(view: cloud3ImageView, centerEnd: CGPoint(x:CGRectGetWidth(bounds)*0.1,y: CGRectGetHeight(bounds)-CGRectGetHeight(groundImageView.bounds)-CGRectGetHeight(cloud3ImageView.bounds)), parallaxRatio: 3.0, sceneHeight: kScreenHeight),
            RefreshItem(view: groundImageView, centerEnd: CGPoint(x:CGRectGetMidX(bounds),y: CGRectGetHeight(bounds)-CGRectGetHeight(groundImageView.bounds)/2), parallaxRatio: 0.5, sceneHeight: kScreenHeight),
            RefreshItem(view: capeBackImageView, centerEnd: CGPoint(x:CGRectGetMidX(bounds),y: CGRectGetHeight(bounds)-CGRectGetHeight(groundImageView.bounds)/2-CGRectGetHeight(capeBackImageView.bounds)/2), parallaxRatio: -1, sceneHeight: kScreenHeight),
            RefreshItem(view: catImageView, centerEnd: CGPoint(x:CGRectGetMidX(bounds),y: CGRectGetHeight(bounds)-CGRectGetHeight(groundImageView.bounds)/2-CGRectGetHeight(catImageView.bounds)/2), parallaxRatio: 1, sceneHeight: kScreenHeight),
            RefreshItem(view: capeFrontImageView, centerEnd: CGPoint(x:CGRectGetMidX(bounds),y: CGRectGetHeight(bounds)-CGRectGetHeight(groundImageView.bounds)/2-CGRectGetHeight(capeFrontImageView.bounds)/2), parallaxRatio: -1, sceneHeight: kScreenHeight)
            
        ]
        
        for refreshItem in refreshItems{
            addSubview(refreshItem.view)
        }
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if isRefreshing {
            return
        }
        //1.先拿到刷新视图的可见区域高度
        let refreshViewVisibleHeight = max(0,-scrollView.contentOffset.y - scrollView.contentInset.top)
        print("refreshViewVisibleHeight:\(refreshViewVisibleHeight)")
        //计算当前滚动的进度 范围是0-1
        progress = min(1,refreshViewVisibleHeight/kScreenHeight)
        //根据进度进行ui变化
        updateUI()
    }
    
    func updateUI(){
        for refreshItem in refreshItems{
            refreshItem.updatePosition(progress)
        }
        
        backgroundColor = UIColor(white: 0.7*progress+0.2, alpha: 1.0)
    }
    
    //    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //        if(!isRefreshing&&progress == 1.0){
    //            beginRefreshing()
    ////            isRefreshing = true
    ////            scrollView.contentInset.top = scrollView.contentInset.top + kScreenHeight
    //            scrollView.contentOffset.y = -scrollView.contentInset.top
    //        }
    //    }
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        if(!isRefreshing&&progress == 1.0){
            beginRefreshing()
            targetContentOffset.memory.y = -scrollView.contentInset.top
            refreshViewDelegate?.refreshViewDidRefresh(self)
        }
    }
    func beginRefreshing(){
        isRefreshing = true
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseIn, animations: {
            self.scrollView.contentInset.top = self.scrollView.contentInset.top+kScreenHeight
        }) { (Bool) in
            
        }
        //毛和斗篷的动画
        let cape = refreshItems[3].view
        let cat = refreshItems[4].view
        let cape_f = refreshItems[5].view
        cape.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI/32))
        cat.transform = CGAffineTransformMakeTranslation(1.0, 0)
        cape_f.transform = CGAffineTransformMakeTranslation(1.0, 0)
        
        UIView.animateWithDuration(0.2, delay: 0, options:[.Repeat ,.Autoreverse], animations: {
            cape.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/32 ))
            cat.transform = CGAffineTransformMakeTranslation(-1.0, 0)
            cape_f.transform = CGAffineTransformMakeTranslation(-1.0, 0)
            }, completion: nil)
        
        //建筑物和背景动画
        let ground = refreshItems[2].view
        let build = refreshItems[0].view
        UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseInOut, animations: {
            ground.center.y = ground.center.y + kScreenHeight
            build.center.y = build.center.y + kScreenHeight
            }, completion: nil)
    }
    
    func endRefreshing(){
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseIn, animations: {
            self.scrollView.contentInset.top = self.scrollView.contentInset.top-kScreenHeight
        }) { (Bool) in
            self.isRefreshing = false
        }
        
        let cape = refreshItems[3].view
        let cat = refreshItems[4].view
        let cape_f = refreshItems[5].view
        cape.transform = CGAffineTransformIdentity
        cat.transform = CGAffineTransformIdentity
        cape_f.transform = CGAffineTransformIdentity
        cape.layer.removeAllAnimations()
    }
}

