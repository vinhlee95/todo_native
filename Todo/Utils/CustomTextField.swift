//
//  CustomTextField.swift
//  Todo
//
//  Created by Vinh Le on 2/20/21.
//

import SwiftUI
import UIKit

// CustomTextField to auto-focus on the text input
// when it first renders
// https://stackoverflow.com/questions/58311022/autofocus-textfield-programmatically-in-swiftui/64546087
struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var nextResponder : Bool?
    @Binding var isResponder : Bool
    var onEditingEnd: () -> Void
    
    var isSecured : Bool = false
    var keyboard : UIKeyboardType
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        @Binding var nextResponder : Bool?
        @Binding var isResponder : Bool
        var onEditingEnd: () -> Void
        
        init(text: Binding<String>,nextResponder : Binding<Bool?> , isResponder : Binding<Bool>, onEditingEnd: @escaping () -> Void) {
            _text = text
            _isResponder = isResponder
            _nextResponder = nextResponder
            self.onEditingEnd = onEditingEnd
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            // Perform modification asynchronously
            // https://stackoverflow.com/questions/58878980/textfielddidchangeselection-modifying-state-during-view-update-this-will-cause
            DispatchQueue.main.async {
                self.text = textField.text ?? ""
            }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.text = ""
            DispatchQueue.main.async {
                self.isResponder = true
            }
        }
                
        func textFieldDidEndEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.isResponder = false
                if self.nextResponder != nil {
                    self.nextResponder = true
                }
            }
        }
        
        @objc func handleEditingEnd() {
            onEditingEnd()
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.isSecureTextEntry = isSecured
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = keyboard
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.handleEditingEnd), for: .editingDidEndOnExit)
        return textField
    }
    
    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text, nextResponder: $nextResponder, isResponder: $isResponder, onEditingEnd: onEditingEnd)
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isResponder {
            uiView.becomeFirstResponder()
        }
    }
}
