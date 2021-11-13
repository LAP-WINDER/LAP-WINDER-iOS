//
//  NewsContentsView.swift
//  Winder
//
//  Created by 이동규 on 2021/11/12.
//

import Foundation
import UIKit

class NewsContentsView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var contentsPath = ["42.jpg", "42.jpg", "42.jpg"]
    
    func setUpStackView(completion: @escaping (UIImageView) -> ()) {
        self.stackView.spacing = 10
        
        var contentsPaths = [String]()
        
        HomepageAPIManager().requestContentsInfo(HomeContentInfo(label: .news, page: 3)) { nsdict, error in
            if let error = error {
                print(#function, error.localizedDescription)
            } else if let nsdict = nsdict {
                print(nsdict)
            }
        }
        
        
        for i in 0..<contentsPath.count {
            let uiImageview = UIImageView()
            uiImageview.image = UIImage(named: self.contentsPath[i])
            uiImageview.layer.cornerRadius = 25
            uiImageview.clipsToBounds = true
            uiImageview.isUserInteractionEnabled = true
            uiImageview.widthAnchor.constraint(equalToConstant: self.stackView.frame.height).isActive = true
            self.stackView.addArrangedSubview(uiImageview)
            completion(uiImageview)
        }
    }
}
