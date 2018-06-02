//
//  NotesDetailsVC.swift
//  NoteMaking
//
//  Created by Shivam Dev on 31/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit


var notes: [Notes] = []

class NotesDetailsVC: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleField: UITextView!
    @IBOutlet weak var notesScrollView: UIScrollView!
    @IBOutlet weak var detailsField: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var voiceBtn: UIButton!
    @IBOutlet weak var fileBtn: UIButton!
    @IBOutlet weak var dateEditedLbl: UILabel!
    
    let currentView = changeView()
    
    var currentNote: Int!
    var notesPosition: Int!
    var newNotes: Bool!
    var oldNotes: Bool!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentView.currentScrollView = notesScrollView
        currentView.view = view
        titleField.delegate = self
        detailsField.delegate = self
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentView.subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        currentView.unsubscribeFromKeyboardNotification()
    }
    
    @IBAction func saveBtnWasPressed(_ sender: Any) {
        
        if newNotes {
            if titleField.text != "" && detailsField.text != "" && titleField.text != "What is your title...." && detailsField.text != "Write title details here...."{
                
                notes.append(Notes(title: titleField.text!, detials: detailsField.text, image: imageView.image!, fav: false, position: notes.count))
                
                dismiss(animated: true, completion: nil)
                
            }
        } else if oldNotes {
//            let note = notes[currentNote]
            if titleField.text != "" && detailsField.text != ""/*note.noteTitle != titleField.text! || note.noteDetail != detailsField.text */ {
                notes[currentNote].noteTitle = titleField.text!
                notes[currentNote].noteDetail = detailsField.text!
                notes[currentNote].noteImage = imageView.image!
                saveBtn.isHidden = true
                saveBtn.isUserInteractionEnabled = false
                UIView.animate(withDuration: 0.3) {
                    self.favBtn.isHidden = false
                    self.favBtn.isUserInteractionEnabled = true
                }
                titleField.isUserInteractionEnabled = false
                detailsField.isUserInteractionEnabled = false
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @IBAction func favBtnWasPressed(_ sender: Any) {
        
        notes[currentNote].favNote = !notes[currentNote].favNote
        
        if !notes[currentNote].favNote {
            favBtn.setImage(#imageLiteral(resourceName: "ic_favorite"), for: .normal)
        } else {
            favBtn.setImage(#imageLiteral(resourceName: "ic_favorite_clciked"), for: .normal)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    
    @IBAction func addingImageBtnWasPressed(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func editingBtnWasPressed(_ sender: Any) {
        favBtn.isHidden = true
        favBtn.isUserInteractionEnabled = false
        saveBtn.isHidden = false
        saveBtn.isUserInteractionEnabled = true
        titleField.isUserInteractionEnabled = true
        detailsField.isUserInteractionEnabled = true
    }
    
    @IBAction func addingVoiceButtonWasPressed(_ sender: Any) {
    }
    
    @IBAction func insertingFileBtnWasPressed(_ sender: Any) {
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            currentView.keyboardWillHide()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if titleField.text == "" && newNotes {
            titleField.text = "What is your title...."
        }
        
        if detailsField.text == "" && newNotes {
            detailsField.text = "Write title details here...."
        }
        if textView == titleField && newNotes && titleField.text == "What is your title...."{
            titleField.text = ""
        }
        
        if textView == detailsField && newNotes && detailsField.text == "Write title details here...."{
            detailsField.text = ""
        }
    }
    
    
    func update(image: UIImage, title: String, details: String, fav: Bool) {
        imageView.image = image
        titleField.text = title
        detailsField.text = details
        if !fav {
           favBtn.setImage(#imageLiteral(resourceName: "ic_favorite"), for: .normal)
        } else {
           favBtn.setImage(#imageLiteral(resourceName: "ic_favorite_clciked"), for: .normal)
        }
        
    }
    
    @IBAction func dissmissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
