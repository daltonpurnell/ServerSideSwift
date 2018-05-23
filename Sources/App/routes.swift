import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("hello", "vapor") { req in
        return "Hello vapor!"
    }
    
    router.get("hello", String.parameter) { req -> String in
        let name = try req.parameters.next(String.self)
        return "Hello \(name)!"
    }
    
    router.post(InfoData.self, at: "info") { req, data -> InfoReponse in
        return InfoReponse(request: data)
    }
    
    router.get("date") { req in
        return "\(Date())"
    }
    
    router.get("counter", Int.parameter) { req -> CountJSON in
        let count = try req.parameters.next(Int.self)
        return CountJSON(count: count)
    }
    
    router.post(UserInfoData.self, at: "user-info") {req, data -> UserInfoResponse in
        return UserInfoResponse(request: data)
    }
    
    
    struct InfoData:Content {
        let name:String
    }
    
    struct InfoReponse: Content {
        let request:InfoData
    }
    
    struct CountJSON: Content {
        let count: Int
    }
    
    struct UserInfoData: Content {
        let name: String
        let age: Int
        
    }
    
    struct UserInfoResponse: Content {
        let request: UserInfoData
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
