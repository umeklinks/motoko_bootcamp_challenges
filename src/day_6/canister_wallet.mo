import ErrorMsg "err_msg";
import Result "mo:base/Result";
import Principal "mo:base/Principal";

actor class Minter(canister_id: Principal) {
    public type MainActor = actor { mint : () -> async Result.Result<(), ErrorMsg.Error> };

    public func mint() {
        let actor_caller: MainActor = actor(Principal.toText(canister_id));
        ignore await actor_caller.mint();
    };
};