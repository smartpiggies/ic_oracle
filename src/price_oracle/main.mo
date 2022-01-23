import Int "mo:base/Int";
import Nat32 "mo:base/Nat32";
import Int64 "mo:base/Int64";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Time "mo:base/Time";
import Debug "mo:base/Debug";

actor Price_Oracle {

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
  let records : [var Record] = Array.init<Record>(capacity, defaultRecord);
  let timeArr : [var Int] = Array.init<Int>(capacity, maxTime);
  stable var index : Nat = 0;

  // add a new price record
  public func addRecord(_date : Text, _price : Int64) : async () {
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

  // utility helpers
  public func getIndex() : async Int {
    return index;
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

};
