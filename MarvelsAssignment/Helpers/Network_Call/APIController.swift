//
//  APIController.swift
//  MarvelsAssignment
//
//  Created by Arka on 26/08/21.
//

import UIKit

class APIController: NSObject
{
    //MARK:- CHARACTER LIST
    
    static func getCharacterList( hashVal : String, timestamp: Int, apiKey: String, SuccessHandler: @escaping (_ responce:JSON) -> Void)
    {
        guard Reachability.isConnectedToNetwork() else{
            ServiceManagerClass.alert(message: "Please check your internet connection")
            return
        }

        ServiceManagerClass.requestWithGet(methodName: "characters?ts=\(timestamp)&apikey=\(apiKey)&hash=\(hashVal)", parameter: [:]) { (jsonResponse) in
            if(jsonResponse["code"] == 200)
            {
                SuccessHandler(jsonResponse)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    GIFHUD.shared.dismiss()
                }
            }
            else
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    GIFHUD.shared.dismiss()
                    ServiceManagerClass.alert(message: "error")
                }
            }
        }
    }
    
    static func getCharacterDetails( charId : String, hashVal : String, timestamp: Int, apiKey: String, userKey:String ,SuccessHandler: @escaping (_ responce:JSON) -> Void)
    {
        guard Reachability.isConnectedToNetwork() else{
            ServiceManagerClass.alert(message: "Please check your internet connection")
            return
        }

        ServiceManagerClass.requestWithGet(methodName: "characters/\(charId)?apikey=\(apiKey)&hash=\(hashVal)&userKey=\(userKey)&ts=\(timestamp)", parameter: [:]) { (jsonResponse) in
            if(jsonResponse["code"] == 200)
            {
                SuccessHandler(jsonResponse)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    GIFHUD.shared.dismiss()
                }
            }
            else
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    GIFHUD.shared.dismiss()
                    ServiceManagerClass.alert(message: "error")
                }
            }
        }
    }
    static func getComicsList( charId : String, hashVal : String, timestamp: Int, apiKey: String ,SuccessHandler: @escaping (_ responce:JSON) -> Void)
      {
        guard Reachability.isConnectedToNetwork() else{
          ServiceManagerClass.alert(message: "Please check your internet connection")
          return
        }
        ServiceManagerClass.requestWithGet(methodName: "characters/\(charId)/comics?apikey=\(apiKey)&hash=\(hashVal)&ts=\(timestamp)", parameter: [:]) { (jsonResponse) in
          if(jsonResponse["code"] == 200)
          {
            SuccessHandler(jsonResponse)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                GIFHUD.shared.dismiss()
            }
          }
          else
          {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                GIFHUD.shared.dismiss()
                ServiceManagerClass.alert(message: "error")
            }
          }
        }
      }
    static func getCreatorList( comicId : String, hashVal : String, timestamp: Int, apiKey: String ,SuccessHandler: @escaping (_ responce:JSON) -> Void)
      {
        guard Reachability.isConnectedToNetwork() else{
          ServiceManagerClass.alert(message: "Please check your internet connection")
          return
        }
        ServiceManagerClass.requestWithGet(methodName: "comics/\(comicId)/creators?apikey=\(apiKey)&hash=\(hashVal)&ts=\(timestamp)", parameter: [:]) { (jsonResponse) in
          if(jsonResponse["code"] == 200)
          {
            SuccessHandler(jsonResponse)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              GIFHUD.shared.dismiss()
            }
          }
          else
          {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              GIFHUD.shared.dismiss()
              ServiceManagerClass.alert(message: "error")
            }
          }
        }
      }
}
//characters?ts=1629976982&apikey=cec189837f9653f40351d4dfe75c39c9&hash=fab47967f013f8811cc2789008505e78
