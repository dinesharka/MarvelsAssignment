//
//  ComicsVC.swift
//  MarvelsAssignment
//
//  Created by Arka on 26/08/21.
//

import UIKit
import SDWebImage

class ComicsVC: UIViewController
{
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var HeaderImg: UIImageView!
    
    var comicId = String()
    var hashVal = ""
    var timestamp = Int()
    var des = String()
    var img = String()
    var comicname = ""
    var comicDes:CharacterDetails?
    var comicData = [ComicDesModel]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        callCreatorsApi()
        setUpInitialData()
    }
    
    func setUpInitialData()
    {
        HeaderImg.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "App-Default"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        lblTitle.text = comicname
        lblDesc.text = des
    }
    
    func callCreatorsApi()
    {
        GIFHUD.shared.show(withOverlay: true, duration: 2)
        APIController.getCreatorList(comicId: comicId, hashVal: hashVal, timestamp: timestamp, apiKey: public_key) { (response) in
            print(response)
            let data = response["data"].dictionaryValue
            let result = data["results"]?.arrayValue
            _ = result?.map({ (list) in
                let fullName = list["fullName"]
                let id = list["id"]
                let thumbnail = list["thumbnail"]
                let path = thumbnail["path"]
                let type = thumbnail["extension"]
                self.comicData.append(ComicDesModel(name: fullName.string, url: path.stringValue, type: type.stringValue, id: id.string, textObjects: ""))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    GIFHUD.shared.dismiss()
                }
            })
            self.colView.reloadData()
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ComicsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colView.noDataFound(comicData.count)
        return comicData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colView.dequeueReusableCell(withReuseIdentifier: "ComicsCollectionViewCell", for: indexPath) as! ComicsCollectionViewCell
        cell.imgView.sd_setImage(with: URL(string: comicData[indexPath.row].url! + "." + comicData[indexPath.row].type!), placeholderImage: UIImage(named: "App-Default"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        cell.lblName.text = comicData[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65.0, height: 100.0)
    }
    
}

extension UICollectionView{

    func noDataFound(_ dataCount:Int)
    {
        if dataCount <=  0 {
            let label = UILabel()
            label.frame = self.frame
            label.frame.origin.x = 0
            label.frame.origin.y = 0
            label.textAlignment = .center
            label.text = "No data found"
            label.textColor = UIColor.white
            self.backgroundView = label
        }else{
            self.backgroundView = nil
        }
    }
}
