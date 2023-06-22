//
//  ViewController.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 16/06/2023.
//

import UIKit

class SeriesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var seriesTableView: UITableView!
    
    var usecase : SeriesUsecaseProtocol?
    var viewModel : SeriesViewModelProtocol?
    var series : [Result] = []
    var expandedStates : [IndexPath:Bool] = [:]
    var cell : SeriesTableViewCell?
    var isOpen : [Bool] = []
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        usecase = SeriesUsecase()
        viewModel = SeriesViewModel(usecase: usecase ?? SeriesUsecase())
        viewModel?.getSeries()
        viewModel?.updateUI = { [weak self] value in
            if let data = value{
                self?.isOpen = Array(repeating: false, count: data.count)
                self?.series = data
                self?.seriesTableView.reloadData()
                self?.registerCell()
            }
        }
    }
    
    
    func registerCell(){
        seriesTableView.delegate = self
        seriesTableView.dataSource = self
        
        seriesTableView.register(UINib(nibName: "SeriesTableViewCell", bundle: nil), forCellReuseIdentifier: "SeriesTableViewCellView")
        seriesTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCellView")
        seriesTableView.separatorStyle = .none
        seriesTableView.reloadData()
    }
}
extension SeriesViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.series.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isOpen[section]{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesTableViewCellView", for: indexPath) as! SeriesTableViewCell
            
            cell.setupCell(model: self.series[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCellView", for: indexPath) as! DescriptionTableViewCell
            let creators = viewModel?.getCreator(items: self.series[indexPath.section].creators?.items)
            cell.setupCell(name:creators?[indexPath.row - 1] ?? "")
            return cell

        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        isOpen[indexPath.section] = !isOpen[indexPath.section]
        tableView.reloadSections([indexPath.section], with: .automatic)
    }
    
}

extension SeriesViewController:UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search: \(searchBar.text ?? "")")
        viewModel?.getSeriesByTitle(title: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.searchBar.endEditing(true)
        viewModel?.getSeriesByTitle(title: "")
    }
    
}
