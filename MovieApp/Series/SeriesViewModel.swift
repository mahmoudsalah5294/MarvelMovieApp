//
//  SeriesViewModel.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 17/06/2023.
//

import Foundation
protocol SeriesViewModelProtocol{
    var updateUI : ((_ series : [Result]?) -> Void)? { get set}
    func getSeries()
    func getSeriesByTitle(title:String)
    func getCreator(items:[CreatorsItem]?)->[String]
}

class SeriesViewModel : SeriesViewModelProtocol{
    
    var updateUI : ((_ series : [Result]?) -> Void)?
    var usecase : SeriesUsecaseProtocol?
    init(usecase:SeriesUsecaseProtocol) {
        self.usecase = usecase
    }
    
    func getSeries(){
        usecase?.getSeries(completion: { (response) in
            switch(response.status!){
            case .success:
                if let data = response.data{
                    let series = data.data?.results
                    self.updateUI?(series)
                }
            case .failure:
                if response.message != nil{
                    print("Error: \(response.message ?? "error unkonwn")")
                }
            }
        })
    }
    func getSeriesByTitle(title:String){
        usecase?.getSeries(completion: { (response) in
            switch(response.status!){
            case .success:
                if let data = response.data{
                    let series = data.data?.results
                    let filteredSeries = self.getFilteredSeries(title: title, series: series)
                    self.updateUI?(filteredSeries)
                }
            case .failure:
                if response.message != nil{
                    print("Error: \(response.message ?? "error unkonwn")")
                }
            }
            
        })
    }
    func getCreator(items:[CreatorsItem]?)->[String]{
        let dataHandler = DataHandler()
        return dataHandler.extractCreatorsNames(from: items)
    }
    private func getFilteredSeries(title:String,series:[Result]?)->[Result]?{
        if title.isEmpty{
            return series ?? nil
        }else{
            return series?.filter{$0.title?.contains(title) ?? false}
        }
    }
}







