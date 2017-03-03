//
//  Track.swift
//  Saturdays
//
//  Created by Said Ozcan on 11/27/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation
import Unbox

struct Track : ExternallyOpenable{
    let name: String
    let artist: String
    let spotifyID: String
    let albumArtURL: URL?
    
    var externalURL: URL {
        return URL(string: "spotify://")!
    }
}

extension Track: Unboxable {
    internal init(unboxer: Unboxer) throws{
        self.name = try unboxer.unbox(key: "name")
        self.artist = try unboxer.unbox(key: "artist")
        self.spotifyID = try unboxer.unbox(key: "spotify_id")
        self.albumArtURL = try URL(string: unboxer.unbox(key: "album_art_url"))
    }
}
