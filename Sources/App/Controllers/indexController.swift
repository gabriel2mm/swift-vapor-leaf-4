import Vapor
import Leaf
import Fluent
import FluentMySQLDriver

struct IndexHandlerController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        routes.get( use: indexHandler)
        routes.get("users", use: newUserHandler)
        routes.post("users", use: saveUser)
    }
    
    func indexHandler(_ req: Request) -> EventLoopFuture<View> {
        return req.view.render("index", ["title": "name"])
    }
    
    func newUserHandler(_ req: Request) throws -> EventLoopFuture<View>{
        return UserEntity.query(on: req.db).all().flatMap{ users -> EventLoopFuture<View> in
            return req.view.render("users", UsersContext(users: users))
        }
        
    }
    
    func saveUser(_ req : Request) throws -> EventLoopFuture<View>{
        let user = try req.content.decode(UserEntity.self)
        user.save(on: req.db)
        
        return UserEntity.query(on: req.db).all().flatMap{ users -> EventLoopFuture<View> in
            return req.view.render("users", UsersContext(users: users))
        }
    }
}

struct UsersContext: Encodable, Content{
    var users: [UserEntity]
}
