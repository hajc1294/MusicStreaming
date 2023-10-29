//
//  PlayerViewController.swift
//  MusicStreaming
//
//  Created by Jean Carlo Hernández Arguedas on 26/10/23.
//

import UIKit
import RxSwift
import RxCocoa

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songInfoLabel: UILabel!
    @IBOutlet weak var songYearLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songSlider: UISlider!
    @IBOutlet weak var songCurrentLabel: UILabel!
    @IBOutlet weak var songDurationLabel: UILabel!
    
    let disposeBag = DisposeBag()
    let activityIndicatorUtil = ActivityIndicatorUtil()
    var playerViewModel: PlayerViewModel!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        subscibe()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        playerViewModel.disposePlayer()
        super.viewWillDisappear(animated)
    }
    
    func initUI() {
        let song = playerViewModel.getCurrentSong()
        songNameLabel.text = song.name
        songInfoLabel.text = "\(song.band) • \(song.album)"
        songYearLabel.text = song.year
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 14)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        songSlider.setThumbImage(image, for: .normal)
        songSlider.setThumbImage(image, for: .highlighted)
        songSlider.addTarget(self, action: #selector(seekSongTime), for: .valueChanged)
        
        ImageDownloader.imageDownloader(url: song.image) { [weak self] data in if let strongSelf = self {
                strongSelf.songImageView.image = UIImage(data: data)
            }
        }
        
        timerSliderListener()
    }
    
    func subscibe() {
        playerViewModel.isPlaying.asObservable().subscribe(onNext: { [weak self] (value) in if let strongSelf = self {
                strongSelf.playButton.setImage(UIImage(systemName: value ? "pause.circle" : "play.circle"), for: .normal)
            }
        }).disposed(by: disposeBag)
        
        playerViewModel.viewModelStatus.asObservable().subscribe { [weak self] (value) in if let strongSelf = self {
                switch value {
                    case ViewModelStatus.loading:
                        strongSelf.activityIndicatorUtil.showActivityIndicator(uiView: strongSelf.view)
                        break
                    case ViewModelStatus.success:
                        let seconds = strongSelf.playerViewModel.getSongDuration()
                        strongSelf.setUpSlideBar(seconds: seconds, isDuration: true)
                        strongSelf.activityIndicatorUtil.hideActivityIndicator(uiView: strongSelf.view)
                        break
                    default:
                        strongSelf.activityIndicatorUtil.hideActivityIndicator(uiView: strongSelf.view)
                        break
                }
            }
        }.disposed(by: disposeBag)
    }
    
    func setUpSlideBar(seconds: Float, isDuration: Bool) {
        let secondsValue = String(format: "%02d", Int(seconds) % 60)
        let minutesValue = String(format: "%02d", Int(seconds) / 60)
        if (isDuration) {
            songDurationLabel.text = "\(minutesValue):\(secondsValue)"
            songSlider.maximumValue = seconds
        } else {
            songCurrentLabel.text = "\(minutesValue):\(secondsValue)"
            songSlider.value = seconds
        }
    }
    
    func timerSliderListener() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
    }
    
    @IBAction func playAction(_ sender: Any) {
        if playerViewModel.isPlaying.value {
            playerViewModel.stopSong()
        } else {
            playerViewModel.playSong()
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        timer.invalidate()
        playerViewModel.playNextSong()
        initUI()
    }
    
    @IBAction func prevButtonAction(_ sender: Any) {
        timer.invalidate()
        playerViewModel.playPrevSong()
        initUI()
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func updateSlider() {
        let seconds = playerViewModel.getSongCurrentTime()
        setUpSlideBar(seconds: seconds, isDuration: false)
    }
    
    @objc func seekSongTime() {
        timer.invalidate()
        playerViewModel.updateSongCurrentTime(position: songSlider.value)
        timerSliderListener()
    }
}
