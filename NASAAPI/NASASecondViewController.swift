//
//  NASASecondViewController.swift
//  NASAAPI
//
//  Created by Ｇary on 2019/05/16.
//  Copyright © 2019 Ｇary. All rights reserved.
//

import UIKit

class NASASecondViewController: UIViewController {

    var nasa: NASAData!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    
    func upDateUI() {
        navigationItem.title = nasa.date
        titleLB.text = nasa.title
        descriptionTV.text = nasa.explanation
        NasaController.shared.fetchImage(url: nasa.url){(image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upDateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
