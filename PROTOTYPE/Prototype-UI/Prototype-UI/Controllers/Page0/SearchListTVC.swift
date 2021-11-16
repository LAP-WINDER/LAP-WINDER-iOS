//
//  SearchListTVC.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/15.
//

import Foundation
import UIKit

class SearchListTVC: UITableViewController {
    
    var wineModel = WineModel()
    var filteredWine = [Wine]()
    
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var searchFilterStackView: UIStackView!
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSearchController()
        self.setUpTableView()
        self.setUpWineLists()
        self.setUpSearchFilterStackView()
    }
    
    private func setUpSearchFilterStackView() {
        self.searchFilterStackView.spacing = 8
        
        for _ in 0..<6 {
            /*
            let view = UIView(frame: CGRect(x: self.searchFilterStackView.frame.minX, y: self.searchFilterStackView.frame.minY, width: self.searchFilterStackView.frame.height * 1.3, height: self.searchFilterStackView.frame.height))
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: self.searchFilterStackView.frame.height * 1.3).isActive = true
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
            
            print(view.frame, view.layer.frame, view.center)
            let label = UILabel(frame: CGRect(x: view.frame.midX, y: view.frame.midY, width: view.frame.width, height: view.frame.height))
            //let label = UILabel()
            label.center = CGPoint(x: view.center.x, y: view.center.y)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
            label.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
            
            label.text = "전체"
            label.textColor = UIColor.getWinderColor(.darknavy)
            
        
            print(view.frame, view.layer.frame)
            let btn = UIButton(frame: CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: view.frame.height))
            print(btn.frame)
            btn.center = CGPoint(x: view.center.x, y: view.center.y)
            btn.setTitle("전체", for: .normal)
            btn.setTitleColor(UIColor.getWinderColor(.darknavy), for: .normal)
            btn.setTitleColor(btn.titleColor(for: .highlighted) , for: .highlighted)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.addTarget(self, action: #selector(btn2filtered(sender:)), for: .touchUpInside)
            view.addSubview(btn)
            view.addSubview(label)
            */
            
            let btn = UIButton()
            btn.widthAnchor.constraint(equalToConstant: self.searchFilterStackView.frame.height * 1.5).isActive = true
            btn.layer.cornerRadius = 20
            btn.backgroundColor = .white
            btn.setTitle("전체", for: .normal)
            btn.setTitleColor(UIColor.getWinderColor(.darknavy), for: .normal)
            btn.setTitleColor(btn.titleColor(for: .highlighted) , for: .highlighted)
            btn.titleLabel?.font = .systemFont(ofSize: CGFloat(17.0) , weight: .semibold)
            //btn.translatesAutoresizingMaskIntoConstraints = false
            //btn.accessibilityIdentifier = "전체"  //각 아이디에 맞게
            btn.addTarget(self, action: #selector(btn2filtered(sender:)), for: .touchUpInside)
            
            self.searchFilterStackView.addArrangedSubview(btn)
        }
    }
    
    // 척도에 따라서 필터 기능 추가 필요
    @objc
    func btn2filtered(sender: UIGestureRecognizer) {
        print(#function)
        guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "ID-PopUpToFilterVC") else { return }
        popupVC.modalPresentationStyle = .overFullScreen
        self.present(popupVC, animated: true, completion: nil)
    }
    
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setUpWineLists() {
        self.wineModel.loadFromJson()
        self.filteredWine = self.wineModel.wineList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setUpSearchController() {
        self.searchController.searchBar.placeholder = "Seach wine from list"
        self.searchController.searchResultsUpdater = self // 중요. 사용자가 검색한 값에 따라 업데이트
        //
        //self.searchController.searchBar.scopeButtonTitles = ["전체", "종류", "맛", "국가", "품종", "가격"]
        //self.searchController.searchBar.showsScopeBar = true
        //
        self.searchController.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.searchBarStyle = .prominent
        self.searchController.searchBar.sizeToFit()
        self.navigationItem.searchController = self.searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //+
}

// MARK: - 테이블뷰 델리게이트&데이터소스 구현
extension SearchListTVC {
    
    // 섹션 별 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return (self.isFiltering ? self.filteredWine.count : self.wineModel.wineList.count)
        return 1
    }
    
    // 대신 섹션 개수를 원래 대로
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (self.isFiltering ? self.filteredWine.count : self.wineModel.wineList.count)
    }
    
    // 셀 섹션 헤더높이
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    
    // 셀 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID-SearchWineCell", for: indexPath) as! SearchWineCell
        
        // 검색때는 필터링 로우로 바꾸기 -> 섹션으로 커스텀함
        let row = self.isFiltering ? self.filteredWine[indexPath.section] : self.wineModel.wineList[indexPath.section]
        
        cell.wineTitleLabel.text = row.nameEng
        cell.wineCountryLabel.text = row.manufactureCountry
        cell.wineExportByLabel.text = row.exportCountry
        cell.wineMadeByLabel.text = row.exportCountry
        cell.wineImageView.image = UIImage(named: "wine_sample.png")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ID-Manual-SearchTC-WineInfoVC", sender: self)
    }
}

// MARK: - 서치바 세팅
extension SearchListTVC: UISearchResultsUpdating {
    
    func filteredContentForSearchText(_ searchText:String){
        self.filteredWine = wineModel.wineList.filter({ wine -> Bool in
            return wine.nameEng.uppercased().contains(searchText.uppercased()) || wine.manufactureCountry.contains(searchText)
        })
        self.tableView.reloadData()
    }
    
    // 서치 컨트롤 글자 바뀔 때마다 호출되는 함수
    func updateSearchResults(for searchController: UISearchController) {
        //print(#function)
        filteredContentForSearchText(searchController.searchBar.text ?? "")
    }

}
