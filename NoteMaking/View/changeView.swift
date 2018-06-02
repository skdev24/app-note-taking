//
//  changeView.swift
//  MovieInfo
//
//  Created by Shivam Dev on 15/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit

class changeView: UIScrollView {

    //here we are calling subscribeToKeyboardNotification method when view will appear
    
    var currentScrollView: UIScrollView!
    var view: UIView!
    
    func subscribeToKeyboardNotification() {
        
        //This notification will be called when the keyboard will be shown in the view
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
    }
    
    
    
    func unsubscribeFromKeyboardNotification() {
        
        //This used to just remove the added Observer when keyboard was shown
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    
    
    //Selector method used to adjust the view and keyboard so nothing will interfere with each other
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        //        view.frame.origin.y -= getKeyboardHeight(notification)
        
        var userInfo = notification.userInfo!
        
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        
        
        
        var contentInset: UIEdgeInsets = currentScrollView.contentInset
        
        //        contentInset.bottom = keyboardFrame.size.height
        
        contentInset.bottom = getKeyboardHeight(notification)
        
        currentScrollView.contentInset = contentInset
        
    }
    
    
    func keyboardWillHide() {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        
        currentScrollView.contentInset = contentInset
        
    }
    
    
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
        
    }

}
