//
//  TrackViewModel.swift
//  Saturdays
//
//  Created by Said Ozcan on 13/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class TrackViewModel : NSObject, ViewModelProtocol {
    
    // MARK : Properties
    let trackName : String
    let artistName : String
    let albumArtUrl : URL
    let albumArtSize: CGSize?
    let deeplinkURL : URL
    
    // MARK : Lifecycle
    init(with track:Track) {
        self.trackName = track.name
        self.artistName = track.artist
        self.albumArtUrl = track.albumArt.url
        self.albumArtSize = track.albumArt.size
        self.deeplinkURL = track.externalURL
        super.init()
    }
}
