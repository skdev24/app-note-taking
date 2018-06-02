//
//  ViewController.swift
//  NoteMaking
//
//  Created by Shivam Dev on 31/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit

class NoteVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newNotesBtn: UIButton!
    @IBOutlet weak var favBtnMain: touchInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)

    }
    
    var favBtn: Bool = false
    var favNotesDetails: [Notes] = []
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func loadList(){
        //load data here
        DispatchQueue.main.async {
            if self.favBtn {
                self.favNotesDetails = []
                for i in 0..<notes.count {
                    if notes[i].favNote {
                        self.favNotesDetails.append(notes[i])
                    }
                }
            }
            
            self.tableView.reloadData()
        }
                
    }
    
    @IBAction func NewNotesBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "GoToNewNotes", sender: nil)
    }
    
    
    @IBAction func favBtnWasPressed(_ sender: Any) {
        tableView.scrollsToTop = true
        
        favNotesDetails = []
        favBtn = !favBtn
        
        if !favBtn {
            favBtnMain.setImage(#imageLiteral(resourceName: "ic_view favorites note"), for: .normal)
        } else {
            favBtnMain.setImage(#imageLiteral(resourceName: "ic_favorite_clicked2"), for: .normal)
            for i in 0..<notes.count {
                if notes[i].favNote {
                    favNotesDetails.append(notes[i])
                }
            }
        }
        
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NotesToDetails" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                if let destination = segue.destination as? NotesDetailsVC {
                    //                DispatchQueue.main.async {
                    //                    notes[selectedRow]
                    //                   print(destination.view)
                    if let _ = destination.view {
                        destination.oldNotes = true
                        destination.newNotes = false
                        
                        if favBtn {
                            destination.currentNote = favNotesDetails[selectedRow].notesPosition
                            destination.update(image: favNotesDetails[selectedRow].noteImage, title: favNotesDetails[selectedRow].noteTitle, details: favNotesDetails[selectedRow].noteDetail, fav: favNotesDetails[selectedRow].favNote)
                        } else {
                            destination.currentNote = selectedRow
                            destination.update(image: notes[selectedRow].noteImage, title: notes[selectedRow].noteTitle, details: notes[selectedRow].noteDetail, fav: notes[selectedRow].favNote)
                        }
                        
                        destination.favBtn.isHidden = false
                        destination.saveBtn.isHidden = true
                        destination.favBtn.isUserInteractionEnabled = true
                        destination.saveBtn.isUserInteractionEnabled = false
                        destination.detailsField.isUserInteractionEnabled = false
                        destination.titleField.isUserInteractionEnabled = false
                    }
                    //                }
                }
            }
        } else if segue.identifier == "GoToNewNotes" {
            if let destination = segue.destination as? NotesDetailsVC {
                //            DispatchQueue.main.async {
                //            print(destination.view)
                if let _ = destination.view {
                    destination.oldNotes = false
                    destination.newNotes = true
                    destination.update(image: #imageLiteral(resourceName: "img_taxi"), title: "What is your title....", details: "Write title details here....", fav: false)
                    destination.favBtn.isHidden = true
                    destination.saveBtn.isHidden = false
                    destination.saveBtn.isUserInteractionEnabled = true
                    destination.favBtn.isUserInteractionEnabled = false
                    destination.detailsField.isUserInteractionEnabled = true
                    destination.titleField.isUserInteractionEnabled = true
                }
                
                //        }
                
            }
        }
    }
    
}


extension NoteVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if favBtn {
            return favNotesDetails.count
        } else {
            return notes.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! notesCell
        if favBtn {
            let note = favNotesDetails[indexPath.row]
            cell.Update(label: note.noteTitle, image: note.noteImage, date: "31/05")
        } else {
            let note = notes[indexPath.row]
            cell.Update(label: note.noteTitle, image: note.noteImage, date: "31/05")
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "NotesToDetails", sender: nil)
    }
}


