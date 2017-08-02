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

    fileprivate static let dbName = "testDB"

    enum CoordinatesTableColumn {
        static let xColumn = Expression<Double>("x")
        static let yColumn = Expression<Double>("y")
    }

    static func makeConnection() -> (db: Connection?,success: Bool) {
        do {
            let path = Utilities.getPath(filename: dbName)
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

    static func insertInto(table: Table!, db: Connection!, x: Double, y: Double) -> (success: Bool, error: Error?) {
        do {
            try db.run(table.insert(CoordinatesTableColumn.xColumn <- x, CoordinatesTableColumn.yColumn <- y))
            return (true, nil)
        } catch  {
            return (false, error)
        }
    }
}
