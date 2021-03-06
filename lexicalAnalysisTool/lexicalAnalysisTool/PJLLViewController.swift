//
//  PJLLViewController.swift
//  lexicalAnalysisTool
//
//  Created by pjpjpj on 2018/6/8.
//  Copyright © 2018年 #incloud. All rights reserved.
//

import Cocoa

class PJLLViewController: NSViewController {

    @IBOutlet var inputView: NSTextView!
    @IBOutlet var outputView: NSTextView!
    @IBOutlet weak var inputCodeTextField: NSTextField!
    @IBOutlet weak var tipsLabel: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        outputView.isEditable = false
        tipsLabel.isHidden = true
    }
    
    @IBAction private func selectFile(_ sender: NSButton) {
        let panel = NSOpenPanel.init()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        
        let finded : Int = panel.runModal().rawValue
        if finded == NSApplication.ModalResponse.OK.rawValue {
            for url in panel.urls {
                let codeData = try? Data.init(contentsOf: url)
                let codeString = String(data: codeData!, encoding: String.Encoding.utf8)
                PJLLOneTool.shared().inputString = codeString!
                inputView.string = codeString!
                outputView.string = ""
                tipsLabel.isHidden = true
                inputCodeTextField.stringValue = ""
            }
        }
    }
    
    @IBAction func firstCollect(_ sender: NSButton) {
        var finalString = ""
        let keys = PJLLOneTool.shared().firstCollect.keys
        for key in keys {
            let values = PJLLOneTool.shared().firstCollect[key]
            var keyString = "\(key) : "
            var index = 0
            for value in values! {
                if index == (values?.count)! - 1 {
                    keyString = keyString + "[ \(value) ]"
                } else {
                    keyString = keyString + "[ \(value) ]、"
                }
                index += 1
            }
            finalString = finalString + keyString + "\n"
        }
        outputView.string = finalString
    }
    
    @IBAction func followCollect(_ sender: NSButton) {
        var finalString = ""
        let keys = PJLLOneTool.shared().followCollect.keys
        for key in keys {
            let values = PJLLOneTool.shared().followCollect[key]
            var keyString = "\(key) : "
            var index = 0
            for value in values! {
                if index == (values?.count)! - 1 {
                    keyString = keyString + "[ \(value) ]"
                } else {
                    keyString = keyString + "[ \(value) ]、"
                }
                index += 1
            }
            finalString = finalString + keyString + "\n"
        }
        outputView.string = finalString
    }
    
    @IBAction func selectCollect(_ sender: NSButton) {
        var finalString = ""
        let keys = PJLLOneTool.shared().selelctCollect.keys
        let k = keys.sorted(by: <)
        for key in k {
            let values = PJLLOneTool.shared().selelctCollect[key]
            var keyString = "\(Int(key) + 1) : "
            var index = 0
            for value in values! {
                if index == (values?.count)! - 1 {
                    keyString = keyString + "[ \(value) ]"
                } else {
                    keyString = keyString + "[ \(value) ]、"
                }
                index += 1
            }
            finalString = finalString + keyString + "\n"
        }
        outputView.string = finalString
    }
    
    @IBAction func analysisTable(_ sender: NSButton) {
        var finalString = "       "
        for c in PJLLOneTool.shared().AllfinalityCharArray {
            finalString = finalString + c + "         "
        }
        finalString += "\n"
        let keys = PJLLOneTool.shared().forecastCollect.keys
        for key in keys {
            let values = PJLLOneTool.shared().forecastCollect[key]
            var keyString = "\(key) : "
            var index = 0
            for value in values! {
                if index == (values?.count)! - 1 {
                    keyString = keyString + "[ \(value) ]"
                } else {
                    keyString = keyString + "[ \(value) ]、"
                }
                index += 1
            }
            finalString = finalString + keyString + "\n"
        }
        outputView.string = finalString
        
    }
    
    @IBAction func comeoutProcess(_ sender: NSButton) {
        if inputCodeTextField.stringValue == "" {
            tipsLabel.isHidden = false
            tipsLabel.stringValue = "❌请先输入需要分析的代码"
            tipsLabel.textColor = .red
            return
        }
        let isRight = PJLLOneTool.shared().getComeoutProcess(codeString: inputCodeTextField.stringValue)
        var finalString = ""
        for s in PJLLOneTool.shared().codeProcessCollect {
            finalString += s + "\n"
        }
        outputView.string = finalString
        if isRight {
            tipsLabel.isHidden = false
            tipsLabel.stringValue = "✅语法正确"
            tipsLabel.textColor = .green
        } else {
            tipsLabel.isHidden = false
            tipsLabel.stringValue = "❌语法错误，请检查代码"
            tipsLabel.textColor = .red
        }
    }
    
    
    
}
