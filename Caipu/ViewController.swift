//
//  ViewController.swift
//  Caipu
//
//  Created by 李峰 on 16/9/4.
//  Copyright © 2016年 李峰. All rights reserved.
//

import UIKit
private extension UIStoryboard{
    class func mainStoryBoard()->UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    class func mainViewController()->MyTableViewController{
        return mainStoryBoard().instantiateViewControllerWithIdentifier("mainView")as! MyTableViewController
    }
    
    class func menuViewcontroller()->LeftMenuViewController{
        return mainStoryBoard().instantiateViewControllerWithIdentifier("leftMenu")as!LeftMenuViewController
    }
    
}
class ViewController: UIViewController,MyTabViewControllerDelaget {
    var mainView: MyTableViewController!
    var mainNavigationVC: UINavigationController!
    var menuView: LeftMenuViewController!
    var screenWidth:CGFloat!
    var offSet:CGFloat = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = UIStoryboard.mainViewController()
        mainNavigationVC = UINavigationController(rootViewController: mainView)
        mainNavigationVC.navigationBar.barTintColor = UIColor.blueColor()
        view.addSubview(mainNavigationVC.view)
        addChildViewController(mainNavigationVC)
        mainNavigationVC.didMoveToParentViewController(self)
        mainNavigationVC.view.layer.shadowOpacity = 1
        mainNavigationVC.view.layer.shadowColor = UIColor.brownColor().CGColor
        mainNavigationVC.view.clipsToBounds = false
        
        screenWidth = view.frame.width
        
        mainView.delaget = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addMenu(){
        if(menuView == nil){
            menuView = UIStoryboard.menuViewcontroller()
        }
        view.insertSubview(menuView.view, atIndex: 2)
//        view.addSubview(menuView.view)
        addChildViewController(menuView)
        menuView.didMoveToParentViewController(self)
        
//        menuView.view.frame.size.width = screenWidth - offSet
       
        menuView.view.layer.shadowColor = UIColor.grayColor().CGColor
        menuView.view.layer.shadowOpacity = 1
      
        menuView.view.clipsToBounds = false
    }
    func showMenu(){
        addMenu()
        UIView.animateWithDuration(0.5, animations: { 
//            self.menuView.view.center.x = self.menuView.view.frame.size.width/2
            self.mainNavigationVC.view.frame.origin.x =  self.screenWidth - self.offSet
            print("\(self.menuView.view.center.x)")
            }) { (Bool) in
                self.isOpenMenu = true
        }
    }
    func hideMenu(){
            UIView.animateWithDuration(0.5, animations: {
//                self.menuView.view.center.x = -self.view.frame.width/2
                self.mainNavigationVC.view.frame.origin.x = 0
                print("\(self.menuView.view.center.x)")
            }) { (Bool) in
                if (self.menuView == nil){
                }else{
                    self.menuView.removeFromParentViewController()
                    self.menuView = nil
                    self.isOpenMenu = false
                }
            }
       
        
    }
    
    var isOpenMenu=false
    func menuToggle() {
        print("menuToggle\(isOpenMenu)")
        if isOpenMenu {
            hideMenu()
        }else{
            showMenu()
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
