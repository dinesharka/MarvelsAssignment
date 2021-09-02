//
//  CharacterVC.swift
//  MarvelsAssignment
//
//  Created by Ankur on 26/08/21.
//

import UIKit
import CommonCrypto
import SwiftyJSON
import SDWebImage
import Foundation
class CharacterVC: UIViewController
{
    //MARK:- Outlets
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var charImg: UIImageView!
    @IBOutlet weak var desTxt: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    
    //MARK:- Variables
    var timeStampVal = Int()
    var hashVal = ""
    var md5Val = ""
    var charId = String()
    var des = String()
    var charname = ""
    var comicData = [ComicDesModel]()
    var charDetailData = [CharacterDetails]()
    var creator = [[String:JSON]]()
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        desTxt.text = "No description available"
        let timestamp = NSDate().timeIntervalSince1970
        timeStampVal = Int(timestamp)
        hashVal = String(timeStampVal) + private_key + public_key
        md5Val = MD5(hashVal) ?? ""
        lblHeader.text = charname
        callApi()
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
    
    // MARK: - Api call method
   private func callApi()
    {
        APIController.getCharacterDetails(charId: charId, hashVal: md5Val, timestamp: timeStampVal, apiKey: public_key,userKey:private_key) { (response) in
        let data = response["data"].dictionaryValue
        let result = data["results"]?.arrayValue
        _ = result?.map({ (list)  in
        let description = list["description"]
        let thumbnail = list["thumbnail"]
        let path = thumbnail["path"]
        let type = thumbnail["extension"]
        if description.rawString() == "" {
            self.des = "No description available"
        }else {
            self.des = description.stringValue
        }
        self.charDetailData.append(CharacterDetails(description: self.des, url: path.stringValue, type: type.stringValue))
        })
        self.setUpData()
        }
    }
    
    private func callComicsApi()
    {
        GIFHUD.shared.show(withOverlay: true, duration: 2)
        APIController.getComicsList(charId: charId, hashVal: md5Val, timestamp: timeStampVal, apiKey: public_key) { (response) in
        let data = response["data"].dictionaryValue
        let result = data["results"]?.arrayValue
        _ = result?.map({ (list)  in
        let name = list["title"]
        let thumbnail = list["thumbnail"]
        let path = thumbnail["path"]
        let type = thumbnail["extension"]
        let id = list["id"]
        let description = list["textObjects"][0]["text"]
        let creators = list["creators"]
        let item = creators["items"]
        self.comicData.append(ComicDesModel(name: name.stringValue, url: path.stringValue, type: type.stringValue, id: id.stringValue, textObjects: description.string))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            GIFHUD.shared.dismiss()
        }
        })
        self.colView.reloadData()
        }
    }
    
    //MARK:= Populating Data after Api response
    
   private func setUpData()
   {
        desTxt.text = charDetailData[0].description ?? ""
        charImg.sd_setImage(with: URL(string: charDetailData[0].url! + "." + charDetailData[0].type!), placeholderImage: UIImage(named: "Maevel-Default"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
           })
        self.callComicsApi()
    }
    
    // MARK: - Button Action
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: true)
    }
}

extension CharacterVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colView.noDataFound(comicData.count)
        return comicData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.lblName.text = comicData[indexPath.row].name
        cell.imgView.sd_setImage(with: URL(string: comicData[indexPath.row].url! + "." + comicData[indexPath.row].type!), placeholderImage: UIImage(named: "App-Default"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 120.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ComicsVC") as! ComicsVC
        vc.comicId = comicData[indexPath.row].id ?? ""
        vc.timestamp = timeStampVal
        vc.hashVal = md5Val
        vc.des =  comicData[indexPath.row].textObjects ?? ""
        vc.img = comicData[indexPath.row].url! + "." + comicData[indexPath.row].type!
        vc.comicname = comicData[indexPath.row].name!
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
