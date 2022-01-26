import Text "mo:base/Text";
import Error "mo:base/Error";
import Array "mo:base/Array";
import Option "mo:base/Option";
import Principal "mo:base/Principal";

shared (msg) actor class Authorizer() {

  let owner = msg.caller;

  stable var admins: [Principal] = [];

  public func getOwner() : async Text {
    return Principal.toText(owner);
  };

  public shared(msg) func setAdmin(user : Principal) : async () {
    await authorized(msg.caller);
    admins := Array.append<Principal>(admins, [user]);
  };

  public func isAdmin(user: Principal) : async Bool {
    func identity(x : Principal) : Bool { x == user };
    Option.isSome(Array.find<Principal>(admins, identity));
  };

  public shared(msg) func checkAdmin() : async Bool {
    if (msg.caller == owner) { return true; }
    else if (await isAdmin(msg.caller)) { return true; }
    else { return false; }
  };

  public func authorized(user: Principal) : async () {
    if (user != owner) { throw Error.reject( "unauthorized"); }
    if (await isAdmin(user) == false) { throw Error.reject( "unauthorized"); }
  };

}
