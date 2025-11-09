//
//  UploadVideoDataSource.swift
//  SeaLens
//
//  Created by Handy Handy on 08/11/25.
//

import Foundation

protocol UploadVideoSwiftDataSourceProtocol {
    func retrieveLocations() async -> (Result<[Location], Error>)
    func setLocation(_ location: Location) async -> (Result<Location, Error>)
    func retrieveSites() async -> (Result<[Site], Error>)
    func setSite(_ site: Site) async -> (Result<Site, Error>)
    func retrieveTransects() async -> (Result<[Transect], Error>)
    func setTransect(_ transect: Transect) async -> (Result<Transect, Error>)
    func setFootage(_ footage: Footage) async -> (Result<Footage, Error>)
    func setFootageTags( _ tags: [FootageTags]) async -> (Result<[FootageTags], Error>)
}

extension UploadVideoData: UploadVideoSwiftDataSourceProtocol {
    
    func retrieveLocations() async -> Result<[Location], any Error> {
        let locationData = LocationData(dataService: dataService)
        return await locationData.retrieveLocations()
    }
    
    func setLocation(_ location: Location) async -> Result<Location, any Error> {
        let locationData = LocationData(dataService: dataService)
        await locationData.addLocation(location: location)
        return .success(location)
    }
    
    func retrieveSites() async -> Result<[Site], any Error> {
        let siteData = SiteData(dataService: dataService)
        return await siteData.retrieveSites()
    }
    
    func setSite(_ site: Site) async -> Result<Site, any Error> {
        let siteData = SiteData(dataService: dataService)
        await siteData.addSite(site: site)
        return .success(site)
    }
    
    func retrieveTransects() async -> Result<[Transect], any Error> {
        let transectData = TransectData(dataService: dataService)
        return await transectData.retrieveTransects()
    }
    
    func setTransect(_ transect: Transect) async -> Result<Transect, any Error> {
        let transectData = TransectData(dataService: dataService)
        await transectData.addTransect(transect: transect)
        return .success(transect)
    }
    
    func setFootage(_ footage: Footage) async -> Result<Footage, any Error> {
        let footageData = FootageData(dataService: dataService)
        await footageData.addFootage(footage: footage)
        return .success(footage)
    }
    
    //TODO: - All footage tags that created always new, do we need to validate existing custom tags?
    func setFootageTags(_ tags: [FootageTags]) async -> Result<[FootageTags], any Error> {
        let footageTagsData = FootageTagsData(dataService: dataService)
        for tag in tags {
            await footageTagsData.addFootageTag(footageTag: tag)
        }
        return .success(tags)
    }
    
}

