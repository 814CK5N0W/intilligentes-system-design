import Fluent

struct CreatePlanet: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("planet")
            .id()
            .field("imgURL", .string, .required)
            .field("classifiedNAME", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("planet").delete()
    }
}
