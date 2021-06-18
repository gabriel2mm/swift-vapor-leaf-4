import Vapor
import Leaf


func routes(_ app: Application) throws {

    let indexController = IndexHandlerController()
    try app.register(collection: indexController)
}
