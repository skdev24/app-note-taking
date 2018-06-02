//
//  touchInterface.swift
//  NoteMaking
//
//  Created by Shivam Dev on 01/06/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit

class touchInterface: UIButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 0.3028413955)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundColor = UIColor.clear
        }) { (success) in

        }
        
        super.touchesBegan(touches, with: event)
    }
    
    
    
    
    
    
}
