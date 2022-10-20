//
//  DataManager.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/17.
//

import UIKit


class DataManager {
    
    var newArtist: [NewArtist] = []
    var musicDetail: [MusicDetail] = []
    var music: [Music] = []
    
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
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music01")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music02")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music03")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music04")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music05")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music06")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music07")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music08")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music09")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music10")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music11")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music12")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music13")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music14")),
            MusicDetail(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music15"))
       ]
    }
    
    public func getMusicData() -> [MusicDetail] {
        fetchMusicData()
        return musicDetail
    }
}
