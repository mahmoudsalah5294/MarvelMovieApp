//
//  Response.swift
//  NewsApp
//
//  Created by Mahmoud Mohamed on 17/06/2023.
//

import Foundation

struct Response<T: Codable>{
    var data: T?
    var message: String?
    var status: ResponseStatus?
}

enum ResponseStatus{
    case success, failure
}
