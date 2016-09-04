//
//  WebViewController.swift
//  Caipu
//
//  Created by 李峰 on 16/8/6.
//  Copyright © 2016年 李峰. All rights reserved.
//


import UIKit

class WebViewController : UIViewController{
    
    @IBOutlet weak var webView: UIWebView!
    var caipu:Caipu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = caipu?.title
        
        let id = caipu?.id
        
        let url = ImageUtil.sharedUtil.getCaipuUrl(id!)
        
        self.navigationItem.title = name
        print(url)
        webView.loadRequest(NSURLRequest(URL: NSURL(string:url)!))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
