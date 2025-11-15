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
    func setFootageTags( _ tags: [FootageTag]) async -> (Result<[FootageTag], Error>)
}

extension UploadVideoData: UploadVideoSwiftDataSourceProtocol {
    
    func retrieveLocations() async -> Result<[Location], any Error> {
        let locationData = LocationData(dataService: dataService)
        return await locationData.retrieveLocations()
    }
    
    func setLocation(_ location: Location) async -> Result<Location, any Error> {
        let locationData = LocationData(dataService: dataService)
        let locationName = location.name
        let locationPredicate = #Predicate<Location> { loc in
            loc.name == locationName
        }
        let result = await locationData.retrieveLocations(predicate: locationPredicate, sortBy: .none)
        switch result {
        case .success(let locations):
            if locations.isEmpty {
                await locationData.addLocation(location: location)
                return .success(location)
            }else {
                return .success(location)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func retrieveSites() async -> Result<[Site], any Error> {
        let siteData = SiteData(dataService: dataService)
        return await siteData.retrieveSites()
    }
    
    func setSite(_ site: Site) async -> Result<Site, any Error> {
        let siteData = SiteData(dataService: dataService)
        let siteName = site.name
        let sitePredicate = #Predicate<Site> { site in
            site.name == siteName
        }
        let result = await siteData.retrieveSites(predicate: sitePredicate, sortBy: [SortDescriptor(\Site.name)])
        switch result {
        case .success(let sites):
            if sites.isEmpty {
                await siteData.addSite(site: site)
                return .success(site)
            }else {
                return .success(site)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func retrieveTransects() async -> Result<[Transect], any Error> {
        let transectData = TransectData(dataService: dataService)
        return await transectData.retrieveTransects()
    }
    
    func setTransect(_ transect: Transect) async -> Result<Transect, any Error> {
        let transectData = TransectData(dataService: dataService)
        let transectName = transect.name
        let transectPredicate = #Predicate<Transect> { transect in
            transect.name == transectName
        }
        let result = await transectData.retrieveTransects(predicate: transectPredicate, sortBy: [SortDescriptor(\Transect.name)])
        switch result {
        case .success(let transects):
            if transects.isEmpty {
                await transectData.addTransect(transect: transect)
                return .success(transect)
            }else {
                return .success(transect)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func setFootage(_ footage: Footage) async -> Result<Footage, any Error> {
        let footageData = FootageData(dataService: dataService)
        await footageData.addFootage(footage: footage)
        return .success(footage)
    }
    
    //TODO: - All footage tags that created always new, do we need to validate existing custom tags?
    func setFootageTags(_ tags: [FootageTag]) async -> Result<[FootageTag], any Error> {
        let footageTagsData = FootageTagsData(dataService: dataService)
        for tag in tags {
            await footageTagsData.addFootageTag(footageTag: tag)
        }
        return .success(tags)
    }
    
}

