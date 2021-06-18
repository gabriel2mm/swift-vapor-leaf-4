import Vapor
import Leaf
import Fluent
import FluentMySQLDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))// Configure Leaf
    app.views.use(.leaf)
    
    app.databases.use(.mysql(hostname: "127.0.0.1", username: "root", password: "root", database: "vapor", tlsConfiguration: .forClient(certificateVerification: .none)), as: .mysql)
    
    app.migrations.add(UserEntiyMigrate())
    
    // register routes
    try routes(app)
}
