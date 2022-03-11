import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Cycles "mo:base/ExperimentalCycles";
import Debug "mo:base/Debug";

actor {


    // *** Challenge 1 : ***
    /* Write a function is_anonymous that takes no arguments but 
    returns true is the caller is anonymous and false otherwise. */
    let anonymous_principal : Principal = Principal.fromText("2vxsx-fae");

    public shared({ caller}) func is_anonymous() : async Bool {
        return Principal.equal( caller, anonymous_principal);
    };

    // *** Challenge 2 : ***
    // Create an HashMap called favoriteNumber where the keys are Principal and the value are Nat.
    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    // Challenge 3 & 4
    // *** Challenge 3 : Write two functions : ***
    /*  add_favorite_number that takes n of type Nat and stores this value in the HashMap 
        where the key is the principal of the caller. This function has no return value.
    
        show_favorite_number that takes no argument and returns n of type ?Nat, n is the 
        favorite number of the person as defined in the previous function or null if the person 
        hasn't registered. 
        *** Challenge 4 : ***
        Rewrite your function add_favorite_number so that if the caller has already registered 
        his favorite number, the value in memory isn't modified. This function will return a 
        text of type Text that indicates "You've already registered your number" in that case 
        and "You've successfully registered your number" in the other scenario.
    */
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


    // *** Challenge 5 : Write two functions ***

    /*  update_favorite_number
        delete_favorite_number */
    public shared ({ caller }) func update_favorite_number(n : Nat) : async () {
        favoriteNumber.put(caller, n);
    };

    public shared ({ caller }) func delete_favorite_number() : async () {
        favoriteNumber.delete(caller);
    };

    // *** Challenge 6 : ***
    /* Write a function deposit_cycles that allow anyone to deposit cycles into the canister.
     This function takes no parameter but returns n of type Nat corresponding to the 
     amount of cycles deposited by the call. */
    public func deposit_cycles() : async Nat {
        let deposit_cycle_amount = Cycles.accept(
            Cycles.available()
        );
        Debug.print("Canister received: " # Nat.toText(deposit_cycle_amount) # "cycles.");
        return deposit_cycle_amount;
    };

    // *** Challenge 7 (hard warning) : ***
    /* Write a function withdraw_cycles that takes a parameter n of type Nat corresponding to the 
        number of cycles you want to withdraw from the canister and send it to caller asumming the caller has a 
        callback called deposit_cycles()
        Note : You need two canisters.
        Note 2 : Don't do that in production without admin protection or your might be the target of a cycle 
        draining attack. */
    public shared({ caller }) func withdraw_cycles(n : Nat) {
        let calling_actor : actor { deposit_cycles : (Nat) -> async Nat } = actor( Principal.toText(caller));
        Cycles.add(n);
        let cycles_withdrawn = await calling_actor.deposit_cycles(n);
        Debug.print("Canister has withdrew: " # Nat.toText(cycles_withdrawn) # "cycles");
    };

    // *** Challenge 8 : ***
    /* Rewrite the counter (of day 1) but this time the counter will 
    be kept accross ugprades. Also declare a variable of type Nat called versionNumber
    that will keep track of how many times your canister has been upgraded. */
    stable var counter : Nat = 0;
    stable var version_number : Nat = 0;

    public func get_version_upgrade_number() : async Nat {
        return version_number;
    };

    public func get_counter() : async Nat {
        return counter;
    };

    public func increment_counter(n : Nat) : async Nat {
        counter := counter + n;
        return counter;
    };

    system func postupgrade() {
        version_number += 1;
    };
}
