//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Jo on 2021/4/10.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var constStack: NSStackView!
    
    @IBOutlet weak var identifierStack: NSStackView!
    
    @IBOutlet weak var unlocalizedStack: NSStackView!
    
    @IBOutlet weak var constBox: NSBox!
    
    @IBOutlet weak var identiferBox: NSBox!
    
    @IBOutlet weak var unlocalizedBox: NSBox!
    
    @IBOutlet weak var languagePop: NSPopUpButton!
    
    /// 当前使用的语言
    lazy var appLanguage: String = {
        /// 读缓存，如果没有默认为简体中文
        guard let preferredLang = (UserDefaults.standard.object(forKey: "AppleLanguages") as? [String])?.first else {
            return "zh-Hans"
        }

        /// 判断语言类型，
        for lang in ["zh-Hans", "en", "ja", "de"] {
            if preferredLang.hasPrefix(lang) {
                return lang
            }
        }

        return "zh-Hans"
    }() {
        didSet {
            /// 设置的时候存到缓存中
            UserDefaults.standard.setValue([appLanguage], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagePop.addItems(withTitles: ["zh-Hans", "en", "ja", "de"])
        languagePop.selectItem(withTitle: appLanguage)
        constBox.title = LL(lConstBoxNameKey)
        identiferBox.title = LL(lIdentifierBoxNameKey)
        unlocalizedBox.title = LL(lUnlocalizedBoxName)

        let animals: [String] = [
            LL(lAnimalsDogNameKey, "狗"),
            LL(lAnimalsCatNameKey, "猫"),
            LL(lAnimalsSharkNameKey, "鲨鱼"),
            LL(lAnimalsTigerNameKey, "老虎"),
            LL(lAnimalsCheetahNameKey, "猎豹")
        ]
        
        let flowers: [String] = [
            LL(lFlowersFragransNameKey, "桂花"),
            LL(lFlowersLilyNameKey, "百合花"),
            LL(lPeonyNameKey, "牡丹花"),
            LL(lFlowersRoseNameKey, "玫瑰"),
            LL(lFlowersSunflowerNameKey, "向日葵")
        ]
        
        let fruits: [String] = [
            LL("com.auu.localization.test.fruits.appleNameKey"),
            "香蕉",
            "菠萝",
            "榴莲",
            LL("com.auu.localization.test.fruits.cherryNameKey"),
        ]
        
        for animal in animals {
            constStack.addView(NSTextField(labelWithString: animal), in: .top)
        }
        
        for flower in flowers {
            identifierStack.addView(NSTextField(labelWithString: flower), in: .top)
        }
        
        for fruit in fruits {
            unlocalizedStack.addView(NSTextField(labelWithString: fruit), in: .top)
        }
    }

    @IBAction func languagePopAction(_ sender: NSPopUpButton) {
        let alert = NSAlert()
        alert.messageText = LL(lAlertInfoNameKey)
        alert.addButton(withTitle: LL(lAlertConfirmActionNameKey))
        alert.addButton(withTitle: LL(lAlertCancelActionName))
        
        if alert.runModal() == .alertFirstButtonReturn {
            appLanguage = sender.titleOfSelectedItem!
            
            if let bundleURL = Bundle.main.executableURL {
                NSApp.hide(nil)
                NSApp.setActivationPolicy(.accessory)
                let _ = try? NSWorkspace.shared.launchApplication(at: bundleURL, options: .newInstance, configuration: [:])
            }
            
            NSApp.terminate(nil)
        } else {
            languagePop.selectItem(withTitle: self.appLanguage)
        }
    }
    
}

