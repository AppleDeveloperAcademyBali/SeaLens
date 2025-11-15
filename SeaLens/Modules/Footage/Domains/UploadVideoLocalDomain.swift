//
//  UploadVideoLocalDomain.swift
//  SeaLens
//
//  Created by Handy Handy on 08/11/25.
//

import Foundation

protocol UploadVideoLocalDomainProtocol {
    func getLocations() async -> [Location]
    func getSites() async -> [Site]
    func getTransects() async -> [Transect]
    func setFootage(footage: Footage) async
}

extension UploadVideoDomain: UploadVideoLocalDomainProtocol {
    
    func getLocations() async -> [Location] {
        let result = await uploadVideoData.retrieveLocations()
        switch result {
        case .success(let locations):
            return locations
        case .failure:
            return []
        }
    }
    
    func getSites() async -> [Site] {
        let result = await uploadVideoData.retrieveSites()
        switch result {
        case .success(let sites):
            return sites
        case .failure:
            return []
        }
    }
    
    func getTransects() async -> [Transect] {
        let result = await uploadVideoData.retrieveTransects()
        switch result {
        case .success(let transects):
            return transects
        case .failure:
            return []
        }
    }
    
    func setFootage(footage: Footage) async {
        let _ = await uploadVideoData.setFootage(footage)
        let _ = await uploadVideoData.setLocation(Location(name: footage.locationName))
        let _ = await uploadVideoData.setSite(Site(name: footage.siteName))
        let _ = await uploadVideoData.setTransect(Transect(name: footage.transect))
        let _ = await uploadVideoData.setFootageTags(footage.footageTags ?? [])
        
    }
    
}
