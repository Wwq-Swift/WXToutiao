//
//  Category.swift
//  WxToutiao
//
//  Created by 王伟奇 on 2017/6/10.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya

struct CategoryIndexResponse: Mappable {
    
    var status: String!
    var count: Int!
    var categories: [Category]!
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        count <- map["count"]
        categories <- map["categories"]
    }
}

struct Category: Mappable {
    var id: Int!
    var title: String!
    var count: Int!
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        count <- map["post_cont"]
    }
}

extension Category {
    
    //获取新闻分类  用maya请求 网络请求
    //函数作为参数  返回你所需要的东西，完成可以跳出 运用了@escaping
    
    static func request(completion: @escaping ([Category]?) -> Void) {
        let provider = MoyaProvider<NetworkService>()
        
        provider.request(.category) { (result) in
            switch result {
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = CategoryIndexResponse(JSON: json){
                    
                    //                    print(jsonResponse.count,jsonResponse.status,jsonResponse.categories)
                    completion(jsonResponse.categories)
                }
                
                
            case .failure:
                print("网络错误")
                completion(nil)
                
            }
        }
    }

}


