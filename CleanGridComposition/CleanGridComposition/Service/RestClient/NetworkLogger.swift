//
//  NetworkLogger.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation
import Alamofire
extension URLRequest {
    func log() {
        let urlString = self.url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)
        let method = self.httpMethod != nil ? "\(self.httpMethod!)": ""
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        let host = "\(components?.host ?? "")"
        var requestLog = "\n---------- OUT ---------->\n"
        requestLog += "🌐 \(urlString)"
        requestLog += "\n\n"
        requestLog += "\(method) \(path)?\(query) HTTP/1.1\n"
        requestLog += "Host: \(host)\n"
        for (key, value) in self.allHTTPHeaderFields ?? [:] {
            requestLog += "\(key): \(value)\n"
        }
        if let body = self.httpBody {
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body not utf8 encoded"
            requestLog += "\nHTTP Body: \(bodyString)\n"
        }
        requestLog += "\n------------------------->\n"
        Logger.log(msg: "🚀 [Network Request Intiated:]\n" + requestLog)
    }
}
extension HTTPURLResponse {
    func log<T: Decodable>(response: AFDataResponse<T>) {
        let urlString = self.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        var responseLog = "\n<---------- IN ----------\n"
        if let urlString = urlString {
            responseLog += "\(urlString)"
            responseLog += "\n\n"
        }
        responseLog += "HTTP \(self.statusCode) \(path)?\(query)\n"
        if let host = components?.host {
            responseLog += "Host: \(host)\n"
        }
        for (key, value) in self.allHeaderFields {
            responseLog += "\(key): \(value)\n"
        }
        if let body = response.data {
            let bodyString = body.prettyPrintedJSONString ?? "Can't render body not utf8 encoded"
            responseLog += "\n✅ Response: \(bodyString)\n"
        }
        if let error = response.error {
            responseLog += "\n❌ Response Error: \(error.localizedDescription)\n"
            Logger.log(msg: "Response Underlying Error \(String(describing: error.underlyingError))")
            Logger.log(msg: "Response failedStringEncoding Error \(String(describing: error.failedStringEncoding))")
        }
        responseLog += "<------------------------\n"
        Logger.log(msg: "🚀 [Network Request Completed:]\n" + responseLog)
    }
}
extension Data {
    var prettyPrintedJSONString: NSString? {
        // MARK: NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
