//
//  ViewController.swift
//  WxToutiao
//
//  Created by 王伟奇 on 2017/6/10.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
import Moya
import PageMenu

class ViewController: UIViewController {
    var pageMenu: CAPSPageMenu!
    var controllers: [UIViewController] = []
    
    @IBAction func tap(_ sender: UIButton) {
        
    }
    
    func showMenu() {
        Category.request { (cates) in
            self.controllers = cates!.map{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsList") as! NewsListTableViewController
                
                vc.title = $0.title
                
                //传递navigationcontroll的引用传递给下一级    不需要创建导航 直接传递导航的引用
                vc.parentNavi = self.navigationController
                vc.id = $0.id
                
                return vc
            }
            
            //pagemenu 的样式
            let param: [CAPSPageMenuOption] = [
                .menuItemSeparatorWidth(4.3),
                .scrollMenuBackgroundColor(UIColor.white),
                .viewBackgroundColor(UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)),
                .bottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
                .selectionIndicatorColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
                .menuMargin(20.0),
                .menuHeight(40.0),
                .selectedMenuItemLabelColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
                .unselectedMenuItemLabelColor(UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)),
                .menuItemFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!),
                .useMenuLikeSegmentedControl(false),
                .menuItemSeparatorRoundEdges(true),
                .selectionIndicatorHeight(2.0),
                .menuItemSeparatorPercentageHeight(0.1)
            ]
            
            let frame = CGRect(x: 0, y: 20 + 44, width: self.view.frame.width, height: self.view.frame.height - 20 - 44)
            self.pageMenu = CAPSPageMenu(viewControllers: self.controllers, frame: frame, pageMenuOptions: param)
            
            self.view.addSubview(self.pageMenu.view)
        }

    }
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航的返回按钮为空   就单纯的箭头返回
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        showMenu()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

