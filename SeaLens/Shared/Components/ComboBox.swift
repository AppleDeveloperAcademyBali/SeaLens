//
//  ComboBox.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 25/10/2025.
//

import SwiftUI
import AppKit


// swiftUI wrapper around macOS 'NSComboBox' (editable dropdown field
struct ComboBox: NSViewRepresentable {
    
    // text entered
    @Binding var text: String
    
    // dropdown list
    var values: [String]
    
    // optional placeholder when textfield is empty
    var placeholder: String?
    
    
    // MARK: - Create The AppKit View
    func makeNSView(context: Context) -> NSComboBox {
        
        let combo = NSComboBox()
        
        // behave like dropdown
        combo.usesDataSource = false
        
        // autocompletion
        combo.completes = true
        
        // allows user to type freely
        combo.isEditable = true
        
        // to detect text and selection changes
        combo.delegate = context.coordinator
        
        // inital dropdown values
        combo.addItems(withObjectValues: values)
        
        // set starting text
        combo.stringValue = text
        
        // set placeholder if available
        if let placeholder {
            combo.placeholderString = placeholder
        }
        
        return combo
    }
    
    
    // MARK: - Update View When SwiftUI State Changes
    func updateNSView(_ nsView: NSComboBox, context: Context) {
        
        // update when list changes
        if nsView.objectValues as? [String] != values {
            nsView.removeAllItems()
            nsView.addItems(withObjectValues: values)
            
        }
        
        // updating AppKit combo if it doesn't match SwiftUI state
        if nsView.stringValue != text {
            nsView.stringValue = text
        }
    }
        
        
    // MARK: - Coordinator (bridge for delegate methods)
    func makeCoordinator() -> Coordinator {
        
        Coordinator(text: $text)
        
    }
        
    
    // bridge between AppKit's NSComboBox events and SwiftUI's @Binding
    final class Coordinator: NSObject, NSComboBoxDelegate {
        
        var text: Binding<String>
        
        init(text: Binding<String>) {
            self.text = text
        }
        
        // called whenever the user types in the field
        func controlTextDidChange(_ obj: Notification) {
            guard let field = obj.object as? NSComboBox else { return }
            text.wrappedValue = field.stringValue
        }
        
        // called when user selects option from dropdown
        func comboBoxSelectionDidChange(_ notification: Notification) {
            guard let combo = notification.object as? NSComboBox else { return }
            let idx = combo.indexOfSelectedItem
            if idx >= 0,
               idx < combo.numberOfItems,
               let value = combo.itemObjectValue(at: idx) as? String {
                text.wrappedValue = value
            }

            
        }
        
    }
    
}
