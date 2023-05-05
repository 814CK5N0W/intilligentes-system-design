import Fluent
import Vapor

final class Planet: Model, Content {
    static let schema = "planet"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "ImgURL")
    var imgUrl: String

    init() { }

    init(id: UUID? = nil, imgURL: String) {
        self.id = id
        self.imgUrl = imgURL
    }
}
