import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor {
  // public func greet(name : Text) : async Text {
    //     // var a = 5;
    //     // var mySum = a + 3;
    //     return "Hello, " # name # "!";
    // };

    stable var counter : Nat = 0;
    

    // *** CHALLENGE 1 ***
    // Write a function add that takes two natural numbers n and m and returns the sum.
    public func add (n : Nat, m : Nat) : async Nat {
        return n + m;
    };

  // *********************************************
    
    // *** CHALLENGE 2 ***
    //Write a function square that takes a natural number n and returns the area of a square of length n.
    public func square (n : Nat ) : async Nat {
        var area = n * n;
        return  area;
    };

  // ************************************************

    // *** CHALLENGE 3 ***
    // Write a function days_to_second that takes a number of days n and returns the number of seconds. 
    public func days_to_second (n : Nat ) : async Nat {
        var seconds = n * 60 * 60;
        return seconds;
    };

  // ************************************************

    // *** CHALLENGE 4 ***
    // Write two functions increment_counter & clear_counter .
    // This function does the incrementation
    public func increment_counter () : async Nat {
        counter += 1;
        return counter;
    };

    // This function gets the current counter value
    public query func getCounter() : async Nat {
        counter
    };

    // This function sets the counter value, you wish to increment from
    public func setCounter( n : Nat ) : async () {
        counter := n;
        // return counter;
    };

    // This function resets the counter to zero
    public func clear_counter() : async Nat {
        counter := 0;
        return counter;
    };

  // ************************************************

    // *** CHALLENGE 5 ***
    // Write a function divide that takes two natural numbers n and m and returns a boolean indicating if y divides x.
    public func divide( n : Nat, m : Nat) : async Bool {
        return ((n % m) == 0);
    };

  // ************************************************

    // *** CHALLENGE 6 ***
    // Write a function is_even that takes a natural number n and returns a boolean indicating if n is even.
    public func is_even ( n : Nat ) : async Bool {
        return ((n % 2) == 0);
    };

  // ************************************************

    // *** CHALLENGE 7 ***
    // Write a function sum_of_array that takes an array of natural numbers and returns the sum. This function will returns 0 if the array is empty.
    
    var my_array : [var Nat] = [var ];

    public func sum_of_array( my_array : [Nat] ) : async Nat {
      if( my_array.size() == 0 ) {
        return 0
      };

      var counter : Nat = 0;
      for( value in my_array.vals() ) {
        counter := counter + value;
      };
      return( counter );

    };

  // ************************************************

    // *** CHALLENGE 8
    // Write a function maximum that takes an array of natural numbers and returns the maximum value in the array. This function will returns 0 if the array is empty.
    // let max_array : [var Nat] = [var ];
    public func maximum( max_array : [Nat] ) : async Nat {
      if( max_array.size() != 0) {
        return max_array.size();
      } else {
        return 0;
      }
      
    };

// ************************************************

  // *** CHALLENGE 9
  // Implement a function selection_sort that takes an array of natural numbers and returns the sorted array 
  // let xs : [var Nat] = [4, 2, 6, 1, 5];
  public func remove_from_array(array : [Nat], n : Nat) : async [Nat] {
        let array_filter = func(nx : Nat) : Bool {
            if( nx == n ) {
                return false
            } else {
                return true
            }
        } ;
        return ( Array.filter(array, array_filter));
    }
    
  // *** CHALLENGE 10 in progress

};
