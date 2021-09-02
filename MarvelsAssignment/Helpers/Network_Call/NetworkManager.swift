//
//  NetworkManager.swift
//  MarvelsAssignment
//
//  Created by Arka on 26/08/21.
//

import Foundation
import Alamofire

let DEBUG = true

class SSFiles
{
    var url:URL?
    var image:UIImage?
    var name: String = "File"
    var oldUrl: String?
    
    init(url:URL)
    {
        self.url = url
        name = (url.absoluteString as NSString).lastPathComponent
    }
    
    init(image:UIImage)
    {
        self.image = image
        name = "image"
    }
    
    init(oldUrl: String)
    {
        self.oldUrl = oldUrl
    }
}

class NetworkManager
{
    //http://103.207.168.164:8024/api/
    static let PROTOCOL:String = "http://";
    static let SUB_DOMAIN:String =  "";
    static let DOMAIN:String = "103.207.168.164:8024/";//Production Service End http://52.67.219.144/
    static var languges:String = ""
    static let API_DIR:String = "api/";
    static let SITE_URL = PROTOCOL + SUB_DOMAIN + DOMAIN;
    static let API_URL = SITE_URL  + API_DIR;
    static let STORAGE_URL = SITE_URL + "storage/";
    static let PRIVACY_POLICY_URL = "\(DOMAIN)"
    static let TERMS_AND_CONDITIONS = "\(DOMAIN)"
    
    static func callService(url:String, parameters:Parameters, httpMethod:HTTPMethod = .post, completion:@escaping (NetworkResponseState) -> Void)
    {
        let api_Url = API_URL + url
        var  tokenDict:HTTPHeaders = [:]
        //        if LoginUserModel.shared.isLogin {
        if LoginUserModel.shared.token != ""
        {
            tokenDict = ["Content-Type": "application/json","Authorization": "Token \(LoginUserModel.shared.token)" ]
        }
        else
        {
            tokenDict = ["Content-Type": "application/json" ]
        }
        print("Token \(LoginUserModel.shared.token)")
        //		print("parms \(parameters)")
        Alamofire.request(api_Url, method:httpMethod, parameters:parameters, encoding: JSONEncoding.default,headers: tokenDict).responseJSON
            {
                response in
                print("Request: \(String(describing: response.request))")   // original url request
                //            print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(String(describing: response.result.value))")                   // response serialization result
                
                
                guard response.result.isSuccess else {
                    completion(.failed("Something went wrong!!"))
                    print("Error while fetching json: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else
                {
                    completion(.failed("Something went wrong!!"))
                    print("invalid json recieved from server: \(String(describing: response.result.error))")
                    return
                }
                
                if response.response?.statusCode == 200
                {
                    completion(.success(responseJSON) )
                }
                else
                {
                    completion(.failed("Something went wrong!!"))
                }
        }
    }
    
    static func callServicePut(url:String, parameters:Parameters, httpMethod:HTTPMethod = .put, completion:@escaping (NetworkResponseState) -> Void)
    {
        let api_Url = API_URL + url
        var  tokenDict:HTTPHeaders = [:]
        //        if LoginUserModel.shared.isLogin {
        if LoginUserModel.shared.token != ""
        {
            tokenDict = ["Content-Type": "application/json","Authorization": "Token \(LoginUserModel.shared.token)" ]
        }
        else
        {
            tokenDict = ["Content-Type": "application/json" ]
        }
        print("Token \(LoginUserModel.shared.token)")
        //        print("parms \(parameters)")
        Alamofire.request(api_Url, method:httpMethod, parameters:parameters, encoding: JSONEncoding.default,headers: tokenDict).responseJSON
            {
                response in
                print("Request: \(String(describing: response.request))")   // original url request
                //            print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(String(describing: response.result.value))")                   // response serialization result
                
                guard response.result.isSuccess else
                {
                    completion(.failed("Something went wrong!!"))
                    print("Error while fetching json: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else
                {
                    completion(.failed("Something went wrong!!"))
                    print("invalid json recieved from server: \(String(describing: response.result.error))")
                    return
                }
                
                if response.response?.statusCode == 200
                {
                    completion(.success(responseJSON) )
                }
                else
                {
                    completion(.failed("Something went wrong!!"))
                }
        }
    }
    
    static func callServiceForResetPassword(url:String, parameters:Parameters, token : String,httpMethod:HTTPMethod = .post, completion:@escaping (NetworkResponseState) -> Void)
    {
        let api_Url = API_URL + url
        var  tokenDict:HTTPHeaders = [:]
        tokenDict = ["Content-Type": "application/json","Authorization": "Token \(token)" ]
        print("Token \(LoginUserModel.shared.token)")
        //        print("parms \(parameters)")
        Alamofire.request(api_Url, method:httpMethod, parameters:parameters, encoding: JSONEncoding.default,headers: tokenDict).responseJSON
            {
                response in
                print("Request: \(String(describing: response.request))")   // original url request
                //print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(String(describing: response.result.value))")                   // response serialization result
                
                
                guard response.result.isSuccess else
                {
                    completion(.failed("Something went wrong!!"))
                    print("Error while fetching json: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else
                {
                    completion(.failed("Something went wrong!!"))
                    print("invalid json recieved from server: \(String(describing: response.result.error))")
                    return
                }
                
                if response.response?.statusCode == 200
                {
                    completion(.success(responseJSON) )
                }
                else
                {
                    completion(.failed("Something went wrong!!"))
                }
        }
    }
    
    
    static func callServiceLogin(url:String, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void)
    {
        let api_Url = API_URL + url
        let TokenDict = ["Content-Type": "application/json","APP-TYPE" : "customer_app"]
        
        Alamofire.request(api_Url, method:.post, parameters:parameters, encoding: JSONEncoding.default, headers: TokenDict).responseJSON
            {
                response in
                print("Request: \(String(describing: response.request))")   // original url request
                //print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(String(describing: response.result.value))")                         // response serialization result
                guard response.result.isSuccess else
                {
                    completion(.failed("Something went wrong!!"))
                    print("Error while fetching json: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else
                {
                    completion(.failed("Something went wrong!!"))
                    print("invalid json recieved from server: \(String(describing: response.result.error))")
                    return
                }
                
                if response.response?.statusCode == 200
                {
                    completion(.success(responseJSON) )
                }
                else
                {
                    completion(.failed("Something went wrong!!"))
                }
        }
    }
    
    static func callServiceMultipalFiles(url:String, files:[SSFiles], parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void)
    {
        var  tokenDict:HTTPHeaders = [:]
        //        if LoginUserModel.shared.isLogin {
        if LoginUserModel.shared.token != ""
        {
            tokenDict = ["Content-Type": "application/json","Authorization": "Token \(LoginUserModel.shared.token)" ]
        }
        else
        {
            tokenDict = ["Content-Type": "application/json" ]
        }
        print("Token \(LoginUserModel.shared.token)")
        Alamofire.upload(
            multipartFormData:
            {
                multipartFormData in
                var count = 0
                for item in files {
                    if let fileUrl = item.url
                    {
                        do {
                                let data = try Data(contentsOf: fileUrl )
                                multipartFormData.append(data, withName: "post_file[\(count)]",fileName: (fileUrl.absoluteString as NSString).lastPathComponent, mimeType: "application/octet-stream")
                                count = count + 1
                        }
                        catch let error
                        {
                            print(error)
                        }
                    }
                    else if let image = item.image
                    {
                        guard let imageData = image.jpegData(compressionQuality: 1.0) else
                        {
                            print("Could not get JPEG representation of UIImage")
                            return
                        }
                        multipartFormData.append(imageData, withName: "post_file[\(count)]",fileName:"\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
                        count = count + 1
                    }
                    else if let oldImage: String = item.oldUrl
                    {
                        multipartFormData.append((oldImage as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: "post_file[\(count)]")
                        count = count + 1
                    }
                }
                for (key, value) in parameters
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to:  url, headers: tokenDict)
        {
            (encodingResult) in
            switch encodingResult
            {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print("Request: \(String(describing: response.request))")   // original url request
                        //print("Response: \(String(describing: response.response))") // http url response
                        print("Result: \(String(describing: response.result.value))")                         // response serialization result
                        
                        
                        guard response.result.isSuccess else
                        {
                            completion(.failed("Something went wrong!!"))
                            print("Error while fetching json: \(String(describing: response.result.error))")
                            return
                        }
                        guard let responseJSON = response.result.value as? [String: Any] else {
                            completion(.failed("Something went wrong!!"))
                            print("invalid json recieved from server: \(String(describing: response.result.error))")
                            return
                        }
                        
                        if response.response?.statusCode == 200
                        {
                            completion(.success(responseJSON) )
                        }
                        else
                        {
                            completion(.failed("Something went wrong!!"))
                        }
                    }
                case .failure(let encodingError):
                    completion(.failed("Something went wrong!!"))
            }
        }
    }
    
    static func callService(url:String, file:URL?, image:UIImage?, completion:@escaping (NetworkResponseState) -> Void)
    {
        Alamofire.upload(
            multipartFormData:
            {
                multipartFormData in
                
                if let file:URL = file
                {
                    do
                    {
                        let data = try Data(contentsOf: file )
                        multipartFormData.append(data, withName: "file", fileName: (file.absoluteString as NSString).lastPathComponent, mimeType: "application/octet-stream")
                        
                    }
                    catch let error
                    {
                        print(error)
                    }
                }
                if let item:UIImage = image
                {
                    guard let imageData = item.jpegData(compressionQuality: 1.0) else
                    {
                        print("Could not get JPEG representation of UIImage")
                        return
                        
                    }
                    multipartFormData.append(imageData, withName: "file", fileName:"photoasdscac.jpg" ,mimeType: "image/jpg")
                }
                
                
        }, to:  url)
        {
            (encodingResult) in
            switch encodingResult
            {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print("Request: \(String(describing: response.request))")   // original url request
                        //print("Response: \(String(describing: response.response))") // http url response
                        print("Result: \(String(describing: response.result.value))") // response serialization result
                        
                        
                        guard response.result.isSuccess else {
                            completion(.failed("Something went wrong!!"))
                            print("Error while fetching json: \(String(describing: response.result.error))")
                            return
                        }
                        guard let responseJSON = response.result.value as? [String: Any] else
                        {
                            completion(.failed("Something went wrong!!"))
                            print("invalid json recieved from server: \(String(describing: response.result.error))")
                            return
                        }
                        
                        if response.response?.statusCode == 200
                        {
                            completion(.success(responseJSON) )
                        }
                        else
                        {
                            completion(.failed("Something went wrong!!"))
                        }
                    }
                case .failure(let encodingError):
                    completion(.failed("Something went wrong!!"))
            }
        }
    }
    
    static func callServiceUpdate(url:String,imgKey : String, parameters:Parameters, file:UIImage, method:HTTPMethod, completion:@escaping (NetworkResponseState) -> Void)
    {
        let api_Url = API_URL + url
        var  tokenDict:HTTPHeaders = [:]
        if LoginUserModel.shared.token != ""
        {
            tokenDict = ["Content-Type": "application/json","Authorization": "Token \(LoginUserModel.shared.token)" ]
        }
        else
        {
            tokenDict = ["Content-Type": "application/json" ]
        }
        
        Alamofire.upload(
            multipartFormData:
            {
                multipartFormData in
                
                if let item:UIImage = file
                {
                    let imageData = item.jpegData(compressionQuality: 1.0)
                    
                    if file.size.width != 0
                    {
                        multipartFormData.append(imageData!, withName: imgKey, fileName:"photo.jpg" ,mimeType: "image/jpg")
                    }
                }
                for (key, value) in parameters
                {
                    print("key is sendinggggggggggggg", key)
                    var valueStr = String()
                    if let param = value as? String{
                        valueStr = param
                    }
                    else
                    {
                        let valueInt = value as! Int
                        valueStr = String(valueInt)
                    }
                    
                    multipartFormData.append((valueStr).data(using: String.Encoding.utf8)!, withName: key)
                    //multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to:  api_Url, method: method, headers:tokenDict)
        {
            (encodingResult) in
            switch encodingResult
            {
                case .success(let upload, _, _):
                    upload.responseJSON
                        {
                            response in
                            print("Request: \(String(describing: response.request))")   // original url request
                            //print("Response: \(String(describing: response.response))") // http url response
                            print("Result: \(String(describing: response.result.value))")                         // response serialization result
                            
                            
                            guard response.result.isSuccess else
                            {
                                completion(.failed("Something went wrong!!"))
                                print("Error while fetching json: \(String(describing: response.result.error))")
                                return
                            }
                            guard let responseJSON = response.result.value as? [String: Any] else
                            {
                                completion(.failed("Something went wrong!!"))
                                print("invalid json recieved from server: \(String(describing: response.result.error))")
                                return
                            }
                            
                            if response.response?.statusCode == 200
                            {
                                completion(.success(responseJSON) )
                            }
                            else
                            {
                                completion(.failed("Something went wrong!!"))
                            }
                    }
                case .failure(let encodingError):
                    completion(.failed("Something went wrong!!"))
            }
        }
    }
    
    
    static func callService(url:String, completion:@escaping (NetworkResponseState) -> Void)
    {
        let api_Url = API_URL + url
        var tokenDict:HTTPHeaders = [:]
        if LoginUserModel.shared.isLogin
        {
            tokenDict = ["Content-Type": "application/json", "Authorization": "Token \(LoginUserModel.shared.token)" ]
        }
        else
        {
            tokenDict = ["Content-Type": "application/json" ]
        }
        
        Alamofire.request(api_Url, method:.get, headers:tokenDict).responseJSON
            {
                response in
                print("Request: \(String(describing: response.request))")   // original url request
                //print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(String(describing: response.result.value))")                   // response serialization result
                
                guard response.result.isSuccess else
                {
                    completion(.failed("Something went wrong!!"))
                    print("Error while fetching json: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else
                {
                    completion(.failed("Something went wrong!!"))
                    print("invalid json recieved from server: \(String(describing: response.result.error))")
                    return
                }
                
                if response.response?.statusCode == 200
                {
                    completion(.success(responseJSON) )
                }
                else if response.response?.statusCode == 401
                {
                    //LoginUserModel.shared.logout()
                    
                }
                else
                {
                    completion(.failed("Something went wrong!!"))
                }
        }
    }
    
    static func callServiceDelete(url:String, completion:@escaping (NetworkResponseState) -> Void)
    {
        let api_Url = API_URL + url
        var tokenDict:HTTPHeaders = [:]
        if LoginUserModel.shared.isLogin
        {
            tokenDict = ["Content-Type": "application/json", "Authorization": "Token \(LoginUserModel.shared.token)" ]
        }
        else
        {
            tokenDict = ["Content-Type": "application/json" ]
        }
        
        Alamofire.request(api_Url, method:.delete, headers:tokenDict).responseJSON
            {
                response in
                print("Request: \(String(describing: response.request))")   // original url request
                //print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(String(describing: response.result.value))")                   // response serialization result
                
                
                guard response.result.isSuccess else
                {
                    completion(.failed("Something went wrong!!"))
                    print("Error while fetching json: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else
                {
                    completion(.failed("Something went wrong!!"))
                    print("invalid json recieved from server: \(String(describing: response.result.error))")
                    return
                }
                
                if response.response?.statusCode == 200
                {
                    completion(.success(responseJSON) )
                }
                else if response.response?.statusCode == 401
                {
                    //LoginUserModel.shared.logout()
                    
                }
                else
                {
                    completion(.failed("Something went wrong!!"))
                }
        }
    }
}

enum NetworkResponseState
{
    case success([String:Any])
    case failed(String)
}

//MARK:- mange multiple storyboard instance

enum AppStoryboard : String
{
    case Main = "Main"
    case Home = "Home"
    case booking = "Booking"
    case EditProfile = "EditProfile"
    case MyFamily = "MyFamily"
    var instance : UIStoryboard
    {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T
    {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else
        {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController?
    {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController
{
    class var storyboardID : String
    {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self
    {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
}
