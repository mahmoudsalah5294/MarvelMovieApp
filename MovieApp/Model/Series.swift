//
//  Series.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 17/06/2023.


import Foundation

// MARK: - Series
struct Series: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let resourceURI: String?
    let urls: [URLElement]?
    let startYear, endYear: Int?
    let rating: Rating?
    let type: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let creators: Creators?
    let characters: Characters?
    let stories: Stories?
    let comics, events: Characters?
    let next: Next?
    let previous: JSONNull?
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Next]?
    let returned: Int?
}

// MARK: - Next
struct Next: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CreatorsItem]?
    let returned: Int?
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String?
    let name, role: String?
}

enum Rating: String, Codable {
    case empty = ""
    case marvelPsr = "Marvel Psr"
    case ratedT = "Rated T"
    case ratingRatedT = "Rated T+"
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String?
    let name: String?
    let type: ItemType?
}

enum ItemType: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: Extension?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case jpg = "jpg"
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType?
    let url: String?
}

enum URLType: String, Codable {
    case detail = "detail"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
