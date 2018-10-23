import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
  
  router.post("api","acronyms") { req -> Future<Acronym> in
    return try req.content.decode(Acronym.self)
      .flatMap(to: Acronym.self) { acronym in
        return acronym.save(on: req)
      }
  }
  
  router.get("api","acronyms") { req -> Future<[Acronym]> in
    return Acronym.query(on: req).all()
  }
  
  router.get("api","acronyms", Acronym.parameter) { req -> Future<Acronym> in
    return try req.parameters.next(Acronym.self)
  }
  
}
