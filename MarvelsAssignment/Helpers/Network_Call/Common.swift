//
//  Common.swift
//  MarvelsAssignment
//
//  Created by Arka on 26/08/21.
//

import UIKit

let BaseUrl = "http://52.67.219.144"

class Common: NSObject
{
    //MARK:- check email validation
    
    class func checkValidateEmail(enteredEmail:String) -> Bool
    {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    //MARK:- Trim white Space
    
    class func trimWhiteSpace(text : String) -> String
    {
        let trimText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimText
    }
    
    //MARK:- Simple Alert With ok Button
    
    class func showAlertWithOkAction(msg : String, viewCnt : UIViewController)
    {
        let alert = UIAlertController(title: "Message", message: msg, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(actionOk)
        viewCnt.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- make navigation bar Button
    
    class func makeNavigationBtn(btnImg : String) -> UIButton
    {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: btnImg), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30 , height: 30)
        return btn1
    }

}

//MARK:-  Disable testfield copy paste property

class DisableTxt_ViewController: UITextField
{
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool
    {
        print(Selector.self)
        if action == "paste:" || action == "copy:" || action == "cut:"
        {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
