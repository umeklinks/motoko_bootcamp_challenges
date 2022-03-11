import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";

// *** Challenge 9 : ***
/* In a new file, copy and paste the functionnalities you've created in challenges 2 to 5. This time the hashmap and all records should be preserved accross upgrades. */
actor upgrade {

    stable var version_number : Nat = 0;
    stable var entries: [(Principal, Nat)] = [];

    var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    public shared({ caller }) func add_favorite_number( n : Nat) : async Text {
        let registerNo = favoriteNumber.get( caller );
        if( registerNo == null ){
            favoriteNumber.put(caller, n);
            "You've successfully registered your number";
        } else {
            "You've already registered your number";
        };
    };

    public shared({ caller }) func show_favorite_number() : async ?Nat {
        return favoriteNumber.get( caller );
    };

    public shared ({ caller }) func update_favorite_number(n : Nat) : async () {
        favoriteNumber.put(caller, n);
    };

    public shared ({ caller }) func delete_favorite_number() : async () {
        favoriteNumber.delete(caller);
    };

    system func preupgrade() {
        entries := Iter.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
        entries := [];
        version_number += 1;
    };

}