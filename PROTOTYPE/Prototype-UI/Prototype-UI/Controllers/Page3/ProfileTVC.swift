//
//  ProfileTVC.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/13.
//

import Foundation
import UIKit

class ProfileTVC: UITableViewController {
    
    @IBOutlet weak var profilebackView: UIView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileBtn: UIButton!
    
    let cellIdentifiers = [
        "cell": "cell"
    ]
    
    let korean: [String] = ["가", "나", "다", "라"]
    let english: [String] = ["a", "b", "c", "d"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfileViewSection()
        setUpLogInandOutCell()
        setUptableView()
    }
    
    func setUptableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setUpProfileViewSection() {
        self.profilebackView.layer.cornerRadius = 20
        self.profilebackView.backgroundColor = UIColor(displayP3Red: 126/255, green: 54/255, blue: 254/255, alpha: 1.0)
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        self.profileImageView.image = UIImage(named: "profile_img.png")
        self.editProfileBtn.layer.cornerRadius = self.editProfileBtn.frame.height / 4
    }
    
    func setUpLogInandOutCell() {
        
    }
    
    //
}

// MARK: -- UITableViewDelegate, UITableViewDataSource 익스텐션으로 분기
extension ProfileTVC {
    
    // 원하는 섹션 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {  // 각 섹션마다 다른 갯수를 돌려줄 것
            case 0:  // tableView의 section은 0부터 시작
                return korean.count  // 한글 array의 갯수만큼 돌려줌
            case 1:
                return english.count  // 영어 array의 갯수만큼 돌려줌
            default:
                return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "User Archives" : "Informations"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //순서: 셀인스턴스생성 - 셀로우랑 결합 - 데이터뭐로할건지 - 리턴
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers["cell"]!, for: indexPath)
        
        let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
        
        cell.textLabel?.text = text  // 셀에 표현될 데이터
        
        return cell
    }
    
    
}
