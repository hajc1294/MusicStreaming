//
//  DataViewModel.swift
//  MusicStreaming
//
//  Created by Jean Carlo Hernández Arguedas on 26/10/23.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseFirestore
import FirebaseStorage

class PlayListViewModel {
    
    lazy var viewModelStatus = BehaviorRelay<ViewModelStatus>(value: ViewModelStatus.loading)
    var playList: [Song] = []
    
    func getNumberOfRows() -> Int {
        return playList.count
    }
    
    func elementAt(index: Int) -> Song {
        return playList[index]
    }
    
    func isEmpty() -> Bool {
        return playList.count == 0
    }
    
    func getPlayList() {
        Firestore.firestore().collection("songs").getDocuments { [weak self] (snapshot, error) in if let strongSelf = self {
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let song = Song(name: document.data()["name"] as! String,
                                        band: document.data()["band"] as! String,
                                        album: document.data()["album"] as! String,
                                        year: document.data()["year"] as! String,
                                        image: document.data()["image"] as! String,
                                        resource: document.data()["resource"] as! String)
                        strongSelf.playList.append(song)
                    }
                    strongSelf.viewModelStatus.accept(ViewModelStatus.success)
                } else {
                    print(error ?? "error")
                    strongSelf.viewModelStatus.accept(ViewModelStatus.error)
                }
            }
        }
    }
}
