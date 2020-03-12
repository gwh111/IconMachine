//
//  CommonTextView.swift
//  PM2
//
//  Created by gwh on 2020/2/11.
//  Copyright © 2020 gwh. All rights reserved.
//

import Foundation

class CommonTextView:NSView {
    
    var scroll = NSScrollView()
    var textView:NSTextView = {
       
        let textView = NSTextView()
        
        return textView
    }()
    var editRed = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textView.textColor = NSColor.darkGray
        textView.backgroundColor = NSColor.clear
        textView.isEditable = false
        textView.isSelectable = true
        textView.focusRingType = .none
        textView.font = RF(14)
        textView.autoresizingMask = .height
        textView.delegate = self
        textView.insertionPointColor = NSColor.green
        
        addSubviews()
        addConstraints()
    }
    
    func resum() {
        
        textView.textColor = NSColor.darkGray
    }
    
    func addSubviews() {
        scroll.documentView = textView
        scroll.hasVerticalScroller = true
        [scroll].forEach(addSubview)
    }
    
    func addConstraints() {
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([scroll.topAnchor.constraint(equalTo: scroll.superview!.topAnchor),
                                     scroll.leadingAnchor.constraint(equalTo: scroll.superview!.leadingAnchor),
                                     scroll.trailingAnchor.constraint(equalTo: scroll.superview!.trailingAnchor),
                                     scroll.bottomAnchor.constraint(equalTo: scroll.superview!.bottomAnchor)
                                    ])
    }
    
    func update(frame:CGRect) {

        self.frame = frame
        textView.frame = frame

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CommonTextView:NSTextViewDelegate {

    func textDidChange(_ notification: Notification) {
        
        if editRed {
            textView.textColor = NSColor.red
        }
    }
}
