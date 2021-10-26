//
//  SearchWineTC.swift
//  Prototype-SearchList
//
//  Created by 이동규 on 2021/10/26.
//

import Foundation
import UIKit

class SearchWineTC: UITableViewController {
    
    var wineModel = WineModel()
    var filteredWine = [Wine]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        setUpWineLists()
    }
    
    func setUpWineLists() {
        self.wineModel.loadFromJson()
        self.filteredWine = self.wineModel.wineList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setUpSearchController() {
        //헤더뷰 지정
        //self.tableView.tableHeaderView = self.searchController.searchBar
        
        //디테일 세팅
        self.searchController.searchBar.placeholder = "Seach wine from lists"
        self.searchController.searchResultsUpdater = self // 중요. 사용자가 검색한 값에 따라 업데이트
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.searchBarStyle = .prominent
        self.searchController.searchBar.sizeToFit()
        self.navigationItem.searchController = self.searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.isFiltering ? self.filteredWine.count : self.wineModel.wineList.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID-SearchWineCell", for: indexPath) as! SearchWineCell
        
        // 검색때는 필터링 로우로 바꾸기
        let row = self.isFiltering ? self.filteredWine[indexPath.row] : self.wineModel.wineList[indexPath.row]
        
        cell.wineNameLabel.text = row.nameEng
        cell.wineCountryLabel.text = row.manufactureCountry
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ID-Manual-SearchTC-DetailVC", sender: self)
    }
    
}

// MARK: - 서치바 관련
extension SearchWineTC: UISearchResultsUpdating {

    /*
    filteredLocation = allLocations.filter({ (location) -> Bool in
                   return location.city.lowercased().contains(searchText.lowercased()) || location.country.lowercased().contains(searchText.lowercased())
               })
    */
    
    func filteredContentForSearchText(_ searchText:String){
        self.filteredWine = wineModel.wineList.filter({ wine -> Bool in
            return wine.nameEng.uppercased().contains(searchText.uppercased()) || wine.manufactureCountry.contains(searchText)
        })
        self.tableView.reloadData()
    }
    
    // 서치 컨트롤 글자 바뀔 때마다 호출되는 함수
    func updateSearchResults(for searchController: UISearchController) {
        print(#function)
        filteredContentForSearchText(searchController.searchBar.text ?? "")
    }

}
