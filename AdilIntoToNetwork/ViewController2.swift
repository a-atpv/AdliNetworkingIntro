//
//  ViewController2.swift
//  AdilIntoToNetwork
//
//  Created by Aldiyar Aitpayev on 23.07.2025.
//

import UIKit
import Kingfisher

class ViewController2: UIViewController {
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(image)
        image.kf.setImage(with: URL(string: "https://thronesapi.com/assets/images/catelyn-stark.jpg")!)
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(200)
        }

        // Do any additional setup after loading the view.
    }
    


}
