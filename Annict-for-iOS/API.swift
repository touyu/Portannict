//  This file was automatically generated and should not be edited.

import Apollo

public enum StatusState: String {
  case wannaWatch = "WANNA_WATCH"
  case watching = "WATCHING"
  case watched = "WATCHED"
  case onHold = "ON_HOLD"
  case stopWatching = "STOP_WATCHING"
  case noState = "NO_STATE"
}

extension StatusState: Apollo.JSONDecodable, Apollo.JSONEncodable {}

public final class GetViewerQuery: GraphQLQuery {
  public static let operationString =
    "query GetViewer {" +
    "  viewer {" +
    "    __typename" +
    "    ...UserDetails" +
    "    backgroundImageUrl" +
    "    recordsCount" +
    "    description" +
    "    followingsCount" +
    "    followersCount" +
    "  }" +
    "}"
  public static var requestString: String { return operationString.appending(UserDetails.fragmentString) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [Selection] = [
      Field("viewer", type: .object(Data.Viewer.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewer: Viewer? = nil) {
      self.init(snapshot: ["__typename": "Query", "viewer": viewer])
    }

    public var viewer: Viewer? {
      get {
        return (snapshot["viewer"]! as! Snapshot?).flatMap { Viewer(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [Selection] = [
        Field("__typename", type: .nonNull(.scalar(String.self))),
        Field("avatarUrl", type: .scalar(String.self)),
        Field("name", type: .nonNull(.scalar(String.self))),
        Field("username", type: .nonNull(.scalar(String.self))),
        Field("description", type: .nonNull(.scalar(String.self))),
        Field("backgroundImageUrl", type: .scalar(String.self)),
        Field("recordsCount", type: .nonNull(.scalar(Int.self))),
        Field("followingsCount", type: .nonNull(.scalar(Int.self))),
        Field("followersCount", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(avatarUrl: String? = nil, name: String, username: String, description: String, backgroundImageUrl: String? = nil, recordsCount: Int, followingsCount: Int, followersCount: Int) {
        self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "description": description, "backgroundImageUrl": backgroundImageUrl, "recordsCount": recordsCount, "followingsCount": followingsCount, "followersCount": followersCount])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var avatarUrl: String? {
        get {
          return snapshot["avatarUrl"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "avatarUrl")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var username: String {
        get {
          return snapshot["username"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "username")
        }
      }

      public var description: String {
        get {
          return snapshot["description"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      public var backgroundImageUrl: String? {
        get {
          return snapshot["backgroundImageUrl"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "backgroundImageUrl")
        }
      }

      public var recordsCount: Int {
        get {
          return snapshot["recordsCount"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "recordsCount")
        }
      }

      public var followingsCount: Int {
        get {
          return snapshot["followingsCount"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "followingsCount")
        }
      }

      public var followersCount: Int {
        get {
          return snapshot["followersCount"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "followersCount")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot = newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var userDetails: UserDetails {
          get {
            return UserDetails(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }
      }
    }
  }
}

public final class GetViewerFollowersQuery: GraphQLQuery {
  public static let operationString =
    "query GetViewerFollowers($after: String) {" +
    "  viewer {" +
    "    __typename" +
    "    followers(first: 30, after: $after) {" +
    "      __typename" +
    "      edges {" +
    "        __typename" +
    "        node {" +
    "          __typename" +
    "          ...UserDetails" +
    "          viewerCanFollow" +
    "          viewerIsFollowing" +
    "        }" +
    "      }" +
    "      pageInfo {" +
    "        __typename" +
    "        endCursor" +
    "        hasNextPage" +
    "      }" +
    "    }" +
    "  }" +
    "}"
  public static var requestString: String { return operationString.appending(UserDetails.fragmentString) }

  public var after: String?

  public init(after: String? = nil) {
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [Selection] = [
      Field("viewer", type: .object(Data.Viewer.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewer: Viewer? = nil) {
      self.init(snapshot: ["__typename": "Query", "viewer": viewer])
    }

    public var viewer: Viewer? {
      get {
        return (snapshot["viewer"]! as! Snapshot?).flatMap { Viewer(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [Selection] = [
        Field("__typename", type: .nonNull(.scalar(String.self))),
        Field("followers", arguments: ["first": 30, "after": Variable("after")], type: .object(Viewer.Follower.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(followers: Follower? = nil) {
        self.init(snapshot: ["__typename": "User", "followers": followers])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var followers: Follower? {
        get {
          return (snapshot["followers"]! as! Snapshot?).flatMap { Follower(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "followers")
        }
      }

      public struct Follower: GraphQLSelectionSet {
        public static let possibleTypes = ["UserConnection"]

        public static let selections: [Selection] = [
          Field("__typename", type: .nonNull(.scalar(String.self))),
          Field("edges", type: .list(.object(Follower.Edge.self))),
          Field("pageInfo", type: .nonNull(.object(Follower.PageInfo.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
          self.init(snapshot: ["__typename": "UserConnection", "edges": edges, "pageInfo": pageInfo])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (snapshot["edges"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["UserEdge"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("node", type: .object(Edge.Node.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(node: Node? = nil) {
            self.init(snapshot: ["__typename": "UserEdge", "node": node])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["User"]

            public static let selections: [Selection] = [
              Field("__typename", type: .nonNull(.scalar(String.self))),
              Field("avatarUrl", type: .scalar(String.self)),
              Field("name", type: .nonNull(.scalar(String.self))),
              Field("username", type: .nonNull(.scalar(String.self))),
              Field("description", type: .nonNull(.scalar(String.self))),
              Field("viewerCanFollow", type: .nonNull(.scalar(Bool.self))),
              Field("viewerIsFollowing", type: .nonNull(.scalar(Bool.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(avatarUrl: String? = nil, name: String, username: String, description: String, viewerCanFollow: Bool, viewerIsFollowing: Bool) {
              self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "description": description, "viewerCanFollow": viewerCanFollow, "viewerIsFollowing": viewerIsFollowing])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            public var avatarUrl: String? {
              get {
                return snapshot["avatarUrl"]! as! String?
              }
              set {
                snapshot.updateValue(newValue, forKey: "avatarUrl")
              }
            }

            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            public var username: String {
              get {
                return snapshot["username"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "username")
              }
            }

            public var description: String {
              get {
                return snapshot["description"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "description")
              }
            }

            public var viewerCanFollow: Bool {
              get {
                return snapshot["viewerCanFollow"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerCanFollow")
              }
            }

            public var viewerIsFollowing: Bool {
              get {
                return snapshot["viewerIsFollowing"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerIsFollowing")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var userDetails: UserDetails {
                get {
                  return UserDetails(snapshot: snapshot)
                }
                set {
                  snapshot = newValue.snapshot
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("endCursor", type: .scalar(String.self)),
            Field("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(snapshot: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return snapshot["endCursor"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return snapshot["hasNextPage"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }
}

public final class GetViewerFollowingQuery: GraphQLQuery {
  public static let operationString =
    "query GetViewerFollowing($after: String) {" +
    "  viewer {" +
    "    __typename" +
    "    following(first: 30, after: $after) {" +
    "      __typename" +
    "      edges {" +
    "        __typename" +
    "        node {" +
    "          __typename" +
    "          ...UserDetails" +
    "          viewerCanFollow" +
    "          viewerIsFollowing" +
    "        }" +
    "      }" +
    "      pageInfo {" +
    "        __typename" +
    "        endCursor" +
    "        hasNextPage" +
    "      }" +
    "    }" +
    "  }" +
    "}"
  public static var requestString: String { return operationString.appending(UserDetails.fragmentString) }

  public var after: String?

  public init(after: String? = nil) {
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [Selection] = [
      Field("viewer", type: .object(Data.Viewer.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewer: Viewer? = nil) {
      self.init(snapshot: ["__typename": "Query", "viewer": viewer])
    }

    public var viewer: Viewer? {
      get {
        return (snapshot["viewer"]! as! Snapshot?).flatMap { Viewer(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [Selection] = [
        Field("__typename", type: .nonNull(.scalar(String.self))),
        Field("following", arguments: ["first": 30, "after": Variable("after")], type: .object(Viewer.Following.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(following: Following? = nil) {
        self.init(snapshot: ["__typename": "User", "following": following])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var following: Following? {
        get {
          return (snapshot["following"]! as! Snapshot?).flatMap { Following(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "following")
        }
      }

      public struct Following: GraphQLSelectionSet {
        public static let possibleTypes = ["UserConnection"]

        public static let selections: [Selection] = [
          Field("__typename", type: .nonNull(.scalar(String.self))),
          Field("edges", type: .list(.object(Following.Edge.self))),
          Field("pageInfo", type: .nonNull(.object(Following.PageInfo.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
          self.init(snapshot: ["__typename": "UserConnection", "edges": edges, "pageInfo": pageInfo])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (snapshot["edges"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["UserEdge"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("node", type: .object(Edge.Node.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(node: Node? = nil) {
            self.init(snapshot: ["__typename": "UserEdge", "node": node])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["User"]

            public static let selections: [Selection] = [
              Field("__typename", type: .nonNull(.scalar(String.self))),
              Field("avatarUrl", type: .scalar(String.self)),
              Field("name", type: .nonNull(.scalar(String.self))),
              Field("username", type: .nonNull(.scalar(String.self))),
              Field("description", type: .nonNull(.scalar(String.self))),
              Field("viewerCanFollow", type: .nonNull(.scalar(Bool.self))),
              Field("viewerIsFollowing", type: .nonNull(.scalar(Bool.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(avatarUrl: String? = nil, name: String, username: String, description: String, viewerCanFollow: Bool, viewerIsFollowing: Bool) {
              self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "description": description, "viewerCanFollow": viewerCanFollow, "viewerIsFollowing": viewerIsFollowing])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            public var avatarUrl: String? {
              get {
                return snapshot["avatarUrl"]! as! String?
              }
              set {
                snapshot.updateValue(newValue, forKey: "avatarUrl")
              }
            }

            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            public var username: String {
              get {
                return snapshot["username"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "username")
              }
            }

            public var description: String {
              get {
                return snapshot["description"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "description")
              }
            }

            public var viewerCanFollow: Bool {
              get {
                return snapshot["viewerCanFollow"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerCanFollow")
              }
            }

            public var viewerIsFollowing: Bool {
              get {
                return snapshot["viewerIsFollowing"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerIsFollowing")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var userDetails: UserDetails {
                get {
                  return UserDetails(snapshot: snapshot)
                }
                set {
                  snapshot = newValue.snapshot
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("endCursor", type: .scalar(String.self)),
            Field("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(snapshot: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return snapshot["endCursor"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return snapshot["hasNextPage"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }
}

public final class GetViewerFollowingActivitiesQuery: GraphQLQuery {
  public static let operationString =
    "query GetViewerFollowingActivities($after: String) {" +
    "  viewer {" +
    "    __typename" +
    "    followingActivities(first: 30, after: $after, orderBy: {field: CREATED_AT, direction: DESC}) {" +
    "      __typename" +
    "      edges {" +
    "        __typename" +
    "        node {" +
    "          __typename" +
    "          ... on Status {" +
    "            __typename" +
    "            createdAt" +
    "            state" +
    "            user {" +
    "              __typename" +
    "              ...UserBasic" +
    "            }" +
    "            work {" +
    "              __typename" +
    "              title" +
    "              image {" +
    "                __typename" +
    "                recommendedImageUrl" +
    "              }" +
    "            }" +
    "          }" +
    "        }" +
    "      }" +
    "    }" +
    "  }" +
    "}"
  public static var requestString: String { return operationString.appending(UserBasic.fragmentString) }

  public var after: String?

  public init(after: String? = nil) {
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [Selection] = [
      Field("viewer", type: .object(Data.Viewer.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewer: Viewer? = nil) {
      self.init(snapshot: ["__typename": "Query", "viewer": viewer])
    }

    public var viewer: Viewer? {
      get {
        return (snapshot["viewer"]! as! Snapshot?).flatMap { Viewer(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [Selection] = [
        Field("__typename", type: .nonNull(.scalar(String.self))),
        Field("followingActivities", arguments: ["first": 30, "after": Variable("after"), "orderBy": ["field": "CREATED_AT", "direction": "DESC"]], type: .object(Viewer.FollowingActivity.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(followingActivities: FollowingActivity? = nil) {
        self.init(snapshot: ["__typename": "User", "followingActivities": followingActivities])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var followingActivities: FollowingActivity? {
        get {
          return (snapshot["followingActivities"]! as! Snapshot?).flatMap { FollowingActivity(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "followingActivities")
        }
      }

      public struct FollowingActivity: GraphQLSelectionSet {
        public static let possibleTypes = ["ActivityConnection"]

        public static let selections: [Selection] = [
          Field("__typename", type: .nonNull(.scalar(String.self))),
          Field("edges", type: .list(.object(FollowingActivity.Edge.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(edges: [Edge?]? = nil) {
          self.init(snapshot: ["__typename": "ActivityConnection", "edges": edges])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (snapshot["edges"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["ActivityEdge"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("node", type: .object(Edge.Node.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(node: Node? = nil) {
            self.init(snapshot: ["__typename": "ActivityEdge", "node": node])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          public var node: Node? {
            get {
              return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Status", "Record", "Review", "MultipleRecord"]

            public static let selections: [Selection] = [
              Field("__typename", type: .nonNull(.scalar(String.self))),
              FragmentSpread(Node.AsStatus.self),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public static func makeStatus(createdAt: String, state: StatusState, user: AsStatus.User, work: AsStatus.Work) -> Node {
              return Node(snapshot: ["__typename": "Status", "createdAt": createdAt, "state": state, "user": user, "work": work])
            }

            public static func makeRecord() -> Node {
              return Node(snapshot: ["__typename": "Record"])
            }

            public static func makeReview() -> Node {
              return Node(snapshot: ["__typename": "Review"])
            }

            public static func makeMultipleRecord() -> Node {
              return Node(snapshot: ["__typename": "MultipleRecord"])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            public var asStatus: AsStatus? {
              get {
                if !AsStatus.possibleTypes.contains(__typename) { return nil }
                return AsStatus(snapshot: snapshot)
              }
              set {
                guard let newValue = newValue else { return }
                snapshot = newValue.snapshot
              }
            }

            public struct AsStatus: GraphQLFragment {
              public static let possibleTypes = ["Status"]

              public static let selections: [Selection] = [
                Field("__typename", type: .nonNull(.scalar(String.self))),
                Field("createdAt", type: .nonNull(.scalar(String.self))),
                Field("state", type: .nonNull(.scalar(StatusState.self))),
                Field("user", type: .nonNull(.object(AsStatus.User.self))),
                Field("work", type: .nonNull(.object(AsStatus.Work.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(createdAt: String, state: StatusState, user: User, work: Work) {
                self.init(snapshot: ["__typename": "Status", "createdAt": createdAt, "state": state, "user": user, "work": work])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              public var createdAt: String {
                get {
                  return snapshot["createdAt"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "createdAt")
                }
              }

              public var state: StatusState {
                get {
                  return snapshot["state"]! as! StatusState
                }
                set {
                  snapshot.updateValue(newValue, forKey: "state")
                }
              }

              public var user: User {
                get {
                  return User(snapshot: snapshot["user"]! as! Snapshot)
                }
                set {
                  snapshot.updateValue(newValue.snapshot, forKey: "user")
                }
              }

              public var work: Work {
                get {
                  return Work(snapshot: snapshot["work"]! as! Snapshot)
                }
                set {
                  snapshot.updateValue(newValue.snapshot, forKey: "work")
                }
              }

              public struct User: GraphQLSelectionSet {
                public static let possibleTypes = ["User"]

                public static let selections: [Selection] = [
                  Field("__typename", type: .nonNull(.scalar(String.self))),
                  Field("avatarUrl", type: .scalar(String.self)),
                  Field("name", type: .nonNull(.scalar(String.self))),
                  Field("username", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(avatarUrl: String? = nil, name: String, username: String) {
                  self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var avatarUrl: String? {
                  get {
                    return snapshot["avatarUrl"]! as! String?
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "avatarUrl")
                  }
                }

                public var name: String {
                  get {
                    return snapshot["name"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "name")
                  }
                }

                public var username: String {
                  get {
                    return snapshot["username"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "username")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var userBasic: UserBasic {
                    get {
                      return UserBasic(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
                    }
                  }
                }
              }

              public struct Work: GraphQLSelectionSet {
                public static let possibleTypes = ["Work"]

                public static let selections: [Selection] = [
                  Field("__typename", type: .nonNull(.scalar(String.self))),
                  Field("title", type: .nonNull(.scalar(String.self))),
                  Field("image", type: .object(Work.Image.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(title: String, image: Image? = nil) {
                  self.init(snapshot: ["__typename": "Work", "title": title, "image": image])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var title: String {
                  get {
                    return snapshot["title"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "title")
                  }
                }

                public var image: Image? {
                  get {
                    return (snapshot["image"]! as! Snapshot?).flatMap { Image(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "image")
                  }
                }

                public struct Image: GraphQLSelectionSet {
                  public static let possibleTypes = ["WorkImage"]

                  public static let selections: [Selection] = [
                    Field("__typename", type: .nonNull(.scalar(String.self))),
                    Field("recommendedImageUrl", type: .scalar(String.self)),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(recommendedImageUrl: String? = nil) {
                    self.init(snapshot: ["__typename": "WorkImage", "recommendedImageUrl": recommendedImageUrl])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var recommendedImageUrl: String? {
                    get {
                      return snapshot["recommendedImageUrl"]! as! String?
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "recommendedImageUrl")
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

public final class GetViewerWorksQuery: GraphQLQuery {
  public static let operationString =
    "query GetViewerWorks($state: StatusState, $after: String) {" +
    "  viewer {" +
    "    __typename" +
    "    works(state: state, first: 30, after: after) {" +
    "      __typename" +
    "      edges {" +
    "        __typename" +
    "        node {" +
    "          __typename" +
    "          title" +
    "          image {" +
    "            __typename" +
    "            twitterAvatarUrl" +
    "            recommendedImageUrl" +
    "          }" +
    "        }" +
    "        cursor" +
    "      }" +
    "      pageInfo {" +
    "        __typename" +
    "        endCursor" +
    "        hasNextPage" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public var state: StatusState?
  public var after: String?

  public init(state: StatusState? = nil, after: String? = nil) {
    self.state = state
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["state": state, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [Selection] = [
      Field("viewer", type: .object(Data.Viewer.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewer: Viewer? = nil) {
      self.init(snapshot: ["__typename": "Query", "viewer": viewer])
    }

    public var viewer: Viewer? {
      get {
        return (snapshot["viewer"]! as! Snapshot?).flatMap { Viewer(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [Selection] = [
        Field("__typename", type: .nonNull(.scalar(String.self))),
        Field("works", arguments: ["state": "state", "first": 30, "after": "after"], type: .object(Viewer.Work.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(works: Work? = nil) {
        self.init(snapshot: ["__typename": "User", "works": works])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var works: Work? {
        get {
          return (snapshot["works"]! as! Snapshot?).flatMap { Work(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "works")
        }
      }

      public struct Work: GraphQLSelectionSet {
        public static let possibleTypes = ["WorkConnection"]

        public static let selections: [Selection] = [
          Field("__typename", type: .nonNull(.scalar(String.self))),
          Field("edges", type: .list(.object(Work.Edge.self))),
          Field("pageInfo", type: .nonNull(.object(Work.PageInfo.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
          self.init(snapshot: ["__typename": "WorkConnection", "edges": edges, "pageInfo": pageInfo])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (snapshot["edges"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["WorkEdge"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("node", type: .object(Edge.Node.self)),
            Field("cursor", type: .nonNull(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(node: Node? = nil, cursor: String) {
            self.init(snapshot: ["__typename": "WorkEdge", "node": node, "cursor": cursor])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "node")
            }
          }

          /// A cursor for use in pagination.
          public var cursor: String {
            get {
              return snapshot["cursor"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "cursor")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Work"]

            public static let selections: [Selection] = [
              Field("__typename", type: .nonNull(.scalar(String.self))),
              Field("title", type: .nonNull(.scalar(String.self))),
              Field("image", type: .object(Node.Image.self)),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(title: String, image: Image? = nil) {
              self.init(snapshot: ["__typename": "Work", "title": title, "image": image])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            public var title: String {
              get {
                return snapshot["title"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "title")
              }
            }

            public var image: Image? {
              get {
                return (snapshot["image"]! as! Snapshot?).flatMap { Image(snapshot: $0) }
              }
              set {
                snapshot.updateValue(newValue?.snapshot, forKey: "image")
              }
            }

            public struct Image: GraphQLSelectionSet {
              public static let possibleTypes = ["WorkImage"]

              public static let selections: [Selection] = [
                Field("__typename", type: .nonNull(.scalar(String.self))),
                Field("twitterAvatarUrl", type: .scalar(String.self)),
                Field("recommendedImageUrl", type: .scalar(String.self)),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(twitterAvatarUrl: String? = nil, recommendedImageUrl: String? = nil) {
                self.init(snapshot: ["__typename": "WorkImage", "twitterAvatarUrl": twitterAvatarUrl, "recommendedImageUrl": recommendedImageUrl])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              public var twitterAvatarUrl: String? {
                get {
                  return snapshot["twitterAvatarUrl"]! as! String?
                }
                set {
                  snapshot.updateValue(newValue, forKey: "twitterAvatarUrl")
                }
              }

              public var recommendedImageUrl: String? {
                get {
                  return snapshot["recommendedImageUrl"]! as! String?
                }
                set {
                  snapshot.updateValue(newValue, forKey: "recommendedImageUrl")
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("endCursor", type: .scalar(String.self)),
            Field("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(snapshot: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return snapshot["endCursor"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return snapshot["hasNextPage"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }
}

public struct UserDetails: GraphQLFragment {
  public static let fragmentString =
    "fragment UserDetails on User {" +
    "  __typename" +
    "  avatarUrl" +
    "  name" +
    "  username" +
    "  description" +
    "}"

  public static let possibleTypes = ["User"]

  public static let selections: [Selection] = [
    Field("__typename", type: .nonNull(.scalar(String.self))),
    Field("avatarUrl", type: .scalar(String.self)),
    Field("name", type: .nonNull(.scalar(String.self))),
    Field("username", type: .nonNull(.scalar(String.self))),
    Field("description", type: .nonNull(.scalar(String.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(avatarUrl: String? = nil, name: String, username: String, description: String) {
    self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "description": description])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var avatarUrl: String? {
    get {
      return snapshot["avatarUrl"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "avatarUrl")
    }
  }

  public var name: String {
    get {
      return snapshot["name"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  public var username: String {
    get {
      return snapshot["username"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "username")
    }
  }

  public var description: String {
    get {
      return snapshot["description"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "description")
    }
  }
}

public struct UserBasic: GraphQLFragment {
  public static let fragmentString =
    "fragment UserBasic on User {" +
    "  __typename" +
    "  avatarUrl" +
    "  name" +
    "  username" +
    "}"

  public static let possibleTypes = ["User"]

  public static let selections: [Selection] = [
    Field("__typename", type: .nonNull(.scalar(String.self))),
    Field("avatarUrl", type: .scalar(String.self)),
    Field("name", type: .nonNull(.scalar(String.self))),
    Field("username", type: .nonNull(.scalar(String.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(avatarUrl: String? = nil, name: String, username: String) {
    self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var avatarUrl: String? {
    get {
      return snapshot["avatarUrl"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "avatarUrl")
    }
  }

  public var name: String {
    get {
      return snapshot["name"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  public var username: String {
    get {
      return snapshot["username"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "username")
    }
  }
}

public struct RecordBasic: GraphQLFragment {
  public static let fragmentString =
    "fragment RecordBasic on Record {" +
    "  __typename" +
    "  comment" +
    "  createdAt" +
    "  user {" +
    "    __typename" +
    "    ...UserBasic" +
    "  }" +
    "  work {" +
    "    __typename" +
    "    title" +
    "  }" +
    "  episode {" +
    "    __typename" +
    "    title" +
    "    number" +
    "  }" +
    "}"

  public static let possibleTypes = ["Record"]

  public static let selections: [Selection] = [
    Field("__typename", type: .nonNull(.scalar(String.self))),
    Field("comment", type: .scalar(String.self)),
    Field("createdAt", type: .nonNull(.scalar(String.self))),
    Field("user", type: .nonNull(.object(RecordBasic.User.self))),
    Field("work", type: .nonNull(.object(RecordBasic.Work.self))),
    Field("episode", type: .nonNull(.object(RecordBasic.Episode.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(comment: String? = nil, createdAt: String, user: User, work: Work, episode: Episode) {
    self.init(snapshot: ["__typename": "Record", "comment": comment, "createdAt": createdAt, "user": user, "work": work, "episode": episode])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var comment: String? {
    get {
      return snapshot["comment"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "comment")
    }
  }

  public var createdAt: String {
    get {
      return snapshot["createdAt"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAt")
    }
  }

  public var user: User {
    get {
      return User(snapshot: snapshot["user"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "user")
    }
  }

  public var work: Work {
    get {
      return Work(snapshot: snapshot["work"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "work")
    }
  }

  public var episode: Episode {
    get {
      return Episode(snapshot: snapshot["episode"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "episode")
    }
  }

  public struct User: GraphQLSelectionSet {
    public static let possibleTypes = ["User"]

    public static let selections: [Selection] = [
      Field("__typename", type: .nonNull(.scalar(String.self))),
      Field("avatarUrl", type: .scalar(String.self)),
      Field("name", type: .nonNull(.scalar(String.self))),
      Field("username", type: .nonNull(.scalar(String.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(avatarUrl: String? = nil, name: String, username: String) {
      self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    public var avatarUrl: String? {
      get {
        return snapshot["avatarUrl"]! as! String?
      }
      set {
        snapshot.updateValue(newValue, forKey: "avatarUrl")
      }
    }

    public var name: String {
      get {
        return snapshot["name"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "name")
      }
    }

    public var username: String {
      get {
        return snapshot["username"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "username")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot = newValue.snapshot
      }
    }

    public struct Fragments {
      public var snapshot: Snapshot

      public var userBasic: UserBasic {
        get {
          return UserBasic(snapshot: snapshot)
        }
        set {
          snapshot = newValue.snapshot
        }
      }
    }
  }

  public struct Work: GraphQLSelectionSet {
    public static let possibleTypes = ["Work"]

    public static let selections: [Selection] = [
      Field("__typename", type: .nonNull(.scalar(String.self))),
      Field("title", type: .nonNull(.scalar(String.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(title: String) {
      self.init(snapshot: ["__typename": "Work", "title": title])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    public var title: String {
      get {
        return snapshot["title"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "title")
      }
    }
  }

  public struct Episode: GraphQLSelectionSet {
    public static let possibleTypes = ["Episode"]

    public static let selections: [Selection] = [
      Field("__typename", type: .nonNull(.scalar(String.self))),
      Field("title", type: .scalar(String.self)),
      Field("number", type: .scalar(Int.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(title: String? = nil, number: Int? = nil) {
      self.init(snapshot: ["__typename": "Episode", "title": title, "number": number])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    public var title: String? {
      get {
        return snapshot["title"]! as! String?
      }
      set {
        snapshot.updateValue(newValue, forKey: "title")
      }
    }

    public var number: Int? {
      get {
        return snapshot["number"]! as! Int?
      }
      set {
        snapshot.updateValue(newValue, forKey: "number")
      }
    }
  }
}