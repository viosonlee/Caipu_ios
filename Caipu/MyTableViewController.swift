//
//  MyTableViewController.swift
//  Caipu
//
//  Created by 李峰 on 16/8/7.
//  Copyright © 2016年 李峰. All rights reserved.
//

import UIKit

var datas:[Caipu]=[]
private let kRefreshViewHeight :CGFloat = 200
protocol MyTabViewControllerDelaget{
   func menuToggle()
}
class MyTableViewController: UITableViewController,RefreshViewDelegate,MyTabViewControllerDelaget {
    @IBOutlet var tabView: UITableView!
    private var refreshView: RefreshView!
    
    var delaget:MyTabViewControllerDelaget?
    
//    private var testView:UIView!
    
//    private var menu:UITableView!
    
//    private var menuWidth:CGFloat!
    
//    private var menuView:LeftMenuViewController!
//    private var menuView:LeftMViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationbar的title的文字颜色设置
        let color:UIColor = UIColor.whiteColor()
        let dict:NSDictionary = NSDictionary(object: color, forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [String : AnyObject]
        
        //添加头部刷新背景
        refreshView = RefreshView(frame: CGRect(x: 0,y:-200,width: CGRectGetWidth(view.bounds),height: kRefreshViewHeight), scrollView: tabView)
        
        view.insertSubview(refreshView, atIndex: 0)
        
        //加载数据
        loadData()
        //cell高度的自动设置
        self.tabView.estimatedRowHeight = 67
        self.tabView.rowHeight = UITableViewAutomaticDimension
        
        refreshView.refreshViewDelegate = self
        
        
//        menuView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("leftMenu")as! LeftMenuViewController
//         menuView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("leftM")as! LeftMViewController
//        self.addChildViewController(menuView)
        
//        self.view.insertSubview(menuView.view, atIndex:2)
        
       
        
        //        self.view.addSubview(menuView.view)
        
//        menuWidth = self.view.bounds.width*4/5
        
        
//        testView = UIView.init(frame: CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.bounds.height))
        
//        testView.backgroundColor = UIColor.greenColor()
        
        //        self.view.addSubview(testView)
    }
    override func viewDidAppear(animated: Bool) {
//         self.menuView.view.center.x = -menuWidth
    }
//    var isOpen = false
    @IBAction func toggleM(sender: AnyObject) {
        menuToggle()
//        if isOpen {
//            hideM()
//            isOpen=false
//        }else{
//            showM()
//            isOpen=true
//        }
        
    }
    func menuToggle() {
        //切换菜单
        delaget!.menuToggle()
    }
    func showM(){
//        var c = self.menuView.view.frame
//        c.origin.x = self.view.bounds.width
//
//        //        dispatch_async(dispatch_get_main_queue()) {
//        UIView.animateWithDuration(0.3, animations: {
//            self.testView.center.x = self.menuWidth/2
//            
//            
////            self.menuView.view.frame = c
////            self.view.center.x = self.menuWidth
//            self.menuView.view.center.x = self.menuWidth/2
//        
//        })
        //        }
    }
    func hideM(){
//        var c = self.menuView.view.frame
//        c.origin.x = 0
//        //        dispatch_async(dispatch_get_main_queue()) {
//        UIView.animateWithDuration(0.3, animations: {
//            self.testView.center.x = -self.menuWidth/2
//            
////            self.menuView.view.frame = c
////            self.view.center.x = self.view.bounds.width/2
//            self.menuView.view.center.x = -self.menuWidth
//        })
        //        }
    }
    func loadData(){
        let url:String = "http://apis.baidu.com/tngou/cook/list?id=10&page=1&rows=15"
        let apikey = "3b0f889244f63645afeb76c3af21630f"
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.setValue(apikey, forHTTPHeaderField: "apikey")
        manager.GET(url, parameters: nil, progress: { (nspro:NSProgress) in
            
            }, success: { (data:NSURLSessionDataTask, object:AnyObject?) in
                //                print(object!.description)
                //                print("不能输中文吗")
                if(self.isRefreshing){
                    self.refreshView.endRefreshing()
                }
                let jsonObject:NSDictionary = object as! NSDictionary
                let des:String = (jsonObject["tngou"]?[0]?["description"] as? String)!
                
                print("des->:\(des)")
                
                if let object = jsonObject["tngou"]{
                    let jsonArray:NSArray = object as! NSArray
                    for json in jsonArray{
                        let title = json["name"] as! String
                        let short = json["food"] as! String
                        let des = json["description"] as! String
                        var imageUrl = json["img"] as! String
                        imageUrl = ImageUtil.sharedUtil.getImageUrl(imageUrl, width: 130, height: 130)
                        let id = json["id"] as! Int
                        
                        let caipu:Caipu = Caipu(title: title, shortDes: short, des: des, iconURL: imageUrl,id:id)
                        datas.append(caipu)
                    }
                    self.tabView.reloadData()
                }else{
                    print("tngon is nil")
                }
            } , failure: { (data:NSURLSessionDataTask?, error:NSError) in
                self.refreshView.endRefreshing()
                print("error:\(error.localizedDescription)")
                print("data:\(data?.description)")
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        //
        refreshView.scrollViewDidScroll(scrollView)
    }
    
    //    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //        //
    //        refreshView.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    //    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("caipuItem")! as UITableViewCell
        
        let titleLable = cell.viewWithTag(102)! as! UILabel
        let shortDesLable = cell.viewWithTag(103)! as! UILabel
        let desLable = cell.viewWithTag(104)! as! UILabel
        let icon = cell.viewWithTag(101)! as! UIImageView
        
        titleLable.text = datas[indexPath.row].title
        shortDesLable.text = datas[indexPath.row].shortDes
        desLable.text = datas[indexPath.row].des
        //异步加载图片
        ImageLoader.sharedLoader.imageForUrl(datas[indexPath.row].iconURL) { (image, url) in
            icon.image = image
        }
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSeeDetail1"{
            let vc = segue.destinationViewController as! WebViewController
            let indexPath = tabView.indexPathForSelectedRow
            if let index = indexPath {
                vc.caipu = datas[index.row]
            }
        }
    }
    var isRefreshing = false
    func refreshViewDidRefresh(refreshView: RefreshView) {
        isRefreshing = true
        loadData()
        datas.removeAll()
    }
    
}
