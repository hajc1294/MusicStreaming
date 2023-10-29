//
//  ViewController.swift
//  MusicStreaming
//
//  Created by Jean Carlo Hernández Arguedas on 26/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueAction(_ sender: Any) {
        performSegue(withIdentifier: "PlayListViewControllerSegue", sender: self)
    }
}

