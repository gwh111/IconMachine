//
//  CommonTextField.swift
//  PM2
//
//  Created by gwh on 2020/2/5.
//  Copyright © 2020 gwh. All rights reserved.
//

import Foundation

class CommonTextField: NSTextField,NSTextFieldDelegate {
    
    typealias funcBlockA = (CommonTextField) -> ()
    var endBlock:funcBlockA!
    
    func addEndEditBlock(blockFunc:funcBlockA!) {
        endBlock = blockFunc
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = NSColor.clear
        self.delegate = self
        self.usesSingleLineMode = true
        self.alignment = .justified
        self.isBordered = false
        self.isEditable = false
        self.focusRingType = .none
        self.font = RF(14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textDidChange(_ notification: Notification) {
        
    }
    
    override func textDidEndEditing(_ notification: Notification) {
        
        if (endBlock != nil) {
            endBlock(self)
        }
    }
}
