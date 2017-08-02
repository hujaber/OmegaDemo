//
//  Utility.swift
//  OmegaDemo
//
//  Created by Administrator on 7/28/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func getPath(filename: String) -> String? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentsURL?.appendingPathComponent(filename)
        return fileURL?.path
    }

    static func copyFiles(fileName: String!) {
        let dbPath = getPath(filename: fileName)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath!) {
            let documentsURL = Bundle.main.resourceURL
            let fromPath = documentsURL?.appendingPathComponent(fileName)
            var error: NSError?
            do {
                try fileManager.copyItem(atPath: (fromPath?.path)!, toPath: dbPath!)
            } catch let error1 as NSError {
                error = error1
                print("couldnt copy to destination. error: \(error?.description ?? "")")
            }

            let alertController = UIAlertController.init()
            if error != nil {
                alertController.title = "Failed"
                alertController.message = "Copying the database failed. \(error?.localizedDescription ?? "error")"
            } else {
                alertController.title = "Success"
                alertController.message = "Successfully copied DB"
            }

            alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            let appdelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

            appdelegate.window?.rootViewController?.presentedViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
