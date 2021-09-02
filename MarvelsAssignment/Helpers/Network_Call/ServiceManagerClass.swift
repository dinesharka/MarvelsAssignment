//
//  ServiceManagerClass.swift
//  MarvelsAssignment
//
//  Created by Arka on 26/08/21.
//

import UIKit 
import Alamofire

protocol ProgressChanges
{
    func progress(val: Float)
}

class ServiceManagerClass: NSObject {
    static var delegate: ProgressChanges?

    static var baseUrl =  "https://gateway.marvel.com/v1/public/"
    static var bearerToken = ""


    class func  requestWithPost(methodName:String, parameter:[String:Any]?,Auth_header:[String:String], successHandler: @escaping(_ success:JSON) -> Void)
    {
       // CommonVC.showHUD()
        let parameters: Parameters = parameter!
        var jsonResponse:JSON!
        var errorF:NSError!
//        print(errorF)
        let urlString = baseUrl.appending("\(methodName)")
//        print("parameters",parameters)
        
        if UserDefaults.standard.value(forKey: "token") != nil
        {
            bearerToken = UserDefaults.standard.value(forKey: "token") as! String
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization" : "Bearer " + bearerToken
        ]
        
        
        //"text/plain; charset=utf-8"
     //   URLRequest.setValue("application/json",
               //             forHTTPHeaderField: "Content-Type")
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        let sessionManager =  Alamofire.SessionManager(configuration: configuration)
        
        print("urlString",urlString)
        sessionManager.request(urlString, method: .post, parameters: parameters, encoding:JSONEncoding.default , headers: headers).responseJSON { (response:DataResponse<Any>) in
            switch response.result{
            case .failure(let error):
                print(error.localizedDescription)
                errorF = error as NSError
                //self.hideLoadingHUD()
                ServiceManagerClass.alert(message: error.localizedDescription)
                break
            case .success(let value):
//                print("value",value)
//                print("response.request",response.request!)  // original URL request
//                print("response",response.response!) // HTTP URL response
             //   print("ggg",response.data!)     // server data
              //  print("result",response.result)   // result of response serialization
                
                do{
                    let json = try JSON(data: response.data!)
//                   print("json",json)
                    let jsonType = [json] as NSArray
//                    print("jsonType",jsonType)
                    GIFHUD.shared.dismiss()
                    jsonResponse = json
                    break
                }
                catch{
                    print("error",error.localizedDescription)
                }
            }
            if jsonResponse !=  nil
            {
                    successHandler(jsonResponse)
            }
            else
            {
           //     ServiceManagerClass.alert(message: errorF.localizedDescription)
            }
           // KRProgressHUD.dismiss()
//            SVProgressHUD.dismiss()
            sessionManager.session.invalidateAndCancel()
        }
    }
    
    class func requestWithPut(methodName:String, parameter:[String:Any]?,Auth_header:[String:String], successHandler: @escaping(_ success:JSON) -> Void)
    {
        // CommonVC.showHUD()
        let parameters: Parameters = parameter!
        var jsonResponse:JSON!
        var errorF:NSError!
        //        print(errorF)
        let urlString = baseUrl.appending("\(methodName)")
        print("parameters",parameters)
        
        if UserDefaults.standard.value(forKey: "token") != nil
        {
            bearerToken = UserDefaults.standard.value(forKey: "token") as! String
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            
            "Authorization" : "Bearer " + bearerToken 
        ]
        //"text/plain; charset=utf-8"
        //   URLRequest.setValue("application/json",
        //             forHTTPHeaderField: "Content-Type")
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        
        print("urlString",urlString)
        print(headers)
        sessionManager.request(urlString, method: .put, parameters: parameters, encoding:URLEncoding.default , headers: headers).responseJSON { (response:DataResponse<Any>) in
            switch response.result{
            case .failure(let error):
                print(error.localizedDescription)
                errorF = error as NSError
                //self.hideLoadingHUD()
                ServiceManagerClass.alert(message: error.localizedDescription)
                break
            case .success(let value):
                print("value",value)
                //                print("response.request",response.request!)  // original URL request
                //                print("response",response.response!) // HTTP URL response
                //   print("ggg",response.data!)     // server data
                //  print("result",response.result)   // result of response serialization
                
                do{
                    let json = try JSON(data: response.data!)
                    print("json",json)
                    let jsonType = [json] as NSArray
                    print("jsonType",jsonType)
                    jsonResponse = json
                    break
                }
                catch{
                    print("error",error.localizedDescription)
                }
                
            }
            if jsonResponse !=  nil{
                successHandler(jsonResponse)
            }
                
                
            else{
                //     ServiceManagerClass.alert(message: errorF.localizedDescription)
            }
            // KRProgressHUD.dismiss()
//            SVProgressHUD.dismiss()
            sessionManager.session.invalidateAndCancel()
        }
    }

    class func requestWithGet(methodName:String , parameter:[String:Any]?, successHandler: @escaping (_ success:JSON) -> Void) {
        let errorDict:[String:Any] = [:]
       // var errorJson:JSON = JSON(errorDict)

            var jsonResponse:JSON!
            let urlString = baseUrl.appending("\(methodName)")
            print(urlString)
        if UserDefaults.standard.value(forKey: "token") != nil
        {
            bearerToken = UserDefaults.standard.value(forKey: "token") as! String
        }

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            
            "Authorization" : "Bearer " + bearerToken
        ]
        
            Alamofire.request(urlString, method: .get, parameters:[:], encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                switch response.result{
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        GIFHUD.shared.dismiss()
                    }
                    //  errorJson = ["status":"Failed","message":error.localizedDescription]
                    // SVProgressHUD.dismiss()
                    // successHandler(errorJson)
                    ServiceManagerClass.alert(message: error.localizedDescription)
                    break
                case .success(let value):
//                    print(value)
//                    print(response.request!)  // original URL request
//                    print(response.response!) // HTTP URL response
//                    print(response.data!)     // server data
//                    print(response.result)   // result of response serialization

                    let json = JSON(data: response.data!)
                    print("\(json)")
                    jsonResponse = json
                    successHandler(jsonResponse)
                    break
                }
//                SVProgressHUD.dismiss()
        }
//        else
//        {
//            errorJson = ["status":0,"message":"Network is Unreachable"]
//            successHandler(errorJson)
//            ServiceManagerClass.alert(message: "Network is Unreachable")
//        }
    }
        
        class func requestWithMultipart(methodName:String , image1:UIImage, parameter:[String:Any]?, successHandler: @escaping (_ success:JSON) -> Void)
        {
                let parameters: Parameters = parameter!
                var jsonResponse:JSON!
                let urlString = baseUrl.appending("\(methodName)")
            if UserDefaults.standard.value(forKey: "token") != nil
            {
                bearerToken = UserDefaults.standard.value(forKey: "token") as! String
            }
                let headers: HTTPHeaders = [
                    "Content-type": "application/json",
                    "Authorization" : "Bearer " + bearerToken
                ]
                Alamofire.upload(multipartFormData: { (multipartFormData) in
                    if image1.size.width != 0
                    {
                        multipartFormData.append(image1.jpegData(compressionQuality: 0.5)!, withName: "logo", fileName: "image1.jpeg", mimeType: "image/jpeg")
                    }
                    
                    for (key, value) in parameters {
                        print(key)
                        print(value)
                        if key == "logo"
                        {
                            let imgData = (value as! UIImage).pngData()
                            let val = imgData?.base64EncodedString()
//                            print(val!)
                            multipartFormData.append((val!).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                        }
                        else
                        {
                            multipartFormData.append((value as! String).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                        }
//                        print(multipartFormData)
                    }
                }, to: urlString, method: .post , headers:headers, encodingCompletion: { (result) in
                    switch result {
                    case .success(let upload,_,_):
                        upload.uploadProgress(closure: { (progress) in
                            print(progress.fractionCompleted * 100)
                            delegate?.progress(val: Float(progress.fractionCompleted))
                        })
                        upload.responseJSON(completionHandler: { (response) in
                            let json = JSON(data: response.data!)
                            print("\(json)")
                            jsonResponse = json
                            successHandler(jsonResponse)
                        })
                    case .failure(let error):
                        print(error)
    
                    }
                })
        }
    
    class func requestWithMultipartEdit(methodName:String , image1:UIImage, parameter:[String:Any]?, successHandler: @escaping (_ success:JSON) -> Void)
            {
                    let parameters: Parameters = parameter!
                    var jsonResponse:JSON!
                    let urlString = baseUrl.appending("\(methodName)")
                if UserDefaults.standard.value(forKey: "token") != nil
                {
                    bearerToken = UserDefaults.standard.value(forKey: "token") as! String
                }
                    let headers: HTTPHeaders = [
                        "Content-type": "application/json",
                        "Authorization" : "Bearer " + bearerToken
                    ]
                    Alamofire.upload(multipartFormData: { (multipartFormData) in
                        if image1.size.width != 0
                        {
                            multipartFormData.append(image1.jpegData(compressionQuality: 0.5)!, withName: "avatar", fileName: "image1.jpeg", mimeType: "image/jpeg")
                        }
                        
                        for (key, value) in parameters {
                            print(key)
                            print(value)
                            if key == "avatar"
                            {
                                let imgData = (value as! UIImage).pngData()
                                let val = imgData?.base64EncodedString()
    //                            print(val!)
                                multipartFormData.append((val!).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                            }
                            else
                            {
                                multipartFormData.append((value as! String).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                            }
    //                        print(multipartFormData)
                        }
                    }, to: urlString, method: .post , headers:headers, encodingCompletion: { (result) in
                        switch result {
                        case .success(let upload,_,_):
                            upload.uploadProgress(closure: { (progress) in
                                print(progress.fractionCompleted * 100)
                                delegate?.progress(val: Float(progress.fractionCompleted))
                            })
                            upload.responseJSON(completionHandler: { (response) in
                                let json = JSON(data: response.data!)
                                print("\(json)")
                                jsonResponse = json
                                successHandler(jsonResponse)
                            })
                        case .failure(let error):
                            print(error)
        
                        }
                    })
            }
    
    
    
    class func requestWithMultipartMultiple(methodName:String , image1:UIImage,image2: UIImage, parameter:[String:Any]?, successHandler: @escaping (_ success:JSON) -> Void)
        {
                let parameters: Parameters = parameter!
                var jsonResponse:JSON!
                let urlString = baseUrl.appending("\(methodName)")
            if UserDefaults.standard.value(forKey: "token") != nil
            {
                bearerToken = UserDefaults.standard.value(forKey: "token") as! String
            }
                let headers: HTTPHeaders = [
                    "Content-type": "application/json",
                    "Authorization" : "Bearer " + bearerToken
                ]
                Alamofire.upload(multipartFormData: { (multipartFormData) in
                    if image1.size.width != 0 && image2.size.width != 0
                    {
                        multipartFormData.append(image1.jpegData(compressionQuality: 0.5)!, withName: "front_image", fileName: "image1.jpeg", mimeType: "image/jpeg")
                        multipartFormData.append(image2.jpegData(compressionQuality: 0.5)!, withName: "back_image", fileName: "image2.jpeg", mimeType: "image/jpeg")
                    }
                    
                    for (key, value) in parameters {
                        print(key)
                        print(value)
                        if key == "front_image" || key == "back_image"
                        {
                            let imgData = (value as! UIImage).pngData()
                            let val = imgData?.base64EncodedString()
//                            print(val!)
                            multipartFormData.append((val!).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                        }
                        else
                        {
                            multipartFormData.append((value as! String).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                        }
//                        print(multipartFormData)
                    }
                }, to: urlString, method: .post , headers:headers, encodingCompletion: { (result) in
                    switch result {
                    case .success(let upload,_,_):
                        upload.uploadProgress(closure: { (progress) in
                            print(progress.fractionCompleted * 100)
                            delegate?.progress(val: Float(progress.fractionCompleted))
                        })
                        upload.responseJSON(completionHandler: { (response) in
                            let json = JSON(data: response.data!)
                            print("\(json)")
                            jsonResponse = json
                            successHandler(jsonResponse)
                        })
                    case .failure(let error):
                        print(error)
    
                    }
                })
        }
    
    
    
    
    class func topMostController() -> UIViewController {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController

        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController!
    }
    
    class func alert(message:String){
        GIFHUD.shared.dismiss()
        let alert=UIAlertController(title: "Alert!", message: message, preferredStyle: .alert);
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            
        }
        alert.addAction(cancelAction)
        ServiceManagerClass.topMostController().present(alert, animated: true, completion: nil);

    }
//    class func alert(message:String){
//        let alert=UIAlertController(title: "Alert", message: message, preferredStyle: .alert);
//        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
//            
//        }
//        alert.addAction(cancelAction)
//        ServiceManager.topMostController().present(alert, animated: true, completion: nil);
//    }
    
//    fileprivate func showLoadingHUD() {
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        hud?.labelText = "vent venligst"
//    }
//    fileprivate func hideLoadingHUD() {
//        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
//    }

    func getDate(dt: String) -> String
    {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let showDate = inputFormatter.date(from: "\(dt)")
        inputFormatter.dateFormat = "MMM d, yyyy "
        let resultString = inputFormatter.string(from: showDate!)
        print(resultString)
        return resultString
    }
}

