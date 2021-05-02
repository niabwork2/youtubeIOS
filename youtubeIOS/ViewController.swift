//
//  ViewController.swift
//  youtubeIOS
//
//  Created by niab on Apr/25/21.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.getVideos()
        
        
        
        
    }


}

