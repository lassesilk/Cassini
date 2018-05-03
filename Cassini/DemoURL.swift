//
//  DemoURL.swift
//  Cassini
//
//  Created by Lasse Silkoset on 15.12.2017.
//  Copyright © 2017 Lasse Silkoset. All rights reserved.
//

import Foundation


struct DemoURL
{
    static let stanford = URL(string: "https://d2btg9txypwkc4.cloudfront.net/media/catalog/category/Kampanjer_1.jpg")
    static var NASA: Dictionary<String,URL> = {
        let NASAURLStrings = [
            "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth" : "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
