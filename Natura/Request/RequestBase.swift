//
//  RequestBase.swift
//  Natura
//
//  Created by Gerlandio Lucena on 27/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit
import Alamofire

typealias defaultResponse = (response: AnyObject, error: String?) -> Void

class RequestBase: NSObject {
    
    var defaultURL: String = ""
    var headers: [String: String]?
    
    init(url: String) {
        defaultURL = url
    }
    
    func get(parameters: [String: String]) ->  Request {
        return Alamofire.request(.GET, defaultURL, parameters: parameters, encoding: ParameterEncoding.URL, headers: getHeaders())
    }
    
    func post(parameters: [String: String]) ->  Request {
        return Alamofire.request(.POST, defaultURL, parameters: parameters, encoding: ParameterEncoding.JSON, headers: getHeaders())
    }
    
    func delete(parameters: [String: String]) ->  Request {
        return Alamofire.request(.DELETE, defaultURL, parameters: parameters, encoding: ParameterEncoding.JSON, headers: getHeaders())
    }
    
    func put(parameters: [String: String]) ->  Request {
        return Alamofire.request(.PUT, defaultURL, parameters: parameters, encoding: ParameterEncoding.JSON, headers: getHeaders())
    }
    
    func getHeaders() -> [String: String]? {
        return headers;
    }
    
    func setHeaderRequest(headerParams: [String: String]?) {
        headers = headerParams
    }
    
}
