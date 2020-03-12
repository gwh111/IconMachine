//
//  TaskC.swift
//  PM2
//
//  Created by gwh on 2020/2/12.
//  Copyright © 2020 gwh. All rights reserved.
//

import Foundation

class TaskC:NSObject {
    
    static let shared = TaskC()
    
    var inputPipe = Pipe()
    var outputPipe = Pipe()
    var errorPipe = Pipe()
    weak var errorObserve : NSObjectProtocol?
    weak var observe : NSObjectProtocol?
    
    // background
    typealias funcBlockA = (String) -> ()
    typealias funcBlockB = (Bool) -> ()
    
    // 后台执行
    var backgroundBlock:funcBlockA!
    // 正常执行
    var finishBlock:funcBlockA!
    // 判断是否
    var isBlockB:funcBlockB!
    
    func runTaskInBackground(command:String,blockFunc:funcBlockA!) {
        let task = TaskC()
        task.backgroundBlock = blockFunc
        task.runTask(command: command)
    }
    
    func runTask(command:String,blockFunc:funcBlockA!) {
        let task = TaskC()
        task.finishBlock = blockFunc
        task.runTask(command: command)
    }
    
    func runTask(command:String) {
        
        NSLog("cmd = %@", command)
        DispatchQueue.global(qos: .default).async {
                
            let task = Process()
            
            task.launchPath = "/bin/bash"
            task.arguments = ["-l","-c",command]
            task.terminationHandler = { proce in

                if (self.backgroundBlock != nil) {
                    let errorOutput = self.errorPipe.fileHandleForReading.availableData
                    let errorOutputString = String(data: errorOutput, encoding: String.Encoding.utf8) ?? ""
                    if errorOutputString != "" {
                        NSLog(errorOutputString)
                        self.backgroundBlock(errorOutputString)
                        return
                    }
                    let output = self.outputPipe.fileHandleForReading.availableData
                    let outputString = String(data: output, encoding: String.Encoding.utf8) ?? ""
                    if outputString != "" {
                        NSLog("out = %@",outputString)
                        self.backgroundBlock(outputString)
                        return
                    } else {
                        self.backgroundBlock("")
                        return
                    }
                }
                DispatchQueue.main.sync {
                    if (self.finishBlock != nil) {
                        self.finishBlock("")
                    }
                }
            }
            
            self.captureStandardOutputAndRouteToTextView(task)
            
            task.launch()
            task.waitUntilExit()
            
        }
        
    }
}

extension TaskC {
    fileprivate func captureStandardOutputAndRouteToTextView(_ task:Process) {
        
        outputPipe = Pipe()
        errorPipe = Pipe()
        task.standardOutput = outputPipe
        task.standardError = errorPipe
        
        // 在后台线程等待数据和通知
        outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        errorPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        
        // 执行定时输出日志台
        errorObserve = NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable, object: errorPipe.fileHandleForReading , queue: nil) { notification in
            
            self.errorPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
            if (self.backgroundBlock != nil) {
                // 如果后台执行先不打印
                return
            }
            let output = self.errorPipe.fileHandleForReading.availableData
            let outputString = String(data: output, encoding: String.Encoding.utf8) ?? ""
            if outputString != "" {
                NSLog(outputString)
            }
        }
        
        observe = NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable, object: outputPipe.fileHandleForReading , queue: nil) { notification in
            
            self.outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
            if (self.backgroundBlock != nil) {
                // 如果后台执行先不打印
                return
            }
            let output = self.outputPipe.fileHandleForReading.availableData
            let outputString = String(data: output, encoding: String.Encoding.utf8) ?? ""
            if outputString != "" {
                NSLog(outputString)
            }
        }
        // 执行完毕
        
    }
    
}

