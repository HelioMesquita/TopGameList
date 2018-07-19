import Foundation
import CoreData

extension GameDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameDB> {
        return NSFetchRequest<GameDB>(entityName: "GameDB")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageLink: String?
    @NSManaged public var viewers: Int32
    @NSManaged public var channels: Int32
}
