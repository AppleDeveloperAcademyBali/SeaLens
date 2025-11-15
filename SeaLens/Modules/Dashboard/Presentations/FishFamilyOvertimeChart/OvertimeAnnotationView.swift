//
//  DataPointHoverView.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 12/11/25.
//

import SwiftUI

struct OvertimeAnnotationView: View {
    @State var selectedFamilyName: String
    @State var selectedDate: Date
    @State var selectedColor: Color
    
    var body: some View {
        VStack {
            ColorCode(color: selectedColor, title: selectedFamilyName , subtitle: "30 total fish counted (from 12 observations)")
            Text(selectedDate.formatted())
            
            Text("KEY INSIGHT")
                .textstyles(.caption1Regular)
            
            // TODO: Key Insight
            
            Divider()
            
            Text("LOCATION BREAKDOWN")
                .textstyles(.caption1Regular)
            
            // TODO: Bar Chart for each location
            
            // TODO: NavigationLink to Recent Observations
        }
        .overlay {
            RoundedRectangle(cornerRadius: 32)
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(.gray)
        }
    }
}

/*#Preview {
    OvertimeAnnotationView()
}*/
