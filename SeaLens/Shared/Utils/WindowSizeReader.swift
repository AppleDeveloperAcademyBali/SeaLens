//
//  WindowSizeReader.swift
//  SeaLens
//
//  Created by Handy Handy on 09/11/25.
//

import Foundation
import SwiftUI

struct WindowSizeReader: NSViewRepresentable {
    @Binding var size: CGSize
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let window = view.window {
                self.size = window.frame.size // Get window size
                NotificationCenter.default.addObserver(forName: NSWindow.didResizeNotification, object: window, queue: .main) { _ in
                    self.size = window.frame.size
                }
            }
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}
