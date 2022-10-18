//
//  DataManager.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/17.
//

import UIKit


class DataManager {
    
    var newArtist: [NewArtist] = []
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
        music = [
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music01")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music02")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music03")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music04")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music05")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music06")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music07")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music08")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music09")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music10")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music11")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music12")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music13")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music14")),
            Music(title: "TeseTitle", artist: "Jisu Kim", image: UIImage(named: "Music15")),
        ]
    }
    
    public func getMusicData() -> [Music] {
        fetchMusicData()
        return music
    }
}
