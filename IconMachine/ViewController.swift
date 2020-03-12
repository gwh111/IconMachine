//
//  ViewController.swift
//  IconMachine
//
//  Created by gwh on 2020/3/12.
//  Copyright © 2020 gwh. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let width = self.view.frame.width
//        let height = self.view.frame.height
        
//        let imageView = NSImageView()
//        imageView.frame = CGRect(x: width - RH(300), y: RH(10), width: RH(300), height: RH(300) * 340 / 824)
//        self.view.addSubview(imageView)
//        imageView.image = NSImage.init(named: "WX20200312-142511@2x.png")
        
        let infoTextField = CommonTextField()
        infoTextField.frame = CGRect(x: width/2 - RH(200), y: RH(170), width: RH(400), height: RH(20))
        infoTextField.alignment = .center
        infoTextField.stringValue = Language("裁剪的Icon尺寸，可添加调整", "Icon size. You can edit the following text.")
        self.view.addSubview(infoTextField)
        
        let textView = CommonTextView()
        textView.update(frame: CGRect(x: width/2 - RH(100), y: RH(20), width: RH(200), height: RH(140)))
        textView.textView.isEditable = true
        self.view.addSubview(textView)

        let filepath = Bundle.main.path(forResource: "iconSizeList", ofType: "")
        let content = try! String(contentsOfFile: filepath!)
        textView.textView.string = content
        
        let button = CommonButton()
        button.frame = CGRect(x: width/2 - RH(40), y: RH(200), width: RH(80), height: RH(30))
        button.title = Language("选择图片", "Choose Icon")
        self.view.addSubview(button)
        button.addTappedBlock { (btn) in
            //
            OpenPanelC.shared.addOpenedImageBlock { (result) in
                
                // 图片是jpg还是png
                var suf = ".jpg"
                if result.hasSuffix("png") {
                    suf = ".png"
                }
                
                // 获取路径
                let paths = result.components(separatedBy: "/")
                var path = ""
                for i in 0 ..< paths.count - 1 {
                    path = path + paths[i] + "/"
                }
                
                // 创建dir
                let iconsPath = path + "AppIcon.appiconset/"
                var cmd = "mkdir " + iconsPath + "; "
                
                // 读取裁剪图片大小
                let content = textView.textView.string
                let sizes = content.components(separatedBy: "\n")
                for size in sizes {
                    if size.count <= 0 {
                        continue
                    }
                    let toPath = iconsPath + size + suf
                    let cp = "cp " + result + " " + toPath
                    let change = "sips -z " + size + " " + size + " " + toPath
                    let cmd1 = cp + "; " + change + "; "
                    cmd = cmd + cmd1
                }
                
                cmd = cmd + "open " + iconsPath
                TaskC.shared.runTask(command: cmd) { (finish) in

                    // 写jsonfile
                    let jsonPath = Bundle.main.path(forResource: "Contents", ofType: "json")
                    let json = try! String(contentsOfFile: jsonPath!)
                    let writeFile = iconsPath + "Contents.json"
                    try! json.write(to: NSURL.init(fileURLWithPath: writeFile) as URL, atomically: true, encoding: .utf8)
                }
                
            }
            
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

