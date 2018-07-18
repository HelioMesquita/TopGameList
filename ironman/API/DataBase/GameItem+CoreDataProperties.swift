import Foundation
import CoreData

extension GameItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameItem> {
        return NSFetchRequest<GameItem>(entityName: "GameItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageLink: String?
    @NSManaged public var viewers: Int32
    @NSManaged public var channels: Int32
}
