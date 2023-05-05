import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.workingDirectory))
    app.routes.defaultMaxBodySize = "10mb"
    app.get { req async throws in
        try await req.view.render("index", ["planets": [""]])
    }

    app.post("upload") { req -> EventLoopFuture<String> in
    struct Input: Content {
        var file: File
    }
    let input = try req.content.decode(Input.self)

    let path = app.directory.publicDirectory + input.file.filename
    
    return req.application.fileio.openFile(path: path,
                                           mode: .write,
                                           flags: .allowFileCreation(posixMode: 0x744),
                                           eventLoop: req.eventLoop)
        .flatMap { handle in
            req.application.fileio.write(fileHandle: handle,
                                         buffer: input.file.data,
                                         eventLoop: req.eventLoop)
                .flatMapThrowing { _ in
                    try handle.close()
                    return input.file.filename
                }
        }
}
    
    try app.register(collection: PlanetController())
}
