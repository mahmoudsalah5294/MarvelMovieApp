//
//  DataHandler.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 20/06/2023.
//

import Foundation

class DataHandler {
    
    func getImageUrl(thumbnail:Thumbnail?)->String{
        guard let thumbnailPath = thumbnail?.path, let thumbnailExtension = thumbnail?.thumbnailExtension?.rawValue else {return ""}
        let url = "\(thumbnailPath).\(thumbnailExtension)"
        return createHTTPSLink(url: url)
    }
    func createHTTPSLink(url:String?) -> String{
        guard let url = url else{return ""}
        return url.replacingOccurrences(of: "http", with: "https")
    }
    
    func getRating(rating:String?)->String{
        guard let rating = rating else{return ""}
        if rating == "Marvel Psr"{
            return "+9"
        }else if rating == "Rated T"{
            return "+13"
        }else{
            return "UnRating"
        }
    }
    
    func getYear(year: Int?) -> String {
        guard let yearText = year else {
            return "Unknown"
        }
        
        return String(yearText)
    }
    func extractCreatorsNames(from models: [CreatorsItem]?) -> [String] {
        if let creators = models{
            let names = creators.compactMap { $0.name }
            return names
        }
        return []
    }
}
