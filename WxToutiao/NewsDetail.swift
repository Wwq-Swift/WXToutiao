//
//  NewsDetail.swift
//  WxToutiao
//
//  Created by 王伟奇 on 2017/6/11.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
import WebKit
import LeoDanmakuKit
import LLSwitch

class NewsDetail: UIViewController,LLSwitchDelegate {
    
    @IBOutlet weak var danmuSwitch: LLSwitch!
    func didTap(_ llSwitch: LLSwitch!) {
        if danmuOn{
            danmuSwitch.setOn(false, animated: true)
            danmuView.stop()
            danmuView.isHidden = true
        } else {
            danmuSwitch.setOn(true, animated: true)
            danmuView.resume()
            danmuView.isHidden = false
        }
        danmuOn = !danmuOn
    }
    
    @IBOutlet weak var danmuView: LeoDanmakuView!
    var webView: WKWebView!
    var post: Post!
    var danmuOn = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = post.title
        
        danmuSwitch.delegate = self
        
        loadHtml()
        loadDamu(comments: post.comments)
        
        
       

        // Do any additional setup after loading the view.
    }
    
    func loadHtml() {
        let frame = CGRect(x: 0, y: 20 + 44, width: view.frame.width, height: view.frame.height - 20 - 44)
        webView = WKWebView(frame: frame)
        view.insertSubview(webView, at: 0)
        
        var header = "<html>"
        header += "<head>"
        
        //html网页自适应
        header += "<meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\">"
        
        //html网页图片设置大小  用css对总体的网页里的图片设置大小
        header += "<style>"
        header += "img {width: 100%}"
        header += "</style>"
        
        
        header += "</head>"
        header += "<body>"
        
        var footer = "</body>"
        footer += "</html>"
        
        //wkwebview载入html
        webView.loadHTMLString(header + post.content + footer, baseURL: nil)
        
        //wkwebview载入网址
        // webView.load(URLRequest(url: url))
    }
    
    func loadDamu(comments: [Comment]? = nil, postAComment: String? = nil) {
        if danmuOn {
            danmuView.resume()
            
            if let comments = comments{
                let danmus: [LeoDanmakuModel] = comments.map{
                    let model = LeoDanmakuModel.randomDanmku(withColors: UIColor.danmu, maxFontSize: 30, minFontSize: 15)
                    model?.text = $0.content.html2String
                    return model!
                }
                danmuView.addDanmaku(with: danmus)
            }
            
            if let comment = postAComment {
                let model = LeoDanmakuModel.randomDanmku(withColors: UIColor.danmu, maxFontSize: 30, minFontSize: 15)
                model?.text = comment
                danmuView.addDanmaku(model)
            }
            
        } else {
            danmuView.stop()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
