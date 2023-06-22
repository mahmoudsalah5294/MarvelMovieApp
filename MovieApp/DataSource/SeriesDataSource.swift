//
//  SeriesDataSource.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 17/06/2023.
//

import Foundation

protocol DataSourceProtocol{
    
    func fetchSeries(url:String,completion: @escaping ResponseHandler<Series>)
}

class DataSource:DataSourceProtocol{
    func fetchSeries(url:String,completion: @escaping ResponseHandler<Series>) {        
        NetworkRequestHandler.shared.get(url: url, completion: completion)
    }
}
