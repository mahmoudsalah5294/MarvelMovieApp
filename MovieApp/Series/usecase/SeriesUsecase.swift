//
//  SeriesUsecase.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 17/06/2023.
//

import Foundation

protocol SeriesUsecaseProtocol{
    func getSeries(completion: @escaping ResponseHandler<Series>)

}
class SeriesUsecase : SeriesUsecaseProtocol{
    let seriesDataSource:DataSourceProtocol = DataSource()
    
    func getSeries(completion: @escaping ResponseHandler<Series>) {
        let requestHandler = RequestHandler()
        let url = requestHandler.getURL()
        seriesDataSource.fetchSeries(url: url,completion: completion)
    }
}
