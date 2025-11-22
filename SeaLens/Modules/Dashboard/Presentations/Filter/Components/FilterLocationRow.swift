//
//  FilterLocationRow.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 21/11/25.
//

import SwiftUI

struct FilterLocationRow: View {
    @ObservedObject var location: LocationForChartFilter
    
    var onLocationSelectionChanged: (() -> Void)?
    var onSiteSelectionChanged: ((SiteForChartFilter) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // LOCATION
            HStack(alignment: .top, spacing: 8) {
                // Location
                Button {
                    withAnimation {
                        // Toggle location's selected
                        location.isSelected.toggle()
                        
                        onLocationSelectionChanged?()
                    }
                } label: {
                    Image(systemName: location.isSelected ? "checkmark.square.fill" : "square")
                        .foregroundColor(location.isSelected ? .blue : .gray)
                        .font(.system(size: 20))
                }
                .buttonStyle(.plain)
                
                Text(location.location)
                    .textstyles(.bodyMedium)
                
                Spacer()
                
            }
            
            // SITES
            ForEach(location.sites) { site in
                HStack(alignment: .top) {
                    // Site
                    Button {
                        withAnimation {
                            // Toggle site's selected
                            site.isSelected.toggle()
                            
                            onSiteSelectionChanged?(site)
                        }
                    } label: {
                        Image(systemName: site.isSelected ? "checkmark.square.fill" : "square")
                            .foregroundColor(site.isSelected ? .blue : .gray)
                            .font(.system(size: 20))
                    }
                    .buttonStyle(.plain)
                    
                    Text(site.site)
                        .textstyles(.bodyMedium)
                    
                    Spacer()
                }
                .padding(.leading, 20)
            }
        }
        .padding(.bottom, 8)
    }
}

