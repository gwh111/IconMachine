//
//  CommonButton.swift
//  PM2
//
//  Created by gwh on 2020/2/5.
//  Copyright © 2020 gwh. All rights reserved.
//

import Foundation

class CommonButton: SWSTAnswerButton {
    
    typealias funcBlockA = (CommonButton) -> ()
    var tappedBlock:funcBlockA!
    
    func addTappedBlock(blockFunc:funcBlockA!) {
        tappedBlock = blockFunc
        self.target = self
        self.action = #selector(self.tappedAction)
    }
    
    @objc func tappedAction() {
        if (tappedBlock != nil) {
            tappedBlock(self)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.canSelected = false
        self.hasBorder = true
        self.backgroundNormalColor = NSColor.white
        self.backgroundHoverColor = RGBA(150, 195, 242, 1)
        self.backgroundHighlightColor = RGBA(100, 155, 222, 1)
        self.title = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
