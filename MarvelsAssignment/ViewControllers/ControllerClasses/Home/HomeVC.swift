//
//  HomeVC.swift
//  MarvelsAssignment
//
//  Created by Ankur on 26/08/21.
//

import UIKit
import Foundation
import CommonCrypto
import SwiftyJSON
import SDWebImage

class HomeVC: UIViewController
{
    //MARK:- IBOutlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewNavigation: UIView!
    
    //MARK:- Variables
    var timeStampVal = Int()
    var hashVal = ""
    var md5Val = ""
    var homeData = [HomeModel]()
    
    // MARK:- Predefined methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewNavigation.layer.borderWidth = 1
        viewNavigation.layer.borderColor = UIColor.gray.cgColor
        let timestamp = NSDate().timeIntervalSince1970
        timeStampVal = Int(timestamp)
        hashVal = String(timeStampVal) + private_key + public_key
        md5Val = MD5(hashVal) ?? ""
        callApi()
    }
    
    // MARK: - Api call method
    
   private func callApi()
   {
        GIFHUD.shared.show(withOverlay: true, duration: 2)
        APIController.getCharacterList(hashVal: md5Val, timestamp: timeStampVal, apiKey: public_key) { (response) in
        let data = response["data"].dictionaryValue
        let result = data["results"]?.arrayValue
        
        _ = result?.map({ (list)  in
            let name = list["name"]
            let thumbnail = list["thumbnail"]
            let path = thumbnail["path"]
            let type = thumbnail["extension"]
            let id = list["id"]
            
            //MARK:- Appending Data to model
            
            self.homeData.append(HomeModel(name: name.stringValue, url: path.stringValue, type: type.stringValue, id: id.stringValue, textObjects: ""))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                GIFHUD.shared.dismiss()
            }
        })
        self.tblView.reloadData()
        }
    }
    
    // MARK: - Hash value generator method
    
    func MD5(_ string: String) -> String? {
            let length = Int(CC_MD5_DIGEST_LENGTH)
            var digest = [UInt8](repeating: 0, count: length)
            if let d = string.data(using: String.Encoding.utf8) {
                _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                    CC_MD5(body, CC_LONG(d.count), &digest)
                }
            }
            return (0..<length).reduce("") {
                $0 + String(format: "%02x", digest[$1])
            }
        }
    
    // MARK: - Button Action
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableView delegagte and Data source

extension HomeVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return homeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tblView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        cell.lblName.text = homeData[indexPath.row].name
        print("data",homeData[indexPath.row].url! + "." + homeData[indexPath.row].type!)
        cell.imgCharacter.sd_setImage(with: URL(string: homeData[indexPath.row].url! + "." + homeData[indexPath.row].type!), placeholderImage: UIImage(named: "App-Default"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CharacterVC") as! CharacterVC
        vc.charId = homeData[indexPath.row].id ?? ""
        vc.charname = homeData[indexPath.row].name!
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



