//
//  DBHelper.swift
//  OmegaDemo
//
//  Created by Administrator on 7/20/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import Foundation
import SQLite

class DBHelper {

    static let dbName = "testDB"
    
    static func makeConnection() -> (Connection?, Bool) {
        do {
            let path = Utility.getPath(filename: "testDB")
            let db = try Connection(path!)
            return (db, true)
        } catch {
            print("Failed to connect to database");
            return (nil, false)
        }

    }

    static func deleteAllEntriesForTable(table: Table!, forDB db: Connection!) -> Bool {
        do {
            try db.run(table.delete())
            return true;
        } catch {
            return false
        }
    }

}
