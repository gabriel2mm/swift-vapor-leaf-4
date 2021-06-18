import Foundation
import Fluent
import FluentMySQLDriver
import Vapor

struct UserEntiyMigrate : Migration{
    
    func prepare(on database: Database) -> EventLoopFuture<Void>{
        database.schema("users")
            .id()
            .field("name", .string)
            .create()
    }
    
    func revert(on database : Database) -> EventLoopFuture<Void>{
        database.schema("users").delete()
    }
}

