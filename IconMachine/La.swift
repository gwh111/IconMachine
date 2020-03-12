//
//  La.swift
//  PM2
//
//  Created by gwh on 2020/3/5.
//  Copyright © 2020 gwh. All rights reserved.
//

import Foundation

class La: NSObject {
    
//    static let isChinese = true
//    static let isChinese = false

    static func text(_ chinese:String,_ english:String) -> String {
    
        let languages = NSLocale.preferredLanguages
        let currentLanguage = languages.first!
        
        var isChinese = false
        if (currentLanguage.contains("zh")) {
            isChinese = true
        }
        
        if isChinese {
            return chinese
        }
        return english
    }
}
