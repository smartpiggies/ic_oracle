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

  let capacity : Nat = 2**32 - 1;
  let defaultRecord : Record = {
    timestamp = Time.now();
    date = "19710101";
    price = 0;
  };
  let records : [var Record] = Array.init<Record>(capacity, defaultRecord);
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
    // increment index position
    index += 1;
  };

  // return a price
  //public func getPrice(_date : Text) : async Int64 {
  //  let record : Record;
  //  record := Array.find<Record>(records : [Record], )
  //};




};
