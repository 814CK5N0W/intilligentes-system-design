import Fluent
import Vapor

struct PlanetController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let Planets = routes.grouped("Planets")
        Planets.get(use: index)
        Planets.post(use: create)
        Planets.group(":PlanetID") { Planet in
            Planet.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Planet] {
        try await Planet.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Planet {
        let Planet = try req.content.decode(Planet.self)
        try await Planet.save(on: req.db)
        return Planet
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let Planet = try await Planet.find(req.parameters.get("PlanetID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await Planet.delete(on: req.db)
        return .noContent
    }
}
