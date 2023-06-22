//
//  RequestHandler.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 21/06/2023.
//

import Foundation
import CryptoKit


class RequestHandler{
     func getURL()->String{
        let baseUrl = Endpoints.baseURL
        let apiKey = getApi()
        let hash = getHashKey()
        let ts = getTimestampForRequest()
        return "\(baseUrl)\(apiKey)&\(ts)&\(hash)"
    }
     func getUrlById(id:String,type:String)->String{
        let baseUrl = Endpoints.baseURL
        let apiKey = getApi()
        let hash = getHashKey()
        let ts = getTimestampForRequest()
        return "\(baseUrl)/\(id)/\(type)\(apiKey)&\(ts)&\(hash)"
    }
    
    private func getTimestamp() -> String {
        let currentDate = Date()
        let timeInterval = currentDate.timeIntervalSince1970
        let formattedInterval = String(format: "%.0f", timeInterval)
        return formattedInterval
    }
    
    private func generateHash(ts: String, privateKey: String, publicKey: String) -> String {
        let concatenatedString = ts + privateKey + publicKey
        if let data = concatenatedString.data(using: .utf8) {
            let hash = Insecure.MD5.hash(data: data)
            let hashString = hash.map { String(format: "%02hhx", $0) }.joined()
            return hashString
        } else {
            return ""
        }
    }
    private func getApi()->String{
        return "apikey=\(Endpoints.publicKey)"
    }
    private func getHashKey()->String{
        return "hash=\(generateHash(ts:getTimestamp(), privateKey: Endpoints.privateKey, publicKey: Endpoints.publicKey))"
    }
    private func getTimestampForRequest()->String{
        return "ts=\(getTimestamp())"
    }
}
