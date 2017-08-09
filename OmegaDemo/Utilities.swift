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
            let originURL = documentsURL?.appendingPathComponent(fileName)
            var error: NSError?
            do {
                try fileManager.copyItem(atPath: (originURL?.path)!, toPath: dbPath!)
            } catch let error1 as NSError {
                error = error1
                print("couldnt copy to destination. error: \(error?.description ?? "")")
            }
            let errorMsg = "Copying file " + fileName + " failed. \(error?.localizedDescription ?? "error")"
            let successMsg = "Successfully copied file " + fileName
            let alertController = UIAlertController.init(title: ((error == nil) ? "Success": "Failed"), message: (error == nil) ? successMsg: errorMsg, preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            alertController.show(animated: true, vibrate: false, completion: nil)
        }
    }
}
