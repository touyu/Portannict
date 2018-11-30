//  This file was automatically generated and should not be edited.

import Apollo

public enum StatusState: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
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
}

/// Media of anime
public enum Media: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
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
}

public final class GetViewerWorksQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetViewerWorks($state: StatusState) {\n  viewer {\n    __typename\n    works(state: $state, first: 10, orderBy: {field: WATCHERS_COUNT, direction: DESC}) {\n      __typename\n      edges {\n        __typename\n        node {\n          __typename\n          title\n          image {\n            __typename\n            recommendedImageUrl\n            twitterAvatarUrl\n          }\n        }\n      }\n    }\n  }\n}"

  public var state: StatusState?

  public init(state: StatusState? = nil) {
    self.state = state
  }

  public var variables: GraphQLMap? {
    return ["state": state]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("viewer", type: .object(Viewer.selections)),
    ]

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
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("works", arguments: ["state": GraphQLVariable("state"), "first": 10, "orderBy": ["field": "WATCHERS_COUNT", "direction": "DESC"]], type: .object(Work.selections)),
      ]

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
        public static let possibleTypes = ["WorkConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]

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
          public static let possibleTypes = ["WorkEdge"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]

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
            public static let possibleTypes = ["Work"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
              GraphQLField("image", type: .object(Image.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(title: String, image: Image? = nil) {
              self.init(unsafeResultMap: ["__typename": "Work", "title": title, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
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

            public var image: Image? {
              get {
                return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "image")
              }
            }

            public struct Image: GraphQLSelectionSet {
              public static let possibleTypes = ["WorkImage"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("recommendedImageUrl", type: .scalar(String.self)),
                GraphQLField("twitterAvatarUrl", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(recommendedImageUrl: String? = nil, twitterAvatarUrl: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "WorkImage", "recommendedImageUrl": recommendedImageUrl, "twitterAvatarUrl": twitterAvatarUrl])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var recommendedImageUrl: String? {
                get {
                  return resultMap["recommendedImageUrl"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "recommendedImageUrl")
                }
              }

              public var twitterAvatarUrl: String? {
                get {
                  return resultMap["twitterAvatarUrl"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "twitterAvatarUrl")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class GetViewerInfoQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetViewerInfo {\n  viewer {\n    __typename\n    watchingCount\n    recordsCount\n    followersCount\n    followingsCount\n    description\n    username\n    name\n    avatarUrl\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("viewer", type: .object(Viewer.selections)),
    ]

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
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("watchingCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("recordsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("followersCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("followingsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
        GraphQLField("username", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("avatarUrl", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(watchingCount: Int, recordsCount: Int, followersCount: Int, followingsCount: Int, description: String, username: String, name: String, avatarUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "watchingCount": watchingCount, "recordsCount": recordsCount, "followersCount": followersCount, "followingsCount": followingsCount, "description": description, "username": username, "name": name, "avatarUrl": avatarUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var recordsCount: Int {
        get {
          return resultMap["recordsCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "recordsCount")
        }
      }

      public var followersCount: Int {
        get {
          return resultMap["followersCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "followersCount")
        }
      }

      public var followingsCount: Int {
        get {
          return resultMap["followingsCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "followingsCount")
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

      public var username: String {
        get {
          return resultMap["username"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
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

      public var avatarUrl: String? {
        get {
          return resultMap["avatarUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
        }
      }
    }
  }
}

public final class GetViewerWatchingEpisodesQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetViewerWatchingEpisodes($after: String) {\n  viewer {\n    __typename\n    works(state: WATCHING, first: 10, after: $after) {\n      __typename\n      pageInfo {\n        __typename\n        endCursor\n        hasNextPage\n      }\n      edges {\n        __typename\n        node {\n          __typename\n          title\n          image {\n            __typename\n            twitterAvatarUrl\n          }\n          episodes(orderBy: {field: CREATED_AT, direction: DESC}) {\n            __typename\n            edges {\n              __typename\n              node {\n                __typename\n                ...EpisodeDetails\n              }\n            }\n          }\n        }\n      }\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(EpisodeDetails.fragmentDefinition) }

  public var after: String?

  public init(after: String? = nil) {
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("viewer", type: .object(Viewer.selections)),
    ]

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
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("works", arguments: ["state": "WATCHING", "first": 10, "after": GraphQLVariable("after")], type: .object(Work.selections)),
      ]

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
        public static let possibleTypes = ["WorkConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(pageInfo: PageInfo, edges: [Edge?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "WorkConnection", "pageInfo": pageInfo.resultMap, "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("endCursor", type: .scalar(String.self)),
            GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          ]

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

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["WorkEdge"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]

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
            public static let possibleTypes = ["Work"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
              GraphQLField("image", type: .object(Image.selections)),
              GraphQLField("episodes", arguments: ["orderBy": ["field": "CREATED_AT", "direction": "DESC"]], type: .object(Episode.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(title: String, image: Image? = nil, episodes: Episode? = nil) {
              self.init(unsafeResultMap: ["__typename": "Work", "title": title, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }, "episodes": episodes.flatMap { (value: Episode) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
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

            public var image: Image? {
              get {
                return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "image")
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

            public struct Image: GraphQLSelectionSet {
              public static let possibleTypes = ["WorkImage"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("twitterAvatarUrl", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(twitterAvatarUrl: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "WorkImage", "twitterAvatarUrl": twitterAvatarUrl])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var twitterAvatarUrl: String? {
                get {
                  return resultMap["twitterAvatarUrl"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "twitterAvatarUrl")
                }
              }
            }

            public struct Episode: GraphQLSelectionSet {
              public static let possibleTypes = ["EpisodeConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("edges", type: .list(.object(Edge.selections))),
              ]

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
                public static let possibleTypes = ["EpisodeEdge"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("node", type: .object(Node.selections)),
                ]

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
                  public static let possibleTypes = ["Episode"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLFragmentSpread(EpisodeDetails.self),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(id: GraphQLID, annictId: Int, title: String? = nil, viewerRecordsCount: Int, viewerDidTrack: Bool, numberText: String? = nil) {
                    self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "viewerRecordsCount": viewerRecordsCount, "viewerDidTrack": viewerDidTrack, "numberText": numberText])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
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

                    public var episodeDetails: EpisodeDetails {
                      get {
                        return EpisodeDetails(unsafeResultMap: resultMap)
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

public final class SearchWorksQuery: GraphQLQuery {
  public let operationDefinition =
    "query SearchWorks($season: String!) {\n  searchWorks(seasons: [$season], orderBy: {field: WATCHERS_COUNT, direction: DESC}, first: 30) {\n    __typename\n    edges {\n      __typename\n      node {\n        __typename\n        id\n        annictId\n        title\n        media\n        watchersCount\n        image {\n          __typename\n          twitterAvatarUrl\n        }\n      }\n    }\n  }\n}"

  public var season: String

  public init(season: String) {
    self.season = season
  }

  public var variables: GraphQLMap? {
    return ["season": season]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("searchWorks", arguments: ["seasons": [GraphQLVariable("season")], "orderBy": ["field": "WATCHERS_COUNT", "direction": "DESC"], "first": 30], type: .object(SearchWork.selections)),
    ]

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
      public static let possibleTypes = ["WorkConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("edges", type: .list(.object(Edge.selections))),
      ]

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
        public static let possibleTypes = ["WorkEdge"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("node", type: .object(Node.selections)),
        ]

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
          public static let possibleTypes = ["Work"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("media", type: .nonNull(.scalar(Media.self))),
            GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("image", type: .object(Image.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, annictId: Int, title: String, media: Media, watchersCount: Int, image: Image? = nil) {
            self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "media": media, "watchersCount": watchersCount, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
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

          public var media: Media {
            get {
              return resultMap["media"]! as! Media
            }
            set {
              resultMap.updateValue(newValue, forKey: "media")
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

          public var image: Image? {
            get {
              return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "image")
            }
          }

          public struct Image: GraphQLSelectionSet {
            public static let possibleTypes = ["WorkImage"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("twitterAvatarUrl", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(twitterAvatarUrl: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "WorkImage", "twitterAvatarUrl": twitterAvatarUrl])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var twitterAvatarUrl: String? {
              get {
                return resultMap["twitterAvatarUrl"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "twitterAvatarUrl")
              }
            }
          }
        }
      }
    }
  }
}

public final class CreateRecordMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation CreateRecord($episodeId: ID!, $comment: String) {\n  createRecord(input: {episodeId: $episodeId, comment: $comment}) {\n    __typename\n    record {\n      __typename\n      id\n      annictId\n      comment\n      createdAt\n    }\n  }\n}"

  public var episodeId: GraphQLID
  public var comment: String?

  public init(episodeId: GraphQLID, comment: String? = nil) {
    self.episodeId = episodeId
    self.comment = comment
  }

  public var variables: GraphQLMap? {
    return ["episodeId": episodeId, "comment": comment]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createRecord", arguments: ["input": ["episodeId": GraphQLVariable("episodeId"), "comment": GraphQLVariable("comment")]], type: .object(CreateRecord.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createRecord: CreateRecord? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createRecord": createRecord.flatMap { (value: CreateRecord) -> ResultMap in value.resultMap }])
    }

    public var createRecord: CreateRecord? {
      get {
        return (resultMap["createRecord"] as? ResultMap).flatMap { CreateRecord(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createRecord")
      }
    }

    public struct CreateRecord: GraphQLSelectionSet {
      public static let possibleTypes = ["CreateRecordPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("record", type: .object(Record.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(record: Record? = nil) {
        self.init(unsafeResultMap: ["__typename": "CreateRecordPayload", "record": record.flatMap { (value: Record) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var record: Record? {
        get {
          return (resultMap["record"] as? ResultMap).flatMap { Record(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "record")
        }
      }

      public struct Record: GraphQLSelectionSet {
        public static let possibleTypes = ["Record"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("comment", type: .scalar(String.self)),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, annictId: Int, comment: String? = nil, createdAt: String) {
          self.init(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "comment": comment, "createdAt": createdAt])
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

        public var createdAt: String {
          get {
            return resultMap["createdAt"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }
      }
    }
  }
}

public final class GetViewerQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetViewer {\n  viewer {\n    __typename\n    ...UserDetails\n    annictId\n    backgroundImageUrl\n    recordsCount\n    description\n    followingsCount\n    followersCount\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(UserDetails.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("viewer", type: .object(Viewer.selections)),
    ]

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
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(UserDetails.self),
        GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
        GraphQLField("backgroundImageUrl", type: .scalar(String.self)),
        GraphQLField("recordsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
        GraphQLField("followingsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("followersCount", type: .nonNull(.scalar(Int.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(avatarUrl: String? = nil, name: String, username: String, annictId: Int, backgroundImageUrl: String? = nil, recordsCount: Int, description: String, followingsCount: Int, followersCount: Int) {
        self.init(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "annictId": annictId, "backgroundImageUrl": backgroundImageUrl, "recordsCount": recordsCount, "description": description, "followingsCount": followingsCount, "followersCount": followersCount])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var backgroundImageUrl: String? {
        get {
          return resultMap["backgroundImageUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "backgroundImageUrl")
        }
      }

      public var recordsCount: Int {
        get {
          return resultMap["recordsCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "recordsCount")
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

      public var followingsCount: Int {
        get {
          return resultMap["followingsCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "followingsCount")
        }
      }

      public var followersCount: Int {
        get {
          return resultMap["followersCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "followersCount")
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

        public var userDetails: UserDetails {
          get {
            return UserDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct EpisodeDetails: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment EpisodeDetails on Episode {\n  __typename\n  id\n  annictId\n  title\n  viewerRecordsCount\n  viewerDidTrack\n  numberText\n}"

  public static let possibleTypes = ["Episode"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
    GraphQLField("viewerDidTrack", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("numberText", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, title: String? = nil, viewerRecordsCount: Int, viewerDidTrack: Bool, numberText: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "viewerRecordsCount": viewerRecordsCount, "viewerDidTrack": viewerDidTrack, "numberText": numberText])
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

  public var viewerRecordsCount: Int {
    get {
      return resultMap["viewerRecordsCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerRecordsCount")
    }
  }

  public var viewerDidTrack: Bool {
    get {
      return resultMap["viewerDidTrack"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerDidTrack")
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
}

public struct UserDetails: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment UserDetails on User {\n  __typename\n  avatarUrl\n  name\n  username\n}"

  public static let possibleTypes = ["User"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("avatarUrl", type: .scalar(String.self)),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("username", type: .nonNull(.scalar(String.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(avatarUrl: String? = nil, name: String, username: String) {
    self.init(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
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
}