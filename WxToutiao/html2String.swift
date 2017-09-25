//
//  html2String.swift
//  WxToutiao
//
//  Created by 王伟奇 on 2017/6/12.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

//把一个含有html的标签的string转成nsattristring    把ios中html标签转化为平常的文字
extension String {
    var html2AttributedString: NSAttributedString? {
        do{
            return try NSAttributedString(data: Data(utf8), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print(error)
            return nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
    
