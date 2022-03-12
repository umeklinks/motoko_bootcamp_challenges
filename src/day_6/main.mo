import Err "err_msg";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Array "mo:base/Array";
import HTTP "http";
import Text "mo:base/Text";

actor {
    public type TokenIndex = Nat;

    

     // challenge 2
    var registry: HashMap.HashMap<TokenIndex, Principal> = HashMap.HashMap<TokenIndex, Principal>(0, Nat.equal, Hash.hash);

    // challenge 3 
    stable var nextTokenIndex: TokenIndex = 0;
    type Result<T,E> = Result.Result<T, E>;

    public shared({caller}) func mint(): async Result<(), Text>{

        if(Principal.isAnonymous(caller)){
            return #err("Access denied!");
        };
        registry.put(nextTokenIndex, caller);
        nextTokenIndex += 1;

        #ok();
    };

    // challenge 4
    public shared({ caller }) func transfer(to : Principal, tokenIndex : TokenIndex) : async Result<(), Text> {
            if( Principal.isAnonymous( caller )) {
                return #err("Access denied!")
            };

            registry.put(nextTokenIndex, caller);
            #ok();
    };

    // challenge 5
    type Iter<K, V> = Iter.Iter<(K, V)>;
    public shared({ caller }) func balance() : async [ TokenIndex]  {
        var result : List.List<TokenIndex> = List.nil();

        for((nextTokenIndex, bPrincipal) in registry.entries()){
            if(Principal.equal( caller, bPrincipal)) result := List.push(nextTokenIndex, result);
        };
        List.toArray(result);
    };

    stable var entries : [(TokenIndex, Principal)] = [];
    public shared({ caller }) func http_request( request : HTTP.Request) : async HTTP.Response {
        let last_called_principal = switch(registry.get(nextTokenIndex)) {
            case(?p) Principal.toText(p);
            case(null) "";
        };

        let res = {
            body = Text.encodeUtf8("{\"token_count\" : \"" # Nat.toText(registry.size()) # "\", \"last_principal\" : \"" # last_called_principal # " }");
            headers = [("Content-Type", "text/html; charset=UTF-8")];
            status_code = 200 : Nat16;
            streaming_strategy = null
        };

        return(res);
    };

    system func preupgrade() {
        entries := Iter.toArray(registry.entries());
    };

    system func postupgrade() {
        registry := HashMap.fromIter<TokenIndex, Principal>(entries.vals(), entries.size(), Nat.equal, Hash.hash);
    };
}