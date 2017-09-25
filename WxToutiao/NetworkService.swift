//
//  NwtworkService.swift
//  WxToutiao
//
//  Created by 王伟奇 on 2017/6/10.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya

enum NetworkService {
    case category
    case showCateNwesList(id: Int)
    case submitComment(postId: Int, name: String, email: String, content: String)
}

extension NetworkService: TargetType {

    /// The target's base `URL`.

    var baseURL: URL { return URL(string: "http://localhost:8888/wordpress/api")! }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .category:
            return "/get_category_index"
        case .showCateNwesList:
            return "/get_category_posts"
        case .submitComment:
            return "/submit_comment"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .category,.showCateNwesList,.submitComment:
            return .get
            

        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .category:
            return nil
        case .showCateNwesList(let id):
            return ["id" : id]
            
        case .submitComment(let postId,let name, let email, let content):
            return ["post_id": postId, "name": name, "email": email, "content": content]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .category,.showCateNwesList, .submitComment:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        case .category:
            return "category test data".utf8Encoded
        case .showCateNwesList(let id):
            return "nweslist id is \(id)".utf8Encoded
        case .submitComment(let postId,let name, let email, let content):
            return "\(postId),\(name),\(email),\(content)".utf8Encoded
        }
        
        
    }
    
    var task: Task {
        switch self {
        case .category,.showCateNwesList,.submitComment:
            //request 就是访问一个网址， 还有下载和上传其他枚举类型  一般用于比较大的
            return .request
        }
    }

    
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}








