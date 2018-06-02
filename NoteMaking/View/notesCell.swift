//
//  notesCell.swift
//  NoteMaking
//
//  Created by Shivam Dev on 31/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit

class notesCell: UITableViewCell {

    
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var noteData: UILabel!
    @IBOutlet weak var noteImageView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noteView.layer.masksToBounds = false
        noteView.layer.shadowColor = UIColor.gray.cgColor
        noteView.layer.shadowOpacity = 0.5
        noteView.layer.shadowOffset = CGSize.zero
        noteView.layer.shadowRadius = 2
        noteView.layer.cornerRadius = 5
        noteImageView.roundCorners([.topRight, .bottomRight], radius: 5)
    }
    
    
    func Update(label: String, image: UIImage, date: String) {
        noteLabel.text = label
        noteImage.image = image
        noteData.text = date
    }

}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
