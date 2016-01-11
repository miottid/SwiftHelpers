//
//  NSURLRequestExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 11/01/16.
//  Copyright (c) 2016 Wopata. All rights reserved.
//

import Foundation

/// cURL extension
public extension NSURLRequest {
    private func escapeQuotesInString(string: String) -> String {
        return string.stringByReplacingOccurrencesOfString("\"", withString: "\\\"")
    }
    
    public func cURL() -> String {
        var cURLString = "curl -i"
        let newLine = " \\\n\t"
        
        if let method = HTTPMethod {
            cURLString += "\(newLine) -X \(method)"
        }
        
        if let headerFields = allHTTPHeaderFields {
            for key in headerFields.keys {
                if let value = headerFields[key] {
                    let headerKey = escapeQuotesInString(key)
                    let headerValue = escapeQuotesInString(value)
                    cURLString += "\(newLine) -H '\(headerKey): \(headerValue)'"
                }
            }
        }
        
        if let HTTPBody = HTTPBody, bodyString = String(data: HTTPBody, encoding: NSUTF8StringEncoding) where bodyString.characters.count > 0 {
            let sanitize = bodyString.stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
            cURLString += "\(newLine) -d '\(sanitize)'"
        }
        
        if let absolute = URL?.absoluteString {
            cURLString += "\(newLine) '\(absolute)'"
        }
        
        return cURLString
    }
}