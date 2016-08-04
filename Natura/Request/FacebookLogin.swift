//
//  FacebookLogin.swift
//  Natura
//
//  Created by Gerlandio Lucena on 26/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FacebookLogin: NSObject {

    func fbSDKLogin(fromView: UIViewController, callback: defaultResponse) {
        FBSDKLoginManager().logInWithReadPermissions(["public_profile", "email", "user_friends", "user_photos"], fromViewController: fromView) { (loginResult, error) in
            
            if error != nil {
                
                callback(response: "Não foi possível fazer o login.", error: "Erro ao logar")
                
            } else if (loginResult.isCancelled) {
                
                callback(response: "Não foi possível fazer o login, a operação foi cancelada.", error: "Operação cancelada")
                
            } else {
                
                NotificationBase.FacebookLogged.notifyWithObject(loginResult)
                
                if let token = FBSDKAccessToken.currentAccessToken().tokenString where token != "" {
                    callback(response: "Login realizado com sucesso.", error: nil)
                }
                
            }
        }
    }
    
    func fbSDKAlbum(albumID: String, callback: defaultResponse) {
        FBSDKGraphRequest(graphPath: "/\(albumID)", parameters: ["fields":""]).startWithCompletionHandler { (connection, result, error) in
            //TODO: Implement request of 
        }
    }
    
    func fbSDKAlbunsList(callback: defaultResponse) {
        let parameters = ["fields": "is_default, location, message, name, place, privacy"]
        FBSDKGraphRequest(graphPath: "/me/albums", parameters: parameters).startWithCompletionHandler { (connection, result, error) in
            if error != nil {
                
            } else if let responseDictionary = result as? NSDictionary {
                do{
                    let albumsList = try AlbumsList(map: Mapper(json: responseDictionary))
                    NotificationBase.FacebookAlbum.notifyWithObject(albumsList)
                    callback(response: "Recuperando albuns.", error: nil)
                } catch let errorCast as NSError {
                    callback(response: "O usuário não autorizou o acesso a seus albuns. Erro:\(errorCast.description)", error: "Sem autorização")
                }
            }
        }
    }
    
    func fbSDKLoadTaggableFriends() {
        let parameters = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
        
        FBSDKGraphRequest(graphPath: "/me/taggable_friends", parameters: parameters).startWithCompletionHandler { (connection, result, error) in
            
            if error != nil {
                NotificationBase.FacebookTaggedFriends.notifyWithObject(["Error": error, "Message": "Não foi possível consultar os amigos do usuário"])
            }
            else if let responseDictionary = result as? NSDictionary {
                do{
                    let taggableFriendsList = try FriendsList(map: Mapper(json: responseDictionary))
                    NotificationBase.FacebookTaggedFriends.notifyWithObject(taggableFriendsList)
                } catch let errorCast as NSError {
                    NotificationBase.FacebookTaggedFriends.notifyWithObject(["Error":errorCast, "Message": "Não foi possível consultar os amigos do usuário"])
                }
            } else {
                NotificationBase.FacebookTaggedFriends.notifyWithObject(["Error":"Não foi possível converter o resultado para o tipo necessário", "Message": "Não foi possível consultar os amigos do usuário"])
            }
        }
    }
    
    func fbSDKFriendsOnApp() {
        let parameters = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
        
        FBSDKGraphRequest(graphPath: "/me/friends", parameters: parameters).startWithCompletionHandler { (connection, result, error) in
            
            if error != nil {
                NotificationBase.FacebookTaggedFriends.notifyWithObject(["Error": error, "Message": "Não foi possível consultar os amigos do usuário"])
            }
            else if let responseDictionary = result as? NSDictionary {
                do{
                    let usingFriendsList = try FriendsList(map: Mapper(json: responseDictionary))
                    NotificationBase.FacebookInApp.notifyWithObject(usingFriendsList)
                } catch let errorCast as NSError {
                    NotificationBase.FacebookInApp.notifyWithObject(["Error":errorCast, "Message": "Não foi possível consultar os amigos do usuário"])
                }
            } else {
                NotificationBase.FacebookInApp.notifyWithObject(["Error":"Não foi possível converter o resultado para o tipo necessário", "Message": "Não foi possível consultar os amigos do usuário"])
            }
        }
    }
    
    func fbSDKInvitibleFriends() {
        let parameters = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
        
        FBSDKGraphRequest(graphPath: "/me/invitable_friends", parameters: parameters).startWithCompletionHandler { (connection, result, error) in
            
            if error != nil {
                NotificationBase.FacebookTaggedFriends.notifyWithObject(["Error": error, "Message": "Não foi possível consultar os amigos do usuário"])
            }
            else if let responseDictionary = result as? NSDictionary {
                do{
                    let invitableFriendsList = try FriendsList(map: Mapper(json: responseDictionary))
                    NotificationBase.FacebookInvitableFriends.notifyWithObject(invitableFriendsList)
                } catch let errorCast as NSError {
                    NotificationBase.FacebookInvitableFriends.notifyWithObject(["Error":errorCast, "Message": "Não foi possível consultar os amigos do usuário"])
                }
            } else {
                NotificationBase.FacebookInvitableFriends.notifyWithObject(["Error":"Não foi possível converter o resultado para o tipo necessário", "Message": "Não foi possível consultar os amigos do usuário"])
            }
        }
    }
    
}

