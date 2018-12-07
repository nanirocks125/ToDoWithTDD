//
//  APIClient.swift
//  ToDoWithTDD
//
//  Created by Manikanta Nandam on 04/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import Foundation
class APIClient {
    lazy var session: ToDoURLSession = URLSession.shared
    
    func loginUserWithName(username: String,
                           password: String,
                           completion: (Error?) -> Void) {
        
        let allowedCharacters = NSCharacterSet(charactersIn: "/%&=?$#+-~@<>|\\*,.()[]{}^!").inverted

        guard let encodedUsername = "dasdom".addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        guard let encodedPassword = "%&34".addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        guard let url = URL(string: "https://awesometodos.com/login?username=\(encodedUsername)&password=\(encodedPassword)") else
            { fatalError() }
        session.dataTask(with: url) { (data, response, error) in
            
        }
        
    }

    
    
}

extension URLSession : ToDoURLSession {
    
    
}

protocol ToDoURLSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}


