//
//  Post.swift
//  WxToutiao
//
//  Created by 王伟奇 on 2017/6/11.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya

struct PostIndexResponse: Mappable {
    
    var status: String!
    var count: Int!
    var posts: [Post]!
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        count <- map["count"]
        posts <- map["posts"]
    }
}

//提交评论的响应
struct SubmitResponse: Mappable {
    
    var status: String!
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        
    }
}


struct Comment: Mappable {
    var name: String!
    var content: String!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        content <- map["content"]
        
    }
}


struct Post: Mappable {
    var id: Int!
    var title: String!
    
    var content: String!
    var url: String!
    var comment_count: Int!
    
    var comments: [Comment]!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        
        content <- map["content"]
        url <- map["url"]
        comment_count <- map["comment_count"]
        
        comments <- map["comments"]
    }
}

extension Post {
    
    //获取新闻分类下文章列表  用maya请求 网络请求
    //函数作为参数  返回你所需要的东西，完成可以跳出 运用了@escaping
    
    static func request(id: Int,completion: @escaping ([Post]?) -> Void) {
        let provider = MoyaProvider<NetworkService>()
        
        provider.request(.showCateNwesList(id: id)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = PostIndexResponse(JSON: json){
                    
                    //                    print(jsonResponse.count,jsonResponse.status,jsonResponse.categories)
                    completion(jsonResponse.posts)
                }
                
                
            case .failure:
                print("网络错误")
                completion(nil)
                
            }
        }
    }
    
    //给文章发表评论
    static func submitComment(postId: Int, name: String, email: String, content: String,completion: @escaping (Bool) -> Void) {
        let provider = MoyaProvider<NetworkService>()
        
        provider.request(.submitComment(postId: postId, name: name, email: email, content: content)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = SubmitResponse(JSON: json){
                    
                    if jsonResponse.status == "OK" {
                        completion(true)
                    } else {
                        completion(false)
                    }
                    
                }
                
                
            case .failure:
                print("网络错误")
                completion(false)
                
            }
        }
    }

    
}

