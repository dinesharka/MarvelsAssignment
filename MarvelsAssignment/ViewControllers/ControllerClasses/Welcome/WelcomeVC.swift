//
//  WelcomeVC.swift
//  MarvelsAssignment
//
//  Created by Ankur on 26/08/21.
//

import UIKit

class WelcomeVC: UIViewController
{
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var btnStart : UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let gifURL : String = "https://i.gifer.com/Pe9b.gif"
        imgView.image = UIImage.gifImageWithURL(gifURL)
        btnStart.layer.cornerRadius = 10
        btnStart.layer.borderColor = UIColor.white.cgColor
        btnStart.layer.borderWidth = 1
    }
    
    @IBAction func btnStartTapped(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
