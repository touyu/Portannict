// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum StatusState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case wannaWatch
  case watching
  case watched
  case onHold
  case stopWatching
  case noState
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "WANNA_WATCH": self = .wannaWatch
      case "WATCHING": self = .watching
      case "WATCHED": self = .watched
      case "ON_HOLD": self = .onHold
      case "STOP_WATCHING": self = .stopWatching
      case "NO_STATE": self = .noState
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .wannaWatch: return "WANNA_WATCH"
      case .watching: return "WATCHING"
      case .watched: return "WATCHED"
      case .onHold: return "ON_HOLD"
      case .stopWatching: return "STOP_WATCHING"
      case .noState: return "NO_STATE"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: StatusState, rhs: StatusState) -> Bool {
    switch (lhs, rhs) {
      case (.wannaWatch, .wannaWatch): return true
      case (.watching, .watching): return true
      case (.watched, .watched): return true
      case (.onHold, .onHold): return true
      case (.stopWatching, .stopWatching): return true
      case (.noState, .noState): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [StatusState] {
    return [
      .wannaWatch,
      .watching,
      .watched,
      .onHold,
      .stopWatching,
      .noState,
    ]
  }
}

/// Season name
public enum SeasonName: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case winter
  case spring
  case summer
  case autumn
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "WINTER": self = .winter
      case "SPRING": self = .spring
      case "SUMMER": self = .summer
      case "AUTUMN": self = .autumn
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .winter: return "WINTER"
      case .spring: return "SPRING"
      case .summer: return "SUMMER"
      case .autumn: return "AUTUMN"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: SeasonName, rhs: SeasonName) -> Bool {
    switch (lhs, rhs) {
      case (.winter, .winter): return true
      case (.spring, .spring): return true
      case (.summer, .summer): return true
      case (.autumn, .autumn): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [SeasonName] {
    return [
      .winter,
      .spring,
      .summer,
      .autumn,
    ]
  }
}

/// Media of anime
public enum Media: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case tv
  case ova
  case movie
  case web
  case other
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "TV": self = .tv
      case "OVA": self = .ova
      case "MOVIE": self = .movie
      case "WEB": self = .web
      case "OTHER": self = .other
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .tv: return "TV"
      case .ova: return "OVA"
      case .movie: return "MOVIE"
      case .web: return "WEB"
      case .other: return "OTHER"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Media, rhs: Media) -> Bool {
    switch (lhs, rhs) {
      case (.tv, .tv): return true
      case (.ova, .ova): return true
      case (.movie, .movie): return true
      case (.web, .web): return true
      case (.other, .other): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [Media] {
    return [
      .tv,
      .ova,
      .movie,
      .web,
      .other,
    ]
  }
}

public enum RatingState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case great
  case good
  case average
  case bad
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "GREAT": self = .great
      case "GOOD": self = .good
      case "AVERAGE": self = .average
      case "BAD": self = .bad
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .great: return "GREAT"
      case .good: return "GOOD"
      case .average: return "AVERAGE"
      case .bad: return "BAD"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: RatingState, rhs: RatingState) -> Bool {
    switch (lhs, rhs) {
      case (.great, .great): return true
      case (.good, .good): return true
      case (.average, .average): return true
      case (.bad, .bad): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [RatingState] {
    return [
      .great,
      .good,
      .average,
      .bad,
    ]
  }
}

public final class GetFollowingActivitiesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetFollowingActivities($first: Int, $after: String) {
      viewer {
        __typename
        followingActivities(first: $first, after: $after, orderBy: {field: CREATED_AT, direction: DESC}) {
          __typename
          edges {
            __typename
            cursor
            node {
              __typename
              ... on Record {
                ...RecordFragment
              }
              ... on Review {
                ...ReviewFragment
              }
              ... on Status {
                ...StatusFragment
              }
              ... on MultipleRecord {
                id
              }
            }
          }
          pageInfo {
            __typename
            endCursor
            hasNextPage
          }
        }
      }
    }
    """

  public let operationName: String = "GetFollowingActivities"

  public let operationIdentifier: String? = "328f1961c2207bf997267917c6b221c7f44418e0cda032daec3bafb7a6d5ac52"

  public var queryDocument: String { return operationDefinition.appending(RecordFragment.fragmentDefinition).appending(UserFragment.fragmentDefinition).appending(WorkFragment.fragmentDefinition).appending(EpisodeFragment.fragmentDefinition).appending(ReviewFragment.fragmentDefinition).appending(StatusFragment.fragmentDefinition) }

  public var first: Int?
  public var after: String?

  public init(first: Int? = nil, after: String? = nil) {
    self.first = first
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["first": first, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .object(Viewer.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.flatMap { (value: Viewer) -> ResultMap in value.resultMap }])
    }

    public var viewer: Viewer? {
      get {
        return (resultMap["viewer"] as? ResultMap).flatMap { Viewer(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("followingActivities", arguments: ["first": GraphQLVariable("first"), "after": GraphQLVariable("after"), "orderBy": ["field": "CREATED_AT", "direction": "DESC"]], type: .object(FollowingActivity.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(followingActivities: FollowingActivity? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "followingActivities": followingActivities.flatMap { (value: FollowingActivity) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var followingActivities: FollowingActivity? {
        get {
          return (resultMap["followingActivities"] as? ResultMap).flatMap { FollowingActivity(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "followingActivities")
        }
      }

      public struct FollowingActivity: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ActivityConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .list(.object(Edge.selections))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "ActivityConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ActivityEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(cursor: String, node: Node? = nil) {
            self.init(unsafeResultMap: ["__typename": "ActivityEdge", "cursor": cursor, "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A cursor for use in pagination.
          public var cursor: String {
            get {
              return resultMap["cursor"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "cursor")
            }
          }

          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["MultipleRecord", "Record", "Review", "Status"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLTypeCase(
                  variants: ["Record": AsRecord.selections, "Review": AsReview.selections, "Status": AsStatus.selections, "MultipleRecord": AsMultipleRecord.selections],
                  default: [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  ]
                )
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public static func makeRecord(id: GraphQLID, annictId: Int, comment: String? = nil, ratingState: RatingState? = nil, createdAt: String, user: AsRecord.User, work: AsRecord.Work, episode: AsRecord.Episode) -> Node {
              return Node(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "comment": comment, "ratingState": ratingState, "createdAt": createdAt, "user": user.resultMap, "work": work.resultMap, "episode": episode.resultMap])
            }

            public static func makeReview(id: GraphQLID, annictId: Int, title: String? = nil, body: String, ratingAnimationState: RatingState? = nil, ratingOverallState: RatingState? = nil, ratingMusicState: RatingState? = nil, ratingStoryState: RatingState? = nil, ratingCharacterState: RatingState? = nil, createdAt: String, user: AsReview.User, work: AsReview.Work) -> Node {
              return Node(unsafeResultMap: ["__typename": "Review", "id": id, "annictId": annictId, "title": title, "body": body, "ratingAnimationState": ratingAnimationState, "ratingOverallState": ratingOverallState, "ratingMusicState": ratingMusicState, "ratingStoryState": ratingStoryState, "ratingCharacterState": ratingCharacterState, "createdAt": createdAt, "user": user.resultMap, "work": work.resultMap])
            }

            public static func makeStatus(id: GraphQLID, annictId: Int, createdAt: String, state: StatusState, user: AsStatus.User, work: AsStatus.Work) -> Node {
              return Node(unsafeResultMap: ["__typename": "Status", "id": id, "annictId": annictId, "createdAt": createdAt, "state": state, "user": user.resultMap, "work": work.resultMap])
            }

            public static func makeMultipleRecord(id: GraphQLID) -> Node {
              return Node(unsafeResultMap: ["__typename": "MultipleRecord", "id": id])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var asRecord: AsRecord? {
              get {
                if !AsRecord.possibleTypes.contains(__typename) { return nil }
                return AsRecord(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
              }
            }

            public struct AsRecord: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Record"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                  GraphQLField("comment", type: .scalar(String.self)),
                  GraphQLField("ratingState", type: .scalar(RatingState.self)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("user", type: .nonNull(.object(User.selections))),
                  GraphQLField("work", type: .nonNull(.object(Work.selections))),
                  GraphQLField("episode", type: .nonNull(.object(Episode.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID, annictId: Int, comment: String? = nil, ratingState: RatingState? = nil, createdAt: String, user: User, work: Work, episode: Episode) {
                self.init(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "comment": comment, "ratingState": ratingState, "createdAt": createdAt, "user": user.resultMap, "work": work.resultMap, "episode": episode.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: GraphQLID {
                get {
                  return resultMap["id"]! as! GraphQLID
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              public var annictId: Int {
                get {
                  return resultMap["annictId"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "annictId")
                }
              }

              public var comment: String? {
                get {
                  return resultMap["comment"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "comment")
                }
              }

              public var ratingState: RatingState? {
                get {
                  return resultMap["ratingState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingState")
                }
              }

              public var createdAt: String {
                get {
                  return resultMap["createdAt"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "createdAt")
                }
              }

              public var user: User {
                get {
                  return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "user")
                }
              }

              public var work: Work {
                get {
                  return Work(unsafeResultMap: resultMap["work"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "work")
                }
              }

              public var episode: Episode {
                get {
                  return Episode(unsafeResultMap: resultMap["episode"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "episode")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var recordFragment: RecordFragment {
                  get {
                    return RecordFragment(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }

              public struct User: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["User"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    GraphQLField("username", type: .nonNull(.scalar(String.self))),
                    GraphQLField("avatarUrl", type: .scalar(String.self)),
                    GraphQLField("description", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
                  self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return resultMap["id"]! as! GraphQLID
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var name: String {
                  get {
                    return resultMap["name"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "name")
                  }
                }

                public var username: String {
                  get {
                    return resultMap["username"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "username")
                  }
                }

                public var avatarUrl: String? {
                  get {
                    return resultMap["avatarUrl"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "avatarUrl")
                  }
                }

                public var description: String {
                  get {
                    return resultMap["description"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "description")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var userFragment: UserFragment {
                    get {
                      return UserFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public struct Work: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Work"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("title", type: .nonNull(.scalar(String.self))),
                    GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("seasonName", type: .scalar(SeasonName.self)),
                    GraphQLField("seasonYear", type: .scalar(Int.self)),
                    GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
                    GraphQLField("media", type: .nonNull(.scalar(Media.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
                  self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return resultMap["id"]! as! GraphQLID
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var annictId: Int {
                  get {
                    return resultMap["annictId"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "annictId")
                  }
                }

                public var title: String {
                  get {
                    return resultMap["title"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "title")
                  }
                }

                public var episodesCount: Int {
                  get {
                    return resultMap["episodesCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "episodesCount")
                  }
                }

                public var watchersCount: Int {
                  get {
                    return resultMap["watchersCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "watchersCount")
                  }
                }

                public var reviewsCount: Int {
                  get {
                    return resultMap["reviewsCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "reviewsCount")
                  }
                }

                public var seasonName: SeasonName? {
                  get {
                    return resultMap["seasonName"] as? SeasonName
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "seasonName")
                  }
                }

                public var seasonYear: Int? {
                  get {
                    return resultMap["seasonYear"] as? Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "seasonYear")
                  }
                }

                public var viewerStatusState: StatusState? {
                  get {
                    return resultMap["viewerStatusState"] as? StatusState
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "viewerStatusState")
                  }
                }

                public var media: Media {
                  get {
                    return resultMap["media"]! as! Media
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "media")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var workFragment: WorkFragment {
                    get {
                      return WorkFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public struct Episode: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Episode"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("title", type: .scalar(String.self)),
                    GraphQLField("numberText", type: .scalar(String.self)),
                    GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, viewerRecordsCount: Int) {
                  self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "viewerRecordsCount": viewerRecordsCount])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return resultMap["id"]! as! GraphQLID
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var annictId: Int {
                  get {
                    return resultMap["annictId"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "annictId")
                  }
                }

                public var title: String? {
                  get {
                    return resultMap["title"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "title")
                  }
                }

                public var numberText: String? {
                  get {
                    return resultMap["numberText"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "numberText")
                  }
                }

                public var viewerRecordsCount: Int {
                  get {
                    return resultMap["viewerRecordsCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "viewerRecordsCount")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var episodeFragment: EpisodeFragment {
                    get {
                      return EpisodeFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }
            }

            public var asReview: AsReview? {
              get {
                if !AsReview.possibleTypes.contains(__typename) { return nil }
                return AsReview(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
              }
            }

            public struct AsReview: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Review"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                  GraphQLField("title", type: .scalar(String.self)),
                  GraphQLField("body", type: .nonNull(.scalar(String.self))),
                  GraphQLField("ratingAnimationState", type: .scalar(RatingState.self)),
                  GraphQLField("ratingOverallState", type: .scalar(RatingState.self)),
                  GraphQLField("ratingMusicState", type: .scalar(RatingState.self)),
                  GraphQLField("ratingStoryState", type: .scalar(RatingState.self)),
                  GraphQLField("ratingCharacterState", type: .scalar(RatingState.self)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("user", type: .nonNull(.object(User.selections))),
                  GraphQLField("work", type: .nonNull(.object(Work.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID, annictId: Int, title: String? = nil, body: String, ratingAnimationState: RatingState? = nil, ratingOverallState: RatingState? = nil, ratingMusicState: RatingState? = nil, ratingStoryState: RatingState? = nil, ratingCharacterState: RatingState? = nil, createdAt: String, user: User, work: Work) {
                self.init(unsafeResultMap: ["__typename": "Review", "id": id, "annictId": annictId, "title": title, "body": body, "ratingAnimationState": ratingAnimationState, "ratingOverallState": ratingOverallState, "ratingMusicState": ratingMusicState, "ratingStoryState": ratingStoryState, "ratingCharacterState": ratingCharacterState, "createdAt": createdAt, "user": user.resultMap, "work": work.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: GraphQLID {
                get {
                  return resultMap["id"]! as! GraphQLID
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              public var annictId: Int {
                get {
                  return resultMap["annictId"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "annictId")
                }
              }

              public var title: String? {
                get {
                  return resultMap["title"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "title")
                }
              }

              public var body: String {
                get {
                  return resultMap["body"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "body")
                }
              }

              public var ratingAnimationState: RatingState? {
                get {
                  return resultMap["ratingAnimationState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingAnimationState")
                }
              }

              public var ratingOverallState: RatingState? {
                get {
                  return resultMap["ratingOverallState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingOverallState")
                }
              }

              public var ratingMusicState: RatingState? {
                get {
                  return resultMap["ratingMusicState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingMusicState")
                }
              }

              public var ratingStoryState: RatingState? {
                get {
                  return resultMap["ratingStoryState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingStoryState")
                }
              }

              public var ratingCharacterState: RatingState? {
                get {
                  return resultMap["ratingCharacterState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingCharacterState")
                }
              }

              public var createdAt: String {
                get {
                  return resultMap["createdAt"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "createdAt")
                }
              }

              public var user: User {
                get {
                  return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "user")
                }
              }

              public var work: Work {
                get {
                  return Work(unsafeResultMap: resultMap["work"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "work")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var reviewFragment: ReviewFragment {
                  get {
                    return ReviewFragment(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }

              public struct User: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["User"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    GraphQLField("username", type: .nonNull(.scalar(String.self))),
                    GraphQLField("avatarUrl", type: .scalar(String.self)),
                    GraphQLField("description", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
                  self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return resultMap["id"]! as! GraphQLID
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var name: String {
                  get {
                    return resultMap["name"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "name")
                  }
                }

                public var username: String {
                  get {
                    return resultMap["username"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "username")
                  }
                }

                public var avatarUrl: String? {
                  get {
                    return resultMap["avatarUrl"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "avatarUrl")
                  }
                }

                public var description: String {
                  get {
                    return resultMap["description"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "description")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var userFragment: UserFragment {
                    get {
                      return UserFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public struct Work: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Work"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("title", type: .nonNull(.scalar(String.self))),
                    GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("seasonName", type: .scalar(SeasonName.self)),
                    GraphQLField("seasonYear", type: .scalar(Int.self)),
                    GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
                    GraphQLField("media", type: .nonNull(.scalar(Media.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
                  self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return resultMap["id"]! as! GraphQLID
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var annictId: Int {
                  get {
                    return resultMap["annictId"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "annictId")
                  }
                }

                public var title: String {
                  get {
                    return resultMap["title"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "title")
                  }
                }

                public var episodesCount: Int {
                  get {
                    return resultMap["episodesCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "episodesCount")
                  }
                }

                public var watchersCount: Int {
                  get {
                    return resultMap["watchersCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "watchersCount")
                  }
                }

                public var reviewsCount: Int {
                  get {
                    return resultMap["reviewsCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "reviewsCount")
                  }
                }

                public var seasonName: SeasonName? {
                  get {
                    return resultMap["seasonName"] as? SeasonName
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "seasonName")
                  }
                }

                public var seasonYear: Int? {
                  get {
                    return resultMap["seasonYear"] as? Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "seasonYear")
                  }
                }

                public var viewerStatusState: StatusState? {
                  get {
                    return resultMap["viewerStatusState"] as? StatusState
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "viewerStatusState")
                  }
                }

                public var media: Media {
                  get {
                    return resultMap["media"]! as! Media
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "media")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var workFragment: WorkFragment {
                    get {
                      return WorkFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }
            }

            public var asStatus: AsStatus? {
              get {
                if !AsStatus.possibleTypes.contains(__typename) { return nil }
                return AsStatus(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
              }
            }

            public struct AsStatus: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Status"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("state", type: .nonNull(.scalar(StatusState.self))),
                  GraphQLField("user", type: .nonNull(.object(User.selections))),
                  GraphQLField("work", type: .nonNull(.object(Work.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID, annictId: Int, createdAt: String, state: StatusState, user: User, work: Work) {
                self.init(unsafeResultMap: ["__typename": "Status", "id": id, "annictId": annictId, "createdAt": createdAt, "state": state, "user": user.resultMap, "work": work.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: GraphQLID {
                get {
                  return resultMap["id"]! as! GraphQLID
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              public var annictId: Int {
                get {
                  return resultMap["annictId"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "annictId")
                }
              }

              public var createdAt: String {
                get {
                  return resultMap["createdAt"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "createdAt")
                }
              }

              public var state: StatusState {
                get {
                  return resultMap["state"]! as! StatusState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "state")
                }
              }

              public var user: User {
                get {
                  return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "user")
                }
              }

              public var work: Work {
                get {
                  return Work(unsafeResultMap: resultMap["work"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "work")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var statusFragment: StatusFragment {
                  get {
                    return StatusFragment(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }

              public struct User: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["User"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    GraphQLField("username", type: .nonNull(.scalar(String.self))),
                    GraphQLField("avatarUrl", type: .scalar(String.self)),
                    GraphQLField("description", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
                  self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return resultMap["id"]! as! GraphQLID
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var name: String {
                  get {
                    return resultMap["name"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "name")
                  }
                }

                public var username: String {
                  get {
                    return resultMap["username"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "username")
                  }
                }

                public var avatarUrl: String? {
                  get {
                    return resultMap["avatarUrl"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "avatarUrl")
                  }
                }

                public var description: String {
                  get {
                    return resultMap["description"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "description")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var userFragment: UserFragment {
                    get {
                      return UserFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public struct Work: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Work"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("title", type: .nonNull(.scalar(String.self))),
                    GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("seasonName", type: .scalar(SeasonName.self)),
                    GraphQLField("seasonYear", type: .scalar(Int.self)),
                    GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
                    GraphQLField("media", type: .nonNull(.scalar(Media.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
                  self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return resultMap["id"]! as! GraphQLID
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var annictId: Int {
                  get {
                    return resultMap["annictId"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "annictId")
                  }
                }

                public var title: String {
                  get {
                    return resultMap["title"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "title")
                  }
                }

                public var episodesCount: Int {
                  get {
                    return resultMap["episodesCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "episodesCount")
                  }
                }

                public var watchersCount: Int {
                  get {
                    return resultMap["watchersCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "watchersCount")
                  }
                }

                public var reviewsCount: Int {
                  get {
                    return resultMap["reviewsCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "reviewsCount")
                  }
                }

                public var seasonName: SeasonName? {
                  get {
                    return resultMap["seasonName"] as? SeasonName
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "seasonName")
                  }
                }

                public var seasonYear: Int? {
                  get {
                    return resultMap["seasonYear"] as? Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "seasonYear")
                  }
                }

                public var viewerStatusState: StatusState? {
                  get {
                    return resultMap["viewerStatusState"] as? StatusState
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "viewerStatusState")
                  }
                }

                public var media: Media {
                  get {
                    return resultMap["media"]! as! Media
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "media")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var workFragment: WorkFragment {
                    get {
                      return WorkFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }
            }

            public var asMultipleRecord: AsMultipleRecord? {
              get {
                if !AsMultipleRecord.possibleTypes.contains(__typename) { return nil }
                return AsMultipleRecord(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
              }
            }

            public struct AsMultipleRecord: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["MultipleRecord"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID) {
                self.init(unsafeResultMap: ["__typename": "MultipleRecord", "id": id])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: GraphQLID {
                get {
                  return resultMap["id"]! as! GraphQLID
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }
}

public final class GetUserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetUser($username: String!) {
      user(username: $username) {
        __typename
        ...UserFragment
      }
    }
    """

  public let operationName: String = "GetUser"

  public let operationIdentifier: String? = "82718d3fac6860babf60481e49f8bd842e44727cf17acaeffcc20de77669d214"

  public var queryDocument: String { return operationDefinition.appending(UserFragment.fragmentDefinition) }

  public var username: String

  public init(username: String) {
    self.username = username
  }

  public var variables: GraphQLMap? {
    return ["username": username]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("user", arguments: ["username": GraphQLVariable("username")], type: .object(User.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
    }

    public var user: User? {
      get {
        return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("username", type: .nonNull(.scalar(String.self))),
          GraphQLField("avatarUrl", type: .scalar(String.self)),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var username: String {
        get {
          return resultMap["username"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var avatarUrl: String? {
        get {
          return resultMap["avatarUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var userFragment: UserFragment {
          get {
            return UserFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class GetViewerQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetViewer {
      viewer {
        __typename
        id
        annictId
        name
        username
        avatarUrl
        description
        wannaWatchCount
        watchingCount
        watchedCount
        onHoldCount
        stopWatchingCount
      }
    }
    """

  public let operationName: String = "GetViewer"

  public let operationIdentifier: String? = "439135c366daff60762a9040bc7e788dbb8b6c95ef2b9d249a14c1e2181fda89"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .object(Viewer.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.flatMap { (value: Viewer) -> ResultMap in value.resultMap }])
    }

    public var viewer: Viewer? {
      get {
        return (resultMap["viewer"] as? ResultMap).flatMap { Viewer(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("username", type: .nonNull(.scalar(String.self))),
          GraphQLField("avatarUrl", type: .scalar(String.self)),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("wannaWatchCount", type: .nonNull(.scalar(Int.self))),
          GraphQLField("watchingCount", type: .nonNull(.scalar(Int.self))),
          GraphQLField("watchedCount", type: .nonNull(.scalar(Int.self))),
          GraphQLField("onHoldCount", type: .nonNull(.scalar(Int.self))),
          GraphQLField("stopWatchingCount", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, annictId: Int, name: String, username: String, avatarUrl: String? = nil, description: String, wannaWatchCount: Int, watchingCount: Int, watchedCount: Int, onHoldCount: Int, stopWatchingCount: Int) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "annictId": annictId, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description, "wannaWatchCount": wannaWatchCount, "watchingCount": watchingCount, "watchedCount": watchedCount, "onHoldCount": onHoldCount, "stopWatchingCount": stopWatchingCount])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var annictId: Int {
        get {
          return resultMap["annictId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "annictId")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var username: String {
        get {
          return resultMap["username"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var avatarUrl: String? {
        get {
          return resultMap["avatarUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var wannaWatchCount: Int {
        get {
          return resultMap["wannaWatchCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "wannaWatchCount")
        }
      }

      public var watchingCount: Int {
        get {
          return resultMap["watchingCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "watchingCount")
        }
      }

      public var watchedCount: Int {
        get {
          return resultMap["watchedCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "watchedCount")
        }
      }

      public var onHoldCount: Int {
        get {
          return resultMap["onHoldCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "onHoldCount")
        }
      }

      public var stopWatchingCount: Int {
        get {
          return resultMap["stopWatchingCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "stopWatchingCount")
        }
      }
    }
  }
}

public final class GetViewerWorksQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetViewerWorks($first: Int, $after: String, $state: StatusState!) {
      viewer {
        __typename
        works(first: $first, after: $after, state: $state, orderBy: {direction: DESC, field: WATCHERS_COUNT}) {
          __typename
          edges {
            __typename
            node {
              __typename
              ...WorkFragment
            }
          }
        }
      }
    }
    """

  public let operationName: String = "GetViewerWorks"

  public let operationIdentifier: String? = "da28f4048d2537a3ee229489ef3b24356ca568d5e5f5354efd9e258195cf29b7"

  public var queryDocument: String { return operationDefinition.appending(WorkFragment.fragmentDefinition) }

  public var first: Int?
  public var after: String?
  public var state: StatusState

  public init(first: Int? = nil, after: String? = nil, state: StatusState) {
    self.first = first
    self.after = after
    self.state = state
  }

  public var variables: GraphQLMap? {
    return ["first": first, "after": after, "state": state]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .object(Viewer.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.flatMap { (value: Viewer) -> ResultMap in value.resultMap }])
    }

    public var viewer: Viewer? {
      get {
        return (resultMap["viewer"] as? ResultMap).flatMap { Viewer(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("works", arguments: ["first": GraphQLVariable("first"), "after": GraphQLVariable("after"), "state": GraphQLVariable("state"), "orderBy": ["direction": "DESC", "field": "WATCHERS_COUNT"]], type: .object(Work.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(works: Work? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "works": works.flatMap { (value: Work) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var works: Work? {
        get {
          return (resultMap["works"] as? ResultMap).flatMap { Work(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "works")
        }
      }

      public struct Work: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["WorkConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .list(.object(Edge.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "WorkConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["WorkEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil) {
            self.init(unsafeResultMap: ["__typename": "WorkEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Work"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                GraphQLField("title", type: .nonNull(.scalar(String.self))),
                GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
                GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
                GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
                GraphQLField("seasonName", type: .scalar(SeasonName.self)),
                GraphQLField("seasonYear", type: .scalar(Int.self)),
                GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
                GraphQLField("media", type: .nonNull(.scalar(Media.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
              self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var annictId: Int {
              get {
                return resultMap["annictId"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "annictId")
              }
            }

            public var title: String {
              get {
                return resultMap["title"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "title")
              }
            }

            public var episodesCount: Int {
              get {
                return resultMap["episodesCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "episodesCount")
              }
            }

            public var watchersCount: Int {
              get {
                return resultMap["watchersCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "watchersCount")
              }
            }

            public var reviewsCount: Int {
              get {
                return resultMap["reviewsCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "reviewsCount")
              }
            }

            public var seasonName: SeasonName? {
              get {
                return resultMap["seasonName"] as? SeasonName
              }
              set {
                resultMap.updateValue(newValue, forKey: "seasonName")
              }
            }

            public var seasonYear: Int? {
              get {
                return resultMap["seasonYear"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "seasonYear")
              }
            }

            public var viewerStatusState: StatusState? {
              get {
                return resultMap["viewerStatusState"] as? StatusState
              }
              set {
                resultMap.updateValue(newValue, forKey: "viewerStatusState")
              }
            }

            public var media: Media {
              get {
                return resultMap["media"]! as! Media
              }
              set {
                resultMap.updateValue(newValue, forKey: "media")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var workFragment: WorkFragment {
                get {
                  return WorkFragment(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class SearchEpisodeRecordsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchEpisodeRecords($annictId: Int!, $first: Int, $after: String) {
      searchEpisodes(first: 1, annictIds: [$annictId]) {
        __typename
        edges {
          __typename
          node {
            __typename
            ...EpisodeFragment
            records(first: $first, after: $after, orderBy: {direction: DESC, field: CREATED_AT}, hasComment: true) {
              __typename
              edges {
                __typename
                node {
                  __typename
                  ...RecordFragment
                }
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "SearchEpisodeRecords"

  public let operationIdentifier: String? = "163a13c98eb8c34ab6b6ee97db879d653683ea4bbd1b4c735119412762ab203e"

  public var queryDocument: String { return operationDefinition.appending(EpisodeFragment.fragmentDefinition).appending(RecordFragment.fragmentDefinition).appending(UserFragment.fragmentDefinition).appending(WorkFragment.fragmentDefinition) }

  public var annictId: Int
  public var first: Int?
  public var after: String?

  public init(annictId: Int, first: Int? = nil, after: String? = nil) {
    self.annictId = annictId
    self.first = first
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["annictId": annictId, "first": first, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("searchEpisodes", arguments: ["first": 1, "annictIds": [GraphQLVariable("annictId")]], type: .object(SearchEpisode.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchEpisodes: SearchEpisode? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "searchEpisodes": searchEpisodes.flatMap { (value: SearchEpisode) -> ResultMap in value.resultMap }])
    }

    public var searchEpisodes: SearchEpisode? {
      get {
        return (resultMap["searchEpisodes"] as? ResultMap).flatMap { SearchEpisode(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "searchEpisodes")
      }
    }

    public struct SearchEpisode: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["EpisodeConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(edges: [Edge?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "EpisodeConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of edges.
      public var edges: [Edge?]? {
        get {
          return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
        }
      }

      public struct Edge: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["EpisodeEdge"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(node: Node? = nil) {
          self.init(unsafeResultMap: ["__typename": "EpisodeEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The item at the end of the edge.
        public var node: Node? {
          get {
            return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Episode"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
              GraphQLField("title", type: .scalar(String.self)),
              GraphQLField("numberText", type: .scalar(String.self)),
              GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
              GraphQLField("records", arguments: ["first": GraphQLVariable("first"), "after": GraphQLVariable("after"), "orderBy": ["direction": "DESC", "field": "CREATED_AT"], "hasComment": true], type: .object(Record.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, viewerRecordsCount: Int, records: Record? = nil) {
            self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "viewerRecordsCount": viewerRecordsCount, "records": records.flatMap { (value: Record) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var annictId: Int {
            get {
              return resultMap["annictId"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "annictId")
            }
          }

          public var title: String? {
            get {
              return resultMap["title"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          public var numberText: String? {
            get {
              return resultMap["numberText"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "numberText")
            }
          }

          public var viewerRecordsCount: Int {
            get {
              return resultMap["viewerRecordsCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "viewerRecordsCount")
            }
          }

          public var records: Record? {
            get {
              return (resultMap["records"] as? ResultMap).flatMap { Record(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "records")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var episodeFragment: EpisodeFragment {
              get {
                return EpisodeFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }

          public struct Record: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["RecordConnection"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("edges", type: .list(.object(Edge.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(edges: [Edge?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "RecordConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of edges.
            public var edges: [Edge?]? {
              get {
                return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
              }
            }

            public struct Edge: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["RecordEdge"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("node", type: .object(Node.selections)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(node: Node? = nil) {
                self.init(unsafeResultMap: ["__typename": "RecordEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The item at the end of the edge.
              public var node: Node? {
                get {
                  return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "node")
                }
              }

              public struct Node: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Record"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("comment", type: .scalar(String.self)),
                    GraphQLField("ratingState", type: .scalar(RatingState.self)),
                    GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                    GraphQLField("user", type: .nonNull(.object(User.selections))),
                    GraphQLField("work", type: .nonNull(.object(Work.selections))),
                    GraphQLField("episode", type: .nonNull(.object(Episode.selections))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, annictId: Int, comment: String? = nil, ratingState: RatingState? = nil, createdAt: String, user: User, work: Work, episode: Episode) {
                  self.init(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "comment": comment, "ratingState": ratingState, "createdAt": createdAt, "user": user.resultMap, "work": work.resultMap, "episode": episode.resultMap])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return resultMap["id"]! as! GraphQLID
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var annictId: Int {
                  get {
                    return resultMap["annictId"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "annictId")
                  }
                }

                public var comment: String? {
                  get {
                    return resultMap["comment"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "comment")
                  }
                }

                public var ratingState: RatingState? {
                  get {
                    return resultMap["ratingState"] as? RatingState
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "ratingState")
                  }
                }

                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var user: User {
                  get {
                    return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "user")
                  }
                }

                public var work: Work {
                  get {
                    return Work(unsafeResultMap: resultMap["work"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "work")
                  }
                }

                public var episode: Episode {
                  get {
                    return Episode(unsafeResultMap: resultMap["episode"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "episode")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var recordFragment: RecordFragment {
                    get {
                      return RecordFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes: [String] = ["User"]

                  public static var selections: [GraphQLSelection] {
                    return [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                      GraphQLField("name", type: .nonNull(.scalar(String.self))),
                      GraphQLField("username", type: .nonNull(.scalar(String.self))),
                      GraphQLField("avatarUrl", type: .scalar(String.self)),
                      GraphQLField("description", type: .nonNull(.scalar(String.self))),
                    ]
                  }

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
                    self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var id: GraphQLID {
                    get {
                      return resultMap["id"]! as! GraphQLID
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "id")
                    }
                  }

                  public var name: String {
                    get {
                      return resultMap["name"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "name")
                    }
                  }

                  public var username: String {
                    get {
                      return resultMap["username"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "username")
                    }
                  }

                  public var avatarUrl: String? {
                    get {
                      return resultMap["avatarUrl"] as? String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "avatarUrl")
                    }
                  }

                  public var description: String {
                    get {
                      return resultMap["description"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "description")
                    }
                  }

                  public var fragments: Fragments {
                    get {
                      return Fragments(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public struct Fragments {
                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public var userFragment: UserFragment {
                      get {
                        return UserFragment(unsafeResultMap: resultMap)
                      }
                      set {
                        resultMap += newValue.resultMap
                      }
                    }
                  }
                }

                public struct Work: GraphQLSelectionSet {
                  public static let possibleTypes: [String] = ["Work"]

                  public static var selections: [GraphQLSelection] {
                    return [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("title", type: .nonNull(.scalar(String.self))),
                      GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("seasonName", type: .scalar(SeasonName.self)),
                      GraphQLField("seasonYear", type: .scalar(Int.self)),
                      GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
                      GraphQLField("media", type: .nonNull(.scalar(Media.self))),
                    ]
                  }

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
                    self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var id: GraphQLID {
                    get {
                      return resultMap["id"]! as! GraphQLID
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "id")
                    }
                  }

                  public var annictId: Int {
                    get {
                      return resultMap["annictId"]! as! Int
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "annictId")
                    }
                  }

                  public var title: String {
                    get {
                      return resultMap["title"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "title")
                    }
                  }

                  public var episodesCount: Int {
                    get {
                      return resultMap["episodesCount"]! as! Int
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "episodesCount")
                    }
                  }

                  public var watchersCount: Int {
                    get {
                      return resultMap["watchersCount"]! as! Int
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "watchersCount")
                    }
                  }

                  public var reviewsCount: Int {
                    get {
                      return resultMap["reviewsCount"]! as! Int
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "reviewsCount")
                    }
                  }

                  public var seasonName: SeasonName? {
                    get {
                      return resultMap["seasonName"] as? SeasonName
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "seasonName")
                    }
                  }

                  public var seasonYear: Int? {
                    get {
                      return resultMap["seasonYear"] as? Int
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "seasonYear")
                    }
                  }

                  public var viewerStatusState: StatusState? {
                    get {
                      return resultMap["viewerStatusState"] as? StatusState
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "viewerStatusState")
                    }
                  }

                  public var media: Media {
                    get {
                      return resultMap["media"]! as! Media
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "media")
                    }
                  }

                  public var fragments: Fragments {
                    get {
                      return Fragments(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public struct Fragments {
                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public var workFragment: WorkFragment {
                      get {
                        return WorkFragment(unsafeResultMap: resultMap)
                      }
                      set {
                        resultMap += newValue.resultMap
                      }
                    }
                  }
                }

                public struct Episode: GraphQLSelectionSet {
                  public static let possibleTypes: [String] = ["Episode"]

                  public static var selections: [GraphQLSelection] {
                    return [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("title", type: .scalar(String.self)),
                      GraphQLField("numberText", type: .scalar(String.self)),
                      GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
                    ]
                  }

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, viewerRecordsCount: Int) {
                    self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "viewerRecordsCount": viewerRecordsCount])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var id: GraphQLID {
                    get {
                      return resultMap["id"]! as! GraphQLID
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "id")
                    }
                  }

                  public var annictId: Int {
                    get {
                      return resultMap["annictId"]! as! Int
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "annictId")
                    }
                  }

                  public var title: String? {
                    get {
                      return resultMap["title"] as? String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "title")
                    }
                  }

                  public var numberText: String? {
                    get {
                      return resultMap["numberText"] as? String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "numberText")
                    }
                  }

                  public var viewerRecordsCount: Int {
                    get {
                      return resultMap["viewerRecordsCount"]! as! Int
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "viewerRecordsCount")
                    }
                  }

                  public var fragments: Fragments {
                    get {
                      return Fragments(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public struct Fragments {
                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public var episodeFragment: EpisodeFragment {
                      get {
                        return EpisodeFragment(unsafeResultMap: resultMap)
                      }
                      set {
                        resultMap += newValue.resultMap
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class SearchWorkEpisodesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchWorkEpisodes($workAnnictId: Int!, $first: Int, $after: String) {
      searchWorks(annictIds: [$workAnnictId]) {
        __typename
        nodes {
          __typename
          ...WorkFragment
          episodes(first: $first, after: $after, orderBy: {direction: ASC, field: SORT_NUMBER}) {
            __typename
            edges {
              __typename
              node {
                __typename
                ...EpisodeFragment
              }
            }
            pageInfo {
              __typename
              endCursor
              hasNextPage
            }
          }
        }
      }
    }
    """

  public let operationName: String = "SearchWorkEpisodes"

  public let operationIdentifier: String? = "bc7fdd907a96b06744895095e150fc76b0f84cf9bb99393a4a531d13618a376d"

  public var queryDocument: String { return operationDefinition.appending(WorkFragment.fragmentDefinition).appending(EpisodeFragment.fragmentDefinition) }

  public var workAnnictId: Int
  public var first: Int?
  public var after: String?

  public init(workAnnictId: Int, first: Int? = nil, after: String? = nil) {
    self.workAnnictId = workAnnictId
    self.first = first
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["workAnnictId": workAnnictId, "first": first, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("searchWorks", arguments: ["annictIds": [GraphQLVariable("workAnnictId")]], type: .object(SearchWork.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchWorks: SearchWork? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "searchWorks": searchWorks.flatMap { (value: SearchWork) -> ResultMap in value.resultMap }])
    }

    public var searchWorks: SearchWork? {
      get {
        return (resultMap["searchWorks"] as? ResultMap).flatMap { SearchWork(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "searchWorks")
      }
    }

    public struct SearchWork: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["WorkConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nodes: [Node?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "WorkConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Work"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("seasonName", type: .scalar(SeasonName.self)),
            GraphQLField("seasonYear", type: .scalar(Int.self)),
            GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
            GraphQLField("media", type: .nonNull(.scalar(Media.self))),
            GraphQLField("episodes", arguments: ["first": GraphQLVariable("first"), "after": GraphQLVariable("after"), "orderBy": ["direction": "ASC", "field": "SORT_NUMBER"]], type: .object(Episode.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media, episodes: Episode? = nil) {
          self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media, "episodes": episodes.flatMap { (value: Episode) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var annictId: Int {
          get {
            return resultMap["annictId"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "annictId")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var episodesCount: Int {
          get {
            return resultMap["episodesCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "episodesCount")
          }
        }

        public var watchersCount: Int {
          get {
            return resultMap["watchersCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "watchersCount")
          }
        }

        public var reviewsCount: Int {
          get {
            return resultMap["reviewsCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var seasonName: SeasonName? {
          get {
            return resultMap["seasonName"] as? SeasonName
          }
          set {
            resultMap.updateValue(newValue, forKey: "seasonName")
          }
        }

        public var seasonYear: Int? {
          get {
            return resultMap["seasonYear"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "seasonYear")
          }
        }

        public var viewerStatusState: StatusState? {
          get {
            return resultMap["viewerStatusState"] as? StatusState
          }
          set {
            resultMap.updateValue(newValue, forKey: "viewerStatusState")
          }
        }

        public var media: Media {
          get {
            return resultMap["media"]! as! Media
          }
          set {
            resultMap.updateValue(newValue, forKey: "media")
          }
        }

        public var episodes: Episode? {
          get {
            return (resultMap["episodes"] as? ResultMap).flatMap { Episode(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "episodes")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var workFragment: WorkFragment {
            get {
              return WorkFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Episode: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["EpisodeConnection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("edges", type: .list(.object(Edge.selections))),
              GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
            self.init(unsafeResultMap: ["__typename": "EpisodeConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of edges.
          public var edges: [Edge?]? {
            get {
              return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
            }
          }

          /// Information to aid in pagination.
          public var pageInfo: PageInfo {
            get {
              return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
            }
          }

          public struct Edge: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["EpisodeEdge"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("node", type: .object(Node.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(node: Node? = nil) {
              self.init(unsafeResultMap: ["__typename": "EpisodeEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The item at the end of the edge.
            public var node: Node? {
              get {
                return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "node")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Episode"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                  GraphQLField("title", type: .scalar(String.self)),
                  GraphQLField("numberText", type: .scalar(String.self)),
                  GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, viewerRecordsCount: Int) {
                self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "viewerRecordsCount": viewerRecordsCount])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: GraphQLID {
                get {
                  return resultMap["id"]! as! GraphQLID
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              public var annictId: Int {
                get {
                  return resultMap["annictId"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "annictId")
                }
              }

              public var title: String? {
                get {
                  return resultMap["title"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "title")
                }
              }

              public var numberText: String? {
                get {
                  return resultMap["numberText"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "numberText")
                }
              }

              public var viewerRecordsCount: Int {
                get {
                  return resultMap["viewerRecordsCount"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "viewerRecordsCount")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var episodeFragment: EpisodeFragment {
                  get {
                    return EpisodeFragment(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }
            }
          }

          public struct PageInfo: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["PageInfo"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("endCursor", type: .scalar(String.self)),
                GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(endCursor: String? = nil, hasNextPage: Bool) {
              self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// When paginating forwards, the cursor to continue.
            public var endCursor: String? {
              get {
                return resultMap["endCursor"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "endCursor")
              }
            }

            /// When paginating forwards, are there more items?
            public var hasNextPage: Bool {
              get {
                return resultMap["hasNextPage"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "hasNextPage")
              }
            }
          }
        }
      }
    }
  }
}

public final class SearchWorkReviewsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchWorkReviews($workAnnictId: Int!, $first: Int, $after: String) {
      searchWorks(annictIds: [$workAnnictId]) {
        __typename
        nodes {
          __typename
          ...WorkFragment
          reviews(first: $first, after: $after, orderBy: {direction: DESC, field: CREATED_AT}, hasBody: true) {
            __typename
            edges {
              __typename
              node {
                __typename
                ...ReviewFragment
              }
            }
            pageInfo {
              __typename
              ...PageInfoFragment
            }
          }
        }
      }
    }
    """

  public let operationName: String = "SearchWorkReviews"

  public let operationIdentifier: String? = "e67b4908d042fb41b1fdc01d085ca5651cb89d9187b3dcd1483ad1ad1dd953b2"

  public var queryDocument: String { return operationDefinition.appending(WorkFragment.fragmentDefinition).appending(ReviewFragment.fragmentDefinition).appending(UserFragment.fragmentDefinition).appending(PageInfoFragment.fragmentDefinition) }

  public var workAnnictId: Int
  public var first: Int?
  public var after: String?

  public init(workAnnictId: Int, first: Int? = nil, after: String? = nil) {
    self.workAnnictId = workAnnictId
    self.first = first
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["workAnnictId": workAnnictId, "first": first, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("searchWorks", arguments: ["annictIds": [GraphQLVariable("workAnnictId")]], type: .object(SearchWork.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchWorks: SearchWork? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "searchWorks": searchWorks.flatMap { (value: SearchWork) -> ResultMap in value.resultMap }])
    }

    public var searchWorks: SearchWork? {
      get {
        return (resultMap["searchWorks"] as? ResultMap).flatMap { SearchWork(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "searchWorks")
      }
    }

    public struct SearchWork: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["WorkConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nodes: [Node?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "WorkConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Work"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("seasonName", type: .scalar(SeasonName.self)),
            GraphQLField("seasonYear", type: .scalar(Int.self)),
            GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
            GraphQLField("media", type: .nonNull(.scalar(Media.self))),
            GraphQLField("reviews", arguments: ["first": GraphQLVariable("first"), "after": GraphQLVariable("after"), "orderBy": ["direction": "DESC", "field": "CREATED_AT"], "hasBody": true], type: .object(Review.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media, reviews: Review? = nil) {
          self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media, "reviews": reviews.flatMap { (value: Review) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var annictId: Int {
          get {
            return resultMap["annictId"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "annictId")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var episodesCount: Int {
          get {
            return resultMap["episodesCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "episodesCount")
          }
        }

        public var watchersCount: Int {
          get {
            return resultMap["watchersCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "watchersCount")
          }
        }

        public var reviewsCount: Int {
          get {
            return resultMap["reviewsCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var seasonName: SeasonName? {
          get {
            return resultMap["seasonName"] as? SeasonName
          }
          set {
            resultMap.updateValue(newValue, forKey: "seasonName")
          }
        }

        public var seasonYear: Int? {
          get {
            return resultMap["seasonYear"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "seasonYear")
          }
        }

        public var viewerStatusState: StatusState? {
          get {
            return resultMap["viewerStatusState"] as? StatusState
          }
          set {
            resultMap.updateValue(newValue, forKey: "viewerStatusState")
          }
        }

        public var media: Media {
          get {
            return resultMap["media"]! as! Media
          }
          set {
            resultMap.updateValue(newValue, forKey: "media")
          }
        }

        public var reviews: Review? {
          get {
            return (resultMap["reviews"] as? ResultMap).flatMap { Review(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "reviews")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var workFragment: WorkFragment {
            get {
              return WorkFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Review: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ReviewConnection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("edges", type: .list(.object(Edge.selections))),
              GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
            self.init(unsafeResultMap: ["__typename": "ReviewConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of edges.
          public var edges: [Edge?]? {
            get {
              return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
            }
          }

          /// Information to aid in pagination.
          public var pageInfo: PageInfo {
            get {
              return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
            }
          }

          public struct Edge: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ReviewEdge"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("node", type: .object(Node.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(node: Node? = nil) {
              self.init(unsafeResultMap: ["__typename": "ReviewEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The item at the end of the edge.
            public var node: Node? {
              get {
                return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "node")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Review"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                  GraphQLField("title", type: .scalar(String.self)),
                  GraphQLField("body", type: .nonNull(.scalar(String.self))),
                  GraphQLField("ratingAnimationState", type: .scalar(RatingState.self)),
                  GraphQLField("ratingOverallState", type: .scalar(RatingState.self)),
                  GraphQLField("ratingMusicState", type: .scalar(RatingState.self)),
                  GraphQLField("ratingStoryState", type: .scalar(RatingState.self)),
                  GraphQLField("ratingCharacterState", type: .scalar(RatingState.self)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("user", type: .nonNull(.object(User.selections))),
                  GraphQLField("work", type: .nonNull(.object(Work.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID, annictId: Int, title: String? = nil, body: String, ratingAnimationState: RatingState? = nil, ratingOverallState: RatingState? = nil, ratingMusicState: RatingState? = nil, ratingStoryState: RatingState? = nil, ratingCharacterState: RatingState? = nil, createdAt: String, user: User, work: Work) {
                self.init(unsafeResultMap: ["__typename": "Review", "id": id, "annictId": annictId, "title": title, "body": body, "ratingAnimationState": ratingAnimationState, "ratingOverallState": ratingOverallState, "ratingMusicState": ratingMusicState, "ratingStoryState": ratingStoryState, "ratingCharacterState": ratingCharacterState, "createdAt": createdAt, "user": user.resultMap, "work": work.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: GraphQLID {
                get {
                  return resultMap["id"]! as! GraphQLID
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              public var annictId: Int {
                get {
                  return resultMap["annictId"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "annictId")
                }
              }

              public var title: String? {
                get {
                  return resultMap["title"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "title")
                }
              }

              public var body: String {
                get {
                  return resultMap["body"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "body")
                }
              }

              public var ratingAnimationState: RatingState? {
                get {
                  return resultMap["ratingAnimationState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingAnimationState")
                }
              }

              public var ratingOverallState: RatingState? {
                get {
                  return resultMap["ratingOverallState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingOverallState")
                }
              }

              public var ratingMusicState: RatingState? {
                get {
                  return resultMap["ratingMusicState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingMusicState")
                }
              }

              public var ratingStoryState: RatingState? {
                get {
                  return resultMap["ratingStoryState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingStoryState")
                }
              }

              public var ratingCharacterState: RatingState? {
                get {
                  return resultMap["ratingCharacterState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingCharacterState")
                }
              }

              public var createdAt: String {
                get {
                  return resultMap["createdAt"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "createdAt")
                }
              }

              public var user: User {
                get {
                  return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "user")
                }
              }

              public var work: Work {
                get {
                  return Work(unsafeResultMap: resultMap["work"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "work")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var reviewFragment: ReviewFragment {
                  get {
                    return ReviewFragment(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }

              public struct User: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["User"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    GraphQLField("username", type: .nonNull(.scalar(String.self))),
                    GraphQLField("avatarUrl", type: .scalar(String.self)),
                    GraphQLField("description", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
                  self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return resultMap["id"]! as! GraphQLID
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var name: String {
                  get {
                    return resultMap["name"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "name")
                  }
                }

                public var username: String {
                  get {
                    return resultMap["username"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "username")
                  }
                }

                public var avatarUrl: String? {
                  get {
                    return resultMap["avatarUrl"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "avatarUrl")
                  }
                }

                public var description: String {
                  get {
                    return resultMap["description"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "description")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var userFragment: UserFragment {
                    get {
                      return UserFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public struct Work: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Work"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("title", type: .nonNull(.scalar(String.self))),
                    GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("seasonName", type: .scalar(SeasonName.self)),
                    GraphQLField("seasonYear", type: .scalar(Int.self)),
                    GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
                    GraphQLField("media", type: .nonNull(.scalar(Media.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
                  self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return resultMap["id"]! as! GraphQLID
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var annictId: Int {
                  get {
                    return resultMap["annictId"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "annictId")
                  }
                }

                public var title: String {
                  get {
                    return resultMap["title"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "title")
                  }
                }

                public var episodesCount: Int {
                  get {
                    return resultMap["episodesCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "episodesCount")
                  }
                }

                public var watchersCount: Int {
                  get {
                    return resultMap["watchersCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "watchersCount")
                  }
                }

                public var reviewsCount: Int {
                  get {
                    return resultMap["reviewsCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "reviewsCount")
                  }
                }

                public var seasonName: SeasonName? {
                  get {
                    return resultMap["seasonName"] as? SeasonName
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "seasonName")
                  }
                }

                public var seasonYear: Int? {
                  get {
                    return resultMap["seasonYear"] as? Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "seasonYear")
                  }
                }

                public var viewerStatusState: StatusState? {
                  get {
                    return resultMap["viewerStatusState"] as? StatusState
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "viewerStatusState")
                  }
                }

                public var media: Media {
                  get {
                    return resultMap["media"]! as! Media
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "media")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var workFragment: WorkFragment {
                    get {
                      return WorkFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }
            }
          }

          public struct PageInfo: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["PageInfo"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("hasPreviousPage", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("endCursor", type: .scalar(String.self)),
                GraphQLField("startCursor", type: .scalar(String.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(hasNextPage: Bool, hasPreviousPage: Bool, endCursor: String? = nil, startCursor: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "PageInfo", "hasNextPage": hasNextPage, "hasPreviousPage": hasPreviousPage, "endCursor": endCursor, "startCursor": startCursor])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// When paginating forwards, are there more items?
            public var hasNextPage: Bool {
              get {
                return resultMap["hasNextPage"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "hasNextPage")
              }
            }

            /// When paginating backwards, are there more items?
            public var hasPreviousPage: Bool {
              get {
                return resultMap["hasPreviousPage"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "hasPreviousPage")
              }
            }

            /// When paginating forwards, the cursor to continue.
            public var endCursor: String? {
              get {
                return resultMap["endCursor"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "endCursor")
              }
            }

            /// When paginating backwards, the cursor to continue.
            public var startCursor: String? {
              get {
                return resultMap["startCursor"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "startCursor")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var pageInfoFragment: PageInfoFragment {
                get {
                  return PageInfoFragment(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class SearchWorksByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchWorksByID($annictId: Int!, $after: String) {
      searchWorks(annictIds: [$annictId], after: $after) {
        __typename
        nodes {
          __typename
          ...WorkFragment
          episodes(first: 5, orderBy: {direction: ASC, field: SORT_NUMBER}) {
            __typename
            nodes {
              __typename
              id
              annictId
              title
              numberText
              viewerRecordsCount
            }
          }
        }
      }
    }
    """

  public let operationName: String = "SearchWorksByID"

  public let operationIdentifier: String? = "5e9902975ee56d522b235f58534e946edcdcda99e767b6c9a23b7edbe894263e"

  public var queryDocument: String { return operationDefinition.appending(WorkFragment.fragmentDefinition) }

  public var annictId: Int
  public var after: String?

  public init(annictId: Int, after: String? = nil) {
    self.annictId = annictId
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["annictId": annictId, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("searchWorks", arguments: ["annictIds": [GraphQLVariable("annictId")], "after": GraphQLVariable("after")], type: .object(SearchWork.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchWorks: SearchWork? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "searchWorks": searchWorks.flatMap { (value: SearchWork) -> ResultMap in value.resultMap }])
    }

    public var searchWorks: SearchWork? {
      get {
        return (resultMap["searchWorks"] as? ResultMap).flatMap { SearchWork(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "searchWorks")
      }
    }

    public struct SearchWork: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["WorkConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nodes: [Node?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "WorkConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Work"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("seasonName", type: .scalar(SeasonName.self)),
            GraphQLField("seasonYear", type: .scalar(Int.self)),
            GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
            GraphQLField("media", type: .nonNull(.scalar(Media.self))),
            GraphQLField("episodes", arguments: ["first": 5, "orderBy": ["direction": "ASC", "field": "SORT_NUMBER"]], type: .object(Episode.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media, episodes: Episode? = nil) {
          self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media, "episodes": episodes.flatMap { (value: Episode) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var annictId: Int {
          get {
            return resultMap["annictId"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "annictId")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var episodesCount: Int {
          get {
            return resultMap["episodesCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "episodesCount")
          }
        }

        public var watchersCount: Int {
          get {
            return resultMap["watchersCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "watchersCount")
          }
        }

        public var reviewsCount: Int {
          get {
            return resultMap["reviewsCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var seasonName: SeasonName? {
          get {
            return resultMap["seasonName"] as? SeasonName
          }
          set {
            resultMap.updateValue(newValue, forKey: "seasonName")
          }
        }

        public var seasonYear: Int? {
          get {
            return resultMap["seasonYear"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "seasonYear")
          }
        }

        public var viewerStatusState: StatusState? {
          get {
            return resultMap["viewerStatusState"] as? StatusState
          }
          set {
            resultMap.updateValue(newValue, forKey: "viewerStatusState")
          }
        }

        public var media: Media {
          get {
            return resultMap["media"]! as! Media
          }
          set {
            resultMap.updateValue(newValue, forKey: "media")
          }
        }

        public var episodes: Episode? {
          get {
            return (resultMap["episodes"] as? ResultMap).flatMap { Episode(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "episodes")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var workFragment: WorkFragment {
            get {
              return WorkFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Episode: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["EpisodeConnection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(nodes: [Node?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "EpisodeConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of nodes.
          public var nodes: [Node?]? {
            get {
              return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Episode"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                GraphQLField("title", type: .scalar(String.self)),
                GraphQLField("numberText", type: .scalar(String.self)),
                GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, viewerRecordsCount: Int) {
              self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "viewerRecordsCount": viewerRecordsCount])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var annictId: Int {
              get {
                return resultMap["annictId"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "annictId")
              }
            }

            public var title: String? {
              get {
                return resultMap["title"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "title")
              }
            }

            public var numberText: String? {
              get {
                return resultMap["numberText"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "numberText")
              }
            }

            public var viewerRecordsCount: Int {
              get {
                return resultMap["viewerRecordsCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "viewerRecordsCount")
              }
            }
          }
        }
      }
    }
  }
}

public final class SearchWorksBySeasonQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchWorksBySeason($first: Int, $after: String, $seasons: [String!]) {
      searchWorks(first: $first, after: $after, seasons: $seasons, orderBy: {direction: DESC, field: WATCHERS_COUNT}) {
        __typename
        edges {
          __typename
          node {
            __typename
            ...WorkFragment
          }
        }
      }
    }
    """

  public let operationName: String = "SearchWorksBySeason"

  public let operationIdentifier: String? = "fff6f2046042c3480b6ca07916908d909201b786fa6455087e14763668c215e5"

  public var queryDocument: String { return operationDefinition.appending(WorkFragment.fragmentDefinition) }

  public var first: Int?
  public var after: String?
  public var seasons: [String]?

  public init(first: Int? = nil, after: String? = nil, seasons: [String]?) {
    self.first = first
    self.after = after
    self.seasons = seasons
  }

  public var variables: GraphQLMap? {
    return ["first": first, "after": after, "seasons": seasons]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("searchWorks", arguments: ["first": GraphQLVariable("first"), "after": GraphQLVariable("after"), "seasons": GraphQLVariable("seasons"), "orderBy": ["direction": "DESC", "field": "WATCHERS_COUNT"]], type: .object(SearchWork.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchWorks: SearchWork? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "searchWorks": searchWorks.flatMap { (value: SearchWork) -> ResultMap in value.resultMap }])
    }

    public var searchWorks: SearchWork? {
      get {
        return (resultMap["searchWorks"] as? ResultMap).flatMap { SearchWork(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "searchWorks")
      }
    }

    public struct SearchWork: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["WorkConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(edges: [Edge?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "WorkConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of edges.
      public var edges: [Edge?]? {
        get {
          return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
        }
      }

      public struct Edge: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["WorkEdge"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(node: Node? = nil) {
          self.init(unsafeResultMap: ["__typename": "WorkEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The item at the end of the edge.
        public var node: Node? {
          get {
            return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Work"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
              GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
              GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
              GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
              GraphQLField("seasonName", type: .scalar(SeasonName.self)),
              GraphQLField("seasonYear", type: .scalar(Int.self)),
              GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
              GraphQLField("media", type: .nonNull(.scalar(Media.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
            self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var annictId: Int {
            get {
              return resultMap["annictId"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "annictId")
            }
          }

          public var title: String {
            get {
              return resultMap["title"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          public var episodesCount: Int {
            get {
              return resultMap["episodesCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "episodesCount")
            }
          }

          public var watchersCount: Int {
            get {
              return resultMap["watchersCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "watchersCount")
            }
          }

          public var reviewsCount: Int {
            get {
              return resultMap["reviewsCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reviewsCount")
            }
          }

          public var seasonName: SeasonName? {
            get {
              return resultMap["seasonName"] as? SeasonName
            }
            set {
              resultMap.updateValue(newValue, forKey: "seasonName")
            }
          }

          public var seasonYear: Int? {
            get {
              return resultMap["seasonYear"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "seasonYear")
            }
          }

          public var viewerStatusState: StatusState? {
            get {
              return resultMap["viewerStatusState"] as? StatusState
            }
            set {
              resultMap.updateValue(newValue, forKey: "viewerStatusState")
            }
          }

          public var media: Media {
            get {
              return resultMap["media"]! as! Media
            }
            set {
              resultMap.updateValue(newValue, forKey: "media")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var workFragment: WorkFragment {
              get {
                return WorkFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class SearchWorksByTitlesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchWorksByTitles($first: Int, $after: String, $titles: [String!]) {
      searchWorks(first: $first, after: $after, titles: $titles, orderBy: {direction: DESC, field: WATCHERS_COUNT}) {
        __typename
        edges {
          __typename
          node {
            __typename
            ...WorkFragment
          }
        }
      }
    }
    """

  public let operationName: String = "SearchWorksByTitles"

  public let operationIdentifier: String? = "9b9adbe8fd1d8928932d3a15ad2c0b84532046c617d12a05ac13ca68d6f9fe6f"

  public var queryDocument: String { return operationDefinition.appending(WorkFragment.fragmentDefinition) }

  public var first: Int?
  public var after: String?
  public var titles: [String]?

  public init(first: Int? = nil, after: String? = nil, titles: [String]?) {
    self.first = first
    self.after = after
    self.titles = titles
  }

  public var variables: GraphQLMap? {
    return ["first": first, "after": after, "titles": titles]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("searchWorks", arguments: ["first": GraphQLVariable("first"), "after": GraphQLVariable("after"), "titles": GraphQLVariable("titles"), "orderBy": ["direction": "DESC", "field": "WATCHERS_COUNT"]], type: .object(SearchWork.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchWorks: SearchWork? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "searchWorks": searchWorks.flatMap { (value: SearchWork) -> ResultMap in value.resultMap }])
    }

    public var searchWorks: SearchWork? {
      get {
        return (resultMap["searchWorks"] as? ResultMap).flatMap { SearchWork(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "searchWorks")
      }
    }

    public struct SearchWork: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["WorkConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(edges: [Edge?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "WorkConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of edges.
      public var edges: [Edge?]? {
        get {
          return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
        }
      }

      public struct Edge: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["WorkEdge"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(node: Node? = nil) {
          self.init(unsafeResultMap: ["__typename": "WorkEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The item at the end of the edge.
        public var node: Node? {
          get {
            return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Work"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
              GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
              GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
              GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
              GraphQLField("seasonName", type: .scalar(SeasonName.self)),
              GraphQLField("seasonYear", type: .scalar(Int.self)),
              GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
              GraphQLField("media", type: .nonNull(.scalar(Media.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
            self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var annictId: Int {
            get {
              return resultMap["annictId"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "annictId")
            }
          }

          public var title: String {
            get {
              return resultMap["title"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          public var episodesCount: Int {
            get {
              return resultMap["episodesCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "episodesCount")
            }
          }

          public var watchersCount: Int {
            get {
              return resultMap["watchersCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "watchersCount")
            }
          }

          public var reviewsCount: Int {
            get {
              return resultMap["reviewsCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reviewsCount")
            }
          }

          public var seasonName: SeasonName? {
            get {
              return resultMap["seasonName"] as? SeasonName
            }
            set {
              resultMap.updateValue(newValue, forKey: "seasonName")
            }
          }

          public var seasonYear: Int? {
            get {
              return resultMap["seasonYear"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "seasonYear")
            }
          }

          public var viewerStatusState: StatusState? {
            get {
              return resultMap["viewerStatusState"] as? StatusState
            }
            set {
              resultMap.updateValue(newValue, forKey: "viewerStatusState")
            }
          }

          public var media: Media {
            get {
              return resultMap["media"]! as! Media
            }
            set {
              resultMap.updateValue(newValue, forKey: "media")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var workFragment: WorkFragment {
              get {
                return WorkFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class UpdateStatusMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation updateStatus($workId: ID!, $state: StatusState!) {
      updateStatus(input: {workId: $workId, state: $state}) {
        __typename
        work {
          __typename
          ...WorkFragment
        }
      }
    }
    """

  public let operationName: String = "updateStatus"

  public let operationIdentifier: String? = "5c9ffdf0f3800cd1291a6377b7e44f9b166390ba9b3912a596692cc79aecddd7"

  public var queryDocument: String { return operationDefinition.appending(WorkFragment.fragmentDefinition) }

  public var workId: GraphQLID
  public var state: StatusState

  public init(workId: GraphQLID, state: StatusState) {
    self.workId = workId
    self.state = state
  }

  public var variables: GraphQLMap? {
    return ["workId": workId, "state": state]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("updateStatus", arguments: ["input": ["workId": GraphQLVariable("workId"), "state": GraphQLVariable("state")]], type: .object(UpdateStatus.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateStatus: UpdateStatus? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateStatus": updateStatus.flatMap { (value: UpdateStatus) -> ResultMap in value.resultMap }])
    }

    public var updateStatus: UpdateStatus? {
      get {
        return (resultMap["updateStatus"] as? ResultMap).flatMap { UpdateStatus(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateStatus")
      }
    }

    public struct UpdateStatus: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UpdateStatusPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("work", type: .object(Work.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(work: Work? = nil) {
        self.init(unsafeResultMap: ["__typename": "UpdateStatusPayload", "work": work.flatMap { (value: Work) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var work: Work? {
        get {
          return (resultMap["work"] as? ResultMap).flatMap { Work(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "work")
        }
      }

      public struct Work: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Work"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("seasonName", type: .scalar(SeasonName.self)),
            GraphQLField("seasonYear", type: .scalar(Int.self)),
            GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
            GraphQLField("media", type: .nonNull(.scalar(Media.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
          self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var annictId: Int {
          get {
            return resultMap["annictId"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "annictId")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var episodesCount: Int {
          get {
            return resultMap["episodesCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "episodesCount")
          }
        }

        public var watchersCount: Int {
          get {
            return resultMap["watchersCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "watchersCount")
          }
        }

        public var reviewsCount: Int {
          get {
            return resultMap["reviewsCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var seasonName: SeasonName? {
          get {
            return resultMap["seasonName"] as? SeasonName
          }
          set {
            resultMap.updateValue(newValue, forKey: "seasonName")
          }
        }

        public var seasonYear: Int? {
          get {
            return resultMap["seasonYear"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "seasonYear")
          }
        }

        public var viewerStatusState: StatusState? {
          get {
            return resultMap["viewerStatusState"] as? StatusState
          }
          set {
            resultMap.updateValue(newValue, forKey: "viewerStatusState")
          }
        }

        public var media: Media {
          get {
            return resultMap["media"]! as! Media
          }
          set {
            resultMap.updateValue(newValue, forKey: "media")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var workFragment: WorkFragment {
            get {
              return WorkFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public struct WorkFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment WorkFragment on Work {
      __typename
      id
      annictId
      title
      episodesCount
      watchersCount
      reviewsCount
      seasonName
      seasonYear
      viewerStatusState
      media
    }
    """

  public static let possibleTypes: [String] = ["Work"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
      GraphQLField("title", type: .nonNull(.scalar(String.self))),
      GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
      GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
      GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
      GraphQLField("seasonName", type: .scalar(SeasonName.self)),
      GraphQLField("seasonYear", type: .scalar(Int.self)),
      GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
      GraphQLField("media", type: .nonNull(.scalar(Media.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
    self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var annictId: Int {
    get {
      return resultMap["annictId"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "annictId")
    }
  }

  public var title: String {
    get {
      return resultMap["title"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var episodesCount: Int {
    get {
      return resultMap["episodesCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "episodesCount")
    }
  }

  public var watchersCount: Int {
    get {
      return resultMap["watchersCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "watchersCount")
    }
  }

  public var reviewsCount: Int {
    get {
      return resultMap["reviewsCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "reviewsCount")
    }
  }

  public var seasonName: SeasonName? {
    get {
      return resultMap["seasonName"] as? SeasonName
    }
    set {
      resultMap.updateValue(newValue, forKey: "seasonName")
    }
  }

  public var seasonYear: Int? {
    get {
      return resultMap["seasonYear"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "seasonYear")
    }
  }

  public var viewerStatusState: StatusState? {
    get {
      return resultMap["viewerStatusState"] as? StatusState
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerStatusState")
    }
  }

  public var media: Media {
    get {
      return resultMap["media"]! as! Media
    }
    set {
      resultMap.updateValue(newValue, forKey: "media")
    }
  }
}

public struct EpisodeFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment EpisodeFragment on Episode {
      __typename
      id
      annictId
      title
      numberText
      viewerRecordsCount
    }
    """

  public static let possibleTypes: [String] = ["Episode"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
      GraphQLField("title", type: .scalar(String.self)),
      GraphQLField("numberText", type: .scalar(String.self)),
      GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, viewerRecordsCount: Int) {
    self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "viewerRecordsCount": viewerRecordsCount])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var annictId: Int {
    get {
      return resultMap["annictId"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "annictId")
    }
  }

  public var title: String? {
    get {
      return resultMap["title"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var numberText: String? {
    get {
      return resultMap["numberText"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "numberText")
    }
  }

  public var viewerRecordsCount: Int {
    get {
      return resultMap["viewerRecordsCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerRecordsCount")
    }
  }
}

public struct RecordFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RecordFragment on Record {
      __typename
      id
      annictId
      comment
      ratingState
      createdAt
      user {
        __typename
        ...UserFragment
      }
      work {
        __typename
        ...WorkFragment
      }
      episode {
        __typename
        ...EpisodeFragment
      }
    }
    """

  public static let possibleTypes: [String] = ["Record"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
      GraphQLField("comment", type: .scalar(String.self)),
      GraphQLField("ratingState", type: .scalar(RatingState.self)),
      GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
      GraphQLField("user", type: .nonNull(.object(User.selections))),
      GraphQLField("work", type: .nonNull(.object(Work.selections))),
      GraphQLField("episode", type: .nonNull(.object(Episode.selections))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, comment: String? = nil, ratingState: RatingState? = nil, createdAt: String, user: User, work: Work, episode: Episode) {
    self.init(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "comment": comment, "ratingState": ratingState, "createdAt": createdAt, "user": user.resultMap, "work": work.resultMap, "episode": episode.resultMap])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var annictId: Int {
    get {
      return resultMap["annictId"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "annictId")
    }
  }

  public var comment: String? {
    get {
      return resultMap["comment"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "comment")
    }
  }

  public var ratingState: RatingState? {
    get {
      return resultMap["ratingState"] as? RatingState
    }
    set {
      resultMap.updateValue(newValue, forKey: "ratingState")
    }
  }

  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  public var user: User {
    get {
      return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "user")
    }
  }

  public var work: Work {
    get {
      return Work(unsafeResultMap: resultMap["work"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "work")
    }
  }

  public var episode: Episode {
    get {
      return Episode(unsafeResultMap: resultMap["episode"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "episode")
    }
  }

  public struct User: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["User"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("username", type: .nonNull(.scalar(String.self))),
        GraphQLField("avatarUrl", type: .scalar(String.self)),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
      self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    public var username: String {
      get {
        return resultMap["username"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "username")
      }
    }

    public var avatarUrl: String? {
      get {
        return resultMap["avatarUrl"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "avatarUrl")
      }
    }

    public var description: String {
      get {
        return resultMap["description"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "description")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var userFragment: UserFragment {
        get {
          return UserFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }

  public struct Work: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Work"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("seasonName", type: .scalar(SeasonName.self)),
        GraphQLField("seasonYear", type: .scalar(Int.self)),
        GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
        GraphQLField("media", type: .nonNull(.scalar(Media.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
      self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var annictId: Int {
      get {
        return resultMap["annictId"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "annictId")
      }
    }

    public var title: String {
      get {
        return resultMap["title"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "title")
      }
    }

    public var episodesCount: Int {
      get {
        return resultMap["episodesCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "episodesCount")
      }
    }

    public var watchersCount: Int {
      get {
        return resultMap["watchersCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "watchersCount")
      }
    }

    public var reviewsCount: Int {
      get {
        return resultMap["reviewsCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "reviewsCount")
      }
    }

    public var seasonName: SeasonName? {
      get {
        return resultMap["seasonName"] as? SeasonName
      }
      set {
        resultMap.updateValue(newValue, forKey: "seasonName")
      }
    }

    public var seasonYear: Int? {
      get {
        return resultMap["seasonYear"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "seasonYear")
      }
    }

    public var viewerStatusState: StatusState? {
      get {
        return resultMap["viewerStatusState"] as? StatusState
      }
      set {
        resultMap.updateValue(newValue, forKey: "viewerStatusState")
      }
    }

    public var media: Media {
      get {
        return resultMap["media"]! as! Media
      }
      set {
        resultMap.updateValue(newValue, forKey: "media")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var workFragment: WorkFragment {
        get {
          return WorkFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }

  public struct Episode: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Episode"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("numberText", type: .scalar(String.self)),
        GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, viewerRecordsCount: Int) {
      self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "viewerRecordsCount": viewerRecordsCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var annictId: Int {
      get {
        return resultMap["annictId"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "annictId")
      }
    }

    public var title: String? {
      get {
        return resultMap["title"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "title")
      }
    }

    public var numberText: String? {
      get {
        return resultMap["numberText"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "numberText")
      }
    }

    public var viewerRecordsCount: Int {
      get {
        return resultMap["viewerRecordsCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "viewerRecordsCount")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var episodeFragment: EpisodeFragment {
        get {
          return EpisodeFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct StatusFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment StatusFragment on Status {
      __typename
      id
      annictId
      createdAt
      state
      user {
        __typename
        ...UserFragment
      }
      work {
        __typename
        ...WorkFragment
      }
    }
    """

  public static let possibleTypes: [String] = ["Status"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
      GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
      GraphQLField("state", type: .nonNull(.scalar(StatusState.self))),
      GraphQLField("user", type: .nonNull(.object(User.selections))),
      GraphQLField("work", type: .nonNull(.object(Work.selections))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, createdAt: String, state: StatusState, user: User, work: Work) {
    self.init(unsafeResultMap: ["__typename": "Status", "id": id, "annictId": annictId, "createdAt": createdAt, "state": state, "user": user.resultMap, "work": work.resultMap])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var annictId: Int {
    get {
      return resultMap["annictId"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "annictId")
    }
  }

  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  public var state: StatusState {
    get {
      return resultMap["state"]! as! StatusState
    }
    set {
      resultMap.updateValue(newValue, forKey: "state")
    }
  }

  public var user: User {
    get {
      return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "user")
    }
  }

  public var work: Work {
    get {
      return Work(unsafeResultMap: resultMap["work"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "work")
    }
  }

  public struct User: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["User"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("username", type: .nonNull(.scalar(String.self))),
        GraphQLField("avatarUrl", type: .scalar(String.self)),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
      self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    public var username: String {
      get {
        return resultMap["username"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "username")
      }
    }

    public var avatarUrl: String? {
      get {
        return resultMap["avatarUrl"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "avatarUrl")
      }
    }

    public var description: String {
      get {
        return resultMap["description"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "description")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var userFragment: UserFragment {
        get {
          return UserFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }

  public struct Work: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Work"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("seasonName", type: .scalar(SeasonName.self)),
        GraphQLField("seasonYear", type: .scalar(Int.self)),
        GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
        GraphQLField("media", type: .nonNull(.scalar(Media.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
      self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var annictId: Int {
      get {
        return resultMap["annictId"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "annictId")
      }
    }

    public var title: String {
      get {
        return resultMap["title"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "title")
      }
    }

    public var episodesCount: Int {
      get {
        return resultMap["episodesCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "episodesCount")
      }
    }

    public var watchersCount: Int {
      get {
        return resultMap["watchersCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "watchersCount")
      }
    }

    public var reviewsCount: Int {
      get {
        return resultMap["reviewsCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "reviewsCount")
      }
    }

    public var seasonName: SeasonName? {
      get {
        return resultMap["seasonName"] as? SeasonName
      }
      set {
        resultMap.updateValue(newValue, forKey: "seasonName")
      }
    }

    public var seasonYear: Int? {
      get {
        return resultMap["seasonYear"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "seasonYear")
      }
    }

    public var viewerStatusState: StatusState? {
      get {
        return resultMap["viewerStatusState"] as? StatusState
      }
      set {
        resultMap.updateValue(newValue, forKey: "viewerStatusState")
      }
    }

    public var media: Media {
      get {
        return resultMap["media"]! as! Media
      }
      set {
        resultMap.updateValue(newValue, forKey: "media")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var workFragment: WorkFragment {
        get {
          return WorkFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct UserFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment UserFragment on User {
      __typename
      id
      name
      username
      avatarUrl
      description
    }
    """

  public static let possibleTypes: [String] = ["User"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("username", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .scalar(String.self)),
      GraphQLField("description", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
    self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var username: String {
    get {
      return resultMap["username"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "username")
    }
  }

  public var avatarUrl: String? {
    get {
      return resultMap["avatarUrl"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "avatarUrl")
    }
  }

  public var description: String {
    get {
      return resultMap["description"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
    }
  }
}

public struct ReviewFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ReviewFragment on Review {
      __typename
      id
      annictId
      title
      body
      ratingAnimationState
      ratingOverallState
      ratingMusicState
      ratingStoryState
      ratingCharacterState
      createdAt
      user {
        __typename
        ...UserFragment
      }
      work {
        __typename
        ...WorkFragment
      }
    }
    """

  public static let possibleTypes: [String] = ["Review"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
      GraphQLField("title", type: .scalar(String.self)),
      GraphQLField("body", type: .nonNull(.scalar(String.self))),
      GraphQLField("ratingAnimationState", type: .scalar(RatingState.self)),
      GraphQLField("ratingOverallState", type: .scalar(RatingState.self)),
      GraphQLField("ratingMusicState", type: .scalar(RatingState.self)),
      GraphQLField("ratingStoryState", type: .scalar(RatingState.self)),
      GraphQLField("ratingCharacterState", type: .scalar(RatingState.self)),
      GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
      GraphQLField("user", type: .nonNull(.object(User.selections))),
      GraphQLField("work", type: .nonNull(.object(Work.selections))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, title: String? = nil, body: String, ratingAnimationState: RatingState? = nil, ratingOverallState: RatingState? = nil, ratingMusicState: RatingState? = nil, ratingStoryState: RatingState? = nil, ratingCharacterState: RatingState? = nil, createdAt: String, user: User, work: Work) {
    self.init(unsafeResultMap: ["__typename": "Review", "id": id, "annictId": annictId, "title": title, "body": body, "ratingAnimationState": ratingAnimationState, "ratingOverallState": ratingOverallState, "ratingMusicState": ratingMusicState, "ratingStoryState": ratingStoryState, "ratingCharacterState": ratingCharacterState, "createdAt": createdAt, "user": user.resultMap, "work": work.resultMap])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var annictId: Int {
    get {
      return resultMap["annictId"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "annictId")
    }
  }

  public var title: String? {
    get {
      return resultMap["title"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var body: String {
    get {
      return resultMap["body"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "body")
    }
  }

  public var ratingAnimationState: RatingState? {
    get {
      return resultMap["ratingAnimationState"] as? RatingState
    }
    set {
      resultMap.updateValue(newValue, forKey: "ratingAnimationState")
    }
  }

  public var ratingOverallState: RatingState? {
    get {
      return resultMap["ratingOverallState"] as? RatingState
    }
    set {
      resultMap.updateValue(newValue, forKey: "ratingOverallState")
    }
  }

  public var ratingMusicState: RatingState? {
    get {
      return resultMap["ratingMusicState"] as? RatingState
    }
    set {
      resultMap.updateValue(newValue, forKey: "ratingMusicState")
    }
  }

  public var ratingStoryState: RatingState? {
    get {
      return resultMap["ratingStoryState"] as? RatingState
    }
    set {
      resultMap.updateValue(newValue, forKey: "ratingStoryState")
    }
  }

  public var ratingCharacterState: RatingState? {
    get {
      return resultMap["ratingCharacterState"] as? RatingState
    }
    set {
      resultMap.updateValue(newValue, forKey: "ratingCharacterState")
    }
  }

  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  public var user: User {
    get {
      return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "user")
    }
  }

  public var work: Work {
    get {
      return Work(unsafeResultMap: resultMap["work"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "work")
    }
  }

  public struct User: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["User"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("username", type: .nonNull(.scalar(String.self))),
        GraphQLField("avatarUrl", type: .scalar(String.self)),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
      self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    public var username: String {
      get {
        return resultMap["username"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "username")
      }
    }

    public var avatarUrl: String? {
      get {
        return resultMap["avatarUrl"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "avatarUrl")
      }
    }

    public var description: String {
      get {
        return resultMap["description"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "description")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var userFragment: UserFragment {
        get {
          return UserFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }

  public struct Work: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Work"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("seasonName", type: .scalar(SeasonName.self)),
        GraphQLField("seasonYear", type: .scalar(Int.self)),
        GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
        GraphQLField("media", type: .nonNull(.scalar(Media.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, media: Media) {
      self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "media": media])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var annictId: Int {
      get {
        return resultMap["annictId"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "annictId")
      }
    }

    public var title: String {
      get {
        return resultMap["title"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "title")
      }
    }

    public var episodesCount: Int {
      get {
        return resultMap["episodesCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "episodesCount")
      }
    }

    public var watchersCount: Int {
      get {
        return resultMap["watchersCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "watchersCount")
      }
    }

    public var reviewsCount: Int {
      get {
        return resultMap["reviewsCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "reviewsCount")
      }
    }

    public var seasonName: SeasonName? {
      get {
        return resultMap["seasonName"] as? SeasonName
      }
      set {
        resultMap.updateValue(newValue, forKey: "seasonName")
      }
    }

    public var seasonYear: Int? {
      get {
        return resultMap["seasonYear"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "seasonYear")
      }
    }

    public var viewerStatusState: StatusState? {
      get {
        return resultMap["viewerStatusState"] as? StatusState
      }
      set {
        resultMap.updateValue(newValue, forKey: "viewerStatusState")
      }
    }

    public var media: Media {
      get {
        return resultMap["media"]! as! Media
      }
      set {
        resultMap.updateValue(newValue, forKey: "media")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var workFragment: WorkFragment {
        get {
          return WorkFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct PageInfoFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment PageInfoFragment on PageInfo {
      __typename
      hasNextPage
      hasPreviousPage
      endCursor
      startCursor
    }
    """

  public static let possibleTypes: [String] = ["PageInfo"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
      GraphQLField("hasPreviousPage", type: .nonNull(.scalar(Bool.self))),
      GraphQLField("endCursor", type: .scalar(String.self)),
      GraphQLField("startCursor", type: .scalar(String.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(hasNextPage: Bool, hasPreviousPage: Bool, endCursor: String? = nil, startCursor: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "PageInfo", "hasNextPage": hasNextPage, "hasPreviousPage": hasPreviousPage, "endCursor": endCursor, "startCursor": startCursor])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// When paginating forwards, are there more items?
  public var hasNextPage: Bool {
    get {
      return resultMap["hasNextPage"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "hasNextPage")
    }
  }

  /// When paginating backwards, are there more items?
  public var hasPreviousPage: Bool {
    get {
      return resultMap["hasPreviousPage"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "hasPreviousPage")
    }
  }

  /// When paginating forwards, the cursor to continue.
  public var endCursor: String? {
    get {
      return resultMap["endCursor"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "endCursor")
    }
  }

  /// When paginating backwards, the cursor to continue.
  public var startCursor: String? {
    get {
      return resultMap["startCursor"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "startCursor")
    }
  }
}
