//
//  NSURLRequestExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 11/01/16.
//  Copyright (c) 2016 Muxu.Muxu. All rights reserved.
//

import Foundation

/// cURL extension
public extension URLRequest {
    fileprivate func escapeQuotes(in string: String) -> String {
        return string.replacingOccurrences(of: "\"", with: "\\\"")
    }
    
    var cURLString: String {
        var cURLString = "curl -i"
        let newLine = " \\\n\t"
        
        if let method = httpMethod {
            cURLString += "\(newLine) -X \(method)"
        }
        
        if let headerFields = allHTTPHeaderFields {
            for key in headerFields.keys {
                if let value = headerFields[key] {
                    let headerKey = escapeQuotes(in: key)
                    let headerValue = escapeQuotes(in: value)
                    cURLString += "\(newLine) -H '\(headerKey): \(headerValue)'"
                }
            }
        }
        
        if let HTTPBody = httpBody, let bodyString = String(data: HTTPBody, encoding: String.Encoding.utf8) , bodyString.count > 0 {
            let sanitize = bodyString.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
            cURLString += "\(newLine) -d '\(sanitize)'"
        }
        
        if let absolute = url?.absoluteString {
            cURLString += "\(newLine) '\(absolute)'"
        }
        
        return cURLString
    }
}
