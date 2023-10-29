//
//  SongCell.swift
//  MusicStreaming
//
//  Created by Jean Carlo Hernández Arguedas on 26/10/23.
//

import UIKit

class SongCell: UITableViewCell {
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songInfoLabel: UILabel!
    @IBOutlet weak var songDurationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setUp(song: Song) {
        songNameLabel.text = song.name
        songInfoLabel.text = "\(song.band) • \(song.album)"
        songDurationLabel.text = song.duration
        retrieveImage(url: song.image)
    }
    
    func retrieveImage(url: String) {
        ImageDownloader.imageDownloader(url: url) { [weak self] data in if let strongSelf = self {
                strongSelf.songImageView.image = UIImage(data: data)
            }
        }
    }
}
