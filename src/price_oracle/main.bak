import Int "mo:base/Int";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Int64 "mo:base/Int64";
import Error "mo:base/Error";
import Array "mo:base/Array";
import Option "mo:base/Option";
import Principal "mo:base/Principal";

shared ({ caller = initializer }) actor class Price_Oracle() {
//actor Price_Oracle {

  public type Record = {
      timestamp : Int;
      date : Text;
      price : Int64;
  };

  let capacity : Nat = 2**24 - 1; // approx 30 times a minute for 25 years
  let maxTime : Int = 2**32 - 1; // maximum time value, overflow in 2038 for 32-bit
  let defaultRecord : Record = {
    timestamp = Time.now();
    date = "19700101"; // 1 January 1970, yyyymmdd
    price = 0;
  };

  // persistent data
  stable let records : [var Record] = Array.init<Record>(capacity, defaultRecord);
  stable let timeArr : [var Int] = Array.init<Int>(capacity, maxTime);
  stable var index : Nat = 0;
  stable var admins: [Principal] = [];

  // add a new price record
  public shared(msg) func addRecord(_date : Text, _price : Int64) : async () {
    if (not authorized(msg.caller)) { throw Error.reject( "unauthorized") };
    let record : Record = {
      timestamp = Time.now();
      date = _date;
      price = _price;
    };
    // use Buffer and Buffer.append
    records[index] := record;
    timeArr[index] := Time.now();
    // increment index position
    index += 1;
  };

  // return a price for a closest given timestamp
  public func getPrice(_timestamp : Int) : async Int64 {
    var record : Record = defaultRecord;
    let index : Nat = findIdx(_timestamp);
    record := records[index];
    return record.price;
  };

  // return a corresponding record at an index postion
  public func getRecord(_index : Nat) : async (Text, Int64, Int) {
    let record : Record = records[_index];
    return (record.date, record.price, record.timestamp);
  };

  // return latest price
  public func getLatest() : async Int64 {
    return records[index-1].price;
  };

  // utility helpers
  public func getIndex() : async Int {
    return index;
  };

  public shared(msg) func checkAdmin() : async Bool {
    msg.caller == initializer or isAdmin(msg.caller);
  };

  public shared(msg) func setAdmin(user : Principal) : async () {
    if (not authorized(msg.caller)) { throw Error.reject( "unauthorized") };
    admins := Array.append<Principal>(admins, [user]);
  };

  public func getOwner() : async Principal {
    return initializer;
  };

  private func findIdx(_timestamp : Int) : Nat {
    var index : Nat = 0;
    var result : Int = timeArr[index];
    if (result > _timestamp) return index;
    var prev : Nat = index; // track previous index
    // find index range for target timestamp
    while (result < _timestamp) {
      prev := index;
      index := 2**index; // quadradic steps
      result := timeArr[index];
    };
    // binary search index range
    var mid : Nat = 0;
    result := timeArr[prev];
    loop {
      if (index < prev) { return prev; };
      mid := ((index - prev) / 2) + prev; // set midpoint
      result := timeArr[mid];
      if (result < _timestamp) {
        prev := mid + 1;
      };
      if (_timestamp < result) {
        index := mid - 1;
      };
      if (result == _timestamp) { return mid };
    };
    return index;
  };

  // authorization
  private func isAdmin(user: Principal) : Bool {
    func identity(x : Principal) : Bool { x == user };
    Option.isSome(Array.find<Principal>(admins, identity));
  };

  private func authorized(user: Principal) : Bool {
    user == initializer or isAdmin(user);
  };

};
