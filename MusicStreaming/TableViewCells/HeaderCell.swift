//
//  HeaderCell.swift
//  MusicStreaming
//
//  Created by Jean Carlo Hernández Arguedas on 26/10/23.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var countSongsLabel: UILabel!
    
    func setUp(count: Int) {
        countSongsLabel.text = "\(String(count)) canciones disponibles" 
    }
}
