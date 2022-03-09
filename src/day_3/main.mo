import Array "mo:base/Array";
import ArrayFromPrivateSwap "mo:base/Array";
import Iter "mo:base/Iter";

actor {
    // *** Challenge 1 : ***
    // This is a pub func that calls private func swap
    public func getSwap(array : [Nat], i: Nat, j: Nat) : async [Nat] {
        return ArrayFromPrivateSwap.freeze(_swap(ArrayFromPrivateSwap.thaw(array), i, j));
    };

    /** Write a private function swap that takes 3 parameters : a mutable array , 
    an index j and an index i and returns the same array but where value at 
    index i and index j have been swapped. **/
    private func _swap(my_array : [var Nat], i: Nat, j: Nat) : [var Nat] {
        let array_idx = my_array[i];
        my_array[i] := my_array[j];
        my_array[j] := array_idx;
        return my_array;
    };

// *****************************************************

    // *** Challenge 2 : *** 
    /** Write a function init_count that takes a Nat n and returns 
    an array [Nat] where value is equal to it's corresponding index.
    Note : init_count(5) -> [0,1,2,3,4].
    Note 2 : Do not use Array.append. **/
    public func init_count(n : Nat) : async [Nat] {
        let array_elem_size : [var Nat] = Array.init(n, 0);
        for( i in Iter.range(0, n-1)) {
            array_elem_size[i] := i;
        };
        return Array.freeze(array_elem_size);
    };

// *****************************************************

    // *** Challenge 3 : ***
    /** Write a function seven that takes an array [Nat] and returns "Seven is found" if 
    one digit of ANY number is 7. Otherwise this function will return "Seven not found". **/
    public query func seven(arr: [Nat]) : async Text {
        for(n in arr.vals()){
            if (n == 7){
                return "Seven is found";
            }
        };
        return "Seven not found";
    };

    // *** Challenge 4 : ***
    /** Write a function nat_opt_to_nat that takes two parameters : n of type ?Nat 
    and m of type Nat . This function will return the value of n if n is not null 
    and if n is null it will default to the value of m. **/
    public query func nat_opt_to_nat(n: ?Nat, m : Nat) : async ?Nat {
        
        if( n != null ) {
            return n;
        };
        return ?(m);
    };

    // *** Challenge 5 : ***
    /** Write a function day_of_the_week that takes a Nat n and returns a Text value 
    corresponding to the day. If n doesn't correspond to any day it will return null . 
    day_of_the_week (1) -> "Monday".
    day_of_the_week (7) -> "Sunday".
    day_of_the_week (12) -> null.**/
    public func day_of_the_week(n : Nat) : async ?Text {
    let array : [Text] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  
    if (n >= 1) {
        if((n <= 7)){
            return ?(array[n - 1]);
        };
    };
    return null;
    };


    // *** Challenge 6 : ***
    /** Write a function populate_array that takes an array [?Nat] and returns an array [Nat] where all null values have been replaced by 0.
    Note : Do not use a loop. **/
    public func populate_array(array: [?Nat]) : async [Nat] {
        return Array.map<?Nat, Nat>(array, func(array_elements: ?Nat): Nat {
            return switch(array_elements) {
                case(null) {
                    0;
                }; case(?array_elements) {
                    array_elements;
                }
            }
        });
    };


    // *** Challenge 7 : ***
    /** Write a function sum_of_array that takes an array [Nat] and returns the 
    sum of a values in the array.Note : Do not use a loop. **/
    public func sum_of_array(array: [Nat]) : async Nat {
        return Array.foldRight<Nat, Nat>(array, 0, func(i, j) {return i + j;});
    };

    // *** Challenge 8 : ***
    /** Write a function squared_array that takes an array [Nat] and returns a new array 
    where each value has been squared.
    Note : Do not use a loop. **/
    public func squared_array(array : [Nat]) : async [Nat] {
        return (Array.map<Nat,Nat>(array, func (n : Nat) : Nat {return n ** 2}));
    };

    // *** Challenge 9 : ***
    /** Write a function increase_by_index that takes an array [Nat] and returns a new array where each number has been increased by it's corresponding index.
    Note : increase_by_index [1, 4, 8, 0] -> [1 + 0, 4 + 1 , 8 + 2 , 0 + 3] = [1,5,10,3]
    Note 2 : Do not use a loop. **/
    public func increase_by_index(array : [Nat]) : async [Nat] {
        return Array.mapEntries<Nat, Nat>(array, func(n, i) {return n + i;});
    };


    // *** Challenge 10 : ***
    /** Write a higher order function contains<A> that takes 3 parameters : an array [A] , a of type A 
    and a function f that takes a tuple of type (A,A) and returns a boolean.
    This function should return a boolean indicating whether or not a is present in the array. **/
    public query func contains(nx : [Nat], n : Nat): async Bool {
        return _contains<Nat>(nx, n,  func( a : Nat, b : Nat ) { a == b } );
    };


    private func _contains<A>(nm: [A], a: A, f: (A, A) -> Bool): Bool {
        return Option.isSome(Array.find<A>(nm, func( x : A ){ f( x, a )})) ;
    };


}