//
//  DataManager.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/17.
//

import UIKit


final class DataManager {
    
    private var newArtist: [NewArtist] = []
    private var musicDetail: [MusicDetail] = []
    private var playList: [PlayList] = []
    
    private func fetchNewArtistData() {
        newArtist = [
            NewArtist(name: "Jason Kim", image: UIImage(named: "Artist01")!),
            NewArtist(name: "Jisu Kim", image: UIImage(named: "Artist02")!),
            NewArtist(name: "SeokHyeon Jang", image: UIImage(named: "Artist03")!),
            NewArtist(name: "Yeonjae Jeong", image: UIImage(named: "Artist04")!),
            NewArtist(name: "sia", image: UIImage(named: "Artist05")!),
            NewArtist(name: "Jason Kim", image: UIImage(named: "Artist05")!),
            NewArtist(name: "Jisu Kim", image: UIImage(named: "Artist04")!),
            NewArtist(name: "SeokHyeon Jang", image: UIImage(named: "Artist01")!),
            NewArtist(name: "Yeonjae Jeong", image: UIImage(named: "Artist02")!),
            NewArtist(name: "sia", image: UIImage(named: "Artist03")!)
        ]
    }
    
    public func getNewArtistData() -> [NewArtist] {
        fetchNewArtistData()
        return newArtist
    }
    
    private func fetchMusicData() {
        musicDetail = [
            MusicDetail(title: "Anti-Hero", artist: "Jisu Kim", image: UIImage(named: "Music01")),
            MusicDetail(title: "OKKKK", artist: "Jisu Kim", image: UIImage(named: "Music02")),
            MusicDetail(title: "let's go picnic", artist: "Jisu Kim", image: UIImage(named: "Music03")),
            MusicDetail(title: "gogo", artist: "Jisu Kim", image: UIImage(named: "Music04")),
            MusicDetail(title: "let's swift", artist: "Jisu Kim", image: UIImage(named: "Music05")),
            MusicDetail(title: "iOS Framework", artist: "Jisu Kim", image: UIImage(named: "Music06")),
            MusicDetail(title: "iPhone 14 Pro", artist: "Jisu Kim", image: UIImage(named: "Music07")),
            MusicDetail(title: "Die for you", artist: "Jisu Kim", image: UIImage(named: "Music08")),
            MusicDetail(title: "Surrender My Heart", artist: "Jisu Kim", image: UIImage(named: "Music09")),
            MusicDetail(title: "작은것들을 위한 시", artist: "Jisu Kim", image: UIImage(named: "Music10")),
            MusicDetail(title: "애국가", artist: "Jisu Kim", image: UIImage(named: "Music11")),
            MusicDetail(title: "육군가", artist: "Jisu Kim", image: UIImage(named: "Music12")),
            MusicDetail(title: "Pink Venom", artist: "Jisu Kim", image: UIImage(named: "Music13")),
            MusicDetail(title: "Holy", artist: "Jisu Kim", image: UIImage(named: "Music14")),
            MusicDetail(title: "Bad Omens", artist: "Jisu Kim", image: UIImage(named: "Music15"))
       ]
    }
    
    public func getMusicData() -> [MusicDetail] {
        fetchMusicData()
        return musicDetail
    }
    
    private func fetchPlayListData() {
        playList = [
            PlayList(title: "오늘의 POP", image: UIImage(named: "Music10")),
            PlayList(title: "오늘의 Jazz", image: UIImage(named: "Music03")),
            PlayList(title: "자주듣는 음악", image: UIImage(named: "Music08")),
            PlayList(title: "유명한 음악", image: UIImage(named: "Music04")),
            PlayList(title: "K-Pop 모음", image: UIImage(named: "Music12")),
            PlayList(title: "인도 음악", image: UIImage(named: "Music02"))
        ]
    }
    
    public func getPlayListData() -> [PlayList] {
        fetchPlayListData()
        return playList
    }
}
