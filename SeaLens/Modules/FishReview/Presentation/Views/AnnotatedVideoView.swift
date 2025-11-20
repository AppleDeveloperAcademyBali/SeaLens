//
//  AnnotatedVideoView.swift
//  SeaLens
//
//  Created by Handy Handy on 09/11/25.
//

import SwiftUI
import AVKit

struct AnnotatedVideoView: View {
    @State private var player = AVPlayer()
    
    var body: some View {
        GeometryReader { geometry in
            VStack (alignment: .leading, spacing: 4) {
                Text("Annotated Video")
                    .textstyles(.title2MediumRounded)
                Text("Total 2.000 fish detected")
                    .textstyles(.bodyRegular)
                    .opacity(0.5)
                
                VideoPlayer(player: player)
                    .frame(height: geometry.size.width * (9/16))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .onAppear {
                        let url = URL(string: "https://embed-ssl.wistia.com/deliveries/cc8402e8c16cc8f36d3f63bd29eb82f99f4b5f88/accudvh5jy.mp4")!
                        player = AVPlayer(url: url)
                        player.play()
                        
                    }
                    .onDisappear {
                        player.pause()
                    }
                    .padding(.top)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    AnnotatedVideoView()
}
