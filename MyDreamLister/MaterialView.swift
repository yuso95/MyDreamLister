//
//  MaterialView.swift
//  MyDreamLister
//
//  Created by Younoussa Ousmane Abdou on 1/20/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIView {
    
    @IBInspectable private var materialDesign: Bool {
        get {
            
            return self.materialDesign
        }
        set {
            
            self.materialDesign = newValue
            
            if materialKey {
                
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(colorLiteralRed: 157/255, green:  157/255, blue:  157/255, alpha: 1.0).cgColor
            } else {
                
                self.layer.cornerRadius = 0.0
                self.layer.shadowOpacity = 0.0
                self.layer.shadowRadius = 0.0
                self.layer.shadowColor = nil
            }
        }
    }
}
