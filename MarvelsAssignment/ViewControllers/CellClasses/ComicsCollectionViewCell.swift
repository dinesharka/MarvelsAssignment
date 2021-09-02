//
//  ComicsCollectionViewCell.swift
//  MarvelsAssignment
//
//  Created by Ankur on 26/08/21.
//

import UIKit

class ComicsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        imgView.layer.cornerRadius = 10
    }
}
