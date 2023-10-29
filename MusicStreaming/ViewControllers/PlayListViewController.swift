//
//  PlayListViewController.swift
//  MusicStreaming
//
//  Created by Jean Carlo Hernández Arguedas on 26/10/23.
//

import UIKit
import RxSwift
import RxCocoa

class PlayListViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    let playListViewModel = PlayListViewModel()
    let activityIndicatorUtil = ActivityIndicatorUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
        getData()
    }
    
    func subscribe() {
        playListViewModel.viewModelStatus.asObservable().subscribe(onNext: { [weak self] (value) in
            if let strongSelf = self {
                
                switch value {
                    case ViewModelStatus.loading:
                        strongSelf.activityIndicatorUtil.showActivityIndicator(uiView: strongSelf.view)
                        break
                    case ViewModelStatus.success:
                        strongSelf.tableView.reloadData()
                        strongSelf.activityIndicatorUtil.hideActivityIndicator(uiView: strongSelf.view)
                        break
                    default:
                        strongSelf.activityIndicatorUtil.hideActivityIndicator(uiView: strongSelf.view)
                        break
                    
                }
                
                
                if value == ViewModelStatus.success {
                    strongSelf.tableView.reloadData()
                }
            }
        }).disposed(by: disposeBag)
    }
    
    func getData() {
        playListViewModel.getPlayList()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        headerCell.setUp(count: playListViewModel.getNumberOfRows())
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playListViewModel.isEmpty() ? 1 : playListViewModel.getNumberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if playListViewModel.isEmpty() {
            return tableView.dequeueReusableCell(withIdentifier: "EmptyCell")!
        } else {
            let songCell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
            songCell.setUp(song: playListViewModel.elementAt(index: indexPath.row))
            return songCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return playListViewModel.isEmpty() ? 500 : 72
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PlayerViewControllerSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayerViewControllerSegue" {
            if let viewController = segue.destination as? PlayerViewController {
                viewController.playerViewModel = PlayerViewModel(playList: playListViewModel.playList, currentSong: (tableView.indexPathForSelectedRow?.row)!)
            }
        }
    }
}
