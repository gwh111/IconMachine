//
//  OpenPanelC.swift
//  PM2
//
//  Created by gwh on 2020/2/12.
//  Copyright © 2020 gwh. All rights reserved.
//

import Foundation

class OpenPanelC:NSObject {
    
    static let shared = OpenPanelC()
    
    enum OpenType {
        case normal
        case image
    }
    
    private var type:OpenType = .normal
    
    typealias funcBlockA = (String) -> ()
    var openedBlock:funcBlockA!
    
    func addOpenedBlock(blockFunc:funcBlockA!) {
        type = .normal
        openedBlock = blockFunc
        open()
    }
    
    func addOpenedImageBlock(blockFunc:funcBlockA!) {
        type = .image
        openedBlock = blockFunc
        open()
    }

    func open() {
        
        // 1. 创建打开文档面板对象
        let openPanel = NSOpenPanel()
        // 2. 设置确认按钮文字
        openPanel.prompt = Language("确定", "Select")
        // 3. 设置禁止选择文件
        openPanel.canChooseFiles = true
        // 4. 设置可以选择目录
        openPanel.canChooseDirectories = true
        
        if type == .image {
            openPanel.canChooseDirectories = false
            openPanel.allowedFileTypes = ["png","jpg"]
        }
        
        // 5. 弹出面板框
        openPanel.beginSheetModal(for: NSApplication.shared.windows.first!) { (result) in
            // 6. 选择确认按钮
            if result == NSApplication.ModalResponse.OK {
                // 7. 获取选择的路径
                let path = openPanel.urls[0].absoluteString.removingPercentEncoding!
                
                let trash = "file://"
                let fixPath = String(path.suffix(path.count - trash.count)) as String
                NSLog(fixPath)
                
                if (self.openedBlock != nil) {
                    self.openedBlock(fixPath)
                }
            }
        }
    }
}
