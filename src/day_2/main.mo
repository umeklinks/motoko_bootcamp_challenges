import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";
import Char "mo:base/Char";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

actor {
    
    // *** Challenge 1 : ***
    // Write a function nat_to_nat8 that converts a Nat n to a Nat8. 
    // Make sure that your function never trap.
    public func nat_to_nat8( n : Nat) : async Nat8 {
        var m : Nat8 = 0;
        if( n > 255 ) {
            return 0;
        };
        m := Nat8.fromNat(n);
        return m;
        
    };

    // let toText : (c : Char) -> Text


// *****************************************************

    // Challenge 2 : ***
    // Write a function max_number_with_n_bits that takes a Nat n and returns 
    // the maximum number than can be represented with only n-bits.
    public func max_number_with_n_bits( n : Nat ) : async Nat {
        // raising the power of n by itself -> (n**n) ie (bit**n)
        var mn : Nat = (2**n)-1;
        return mn;
        
    };

    // Still on challenge two, but commentated this function out of 
    // confusion - not knowing if another number is required for the 
    // maximum number that can be acquired - (raise-to-power)
    // Let's say (n**m) ie (2**5)
    /**
    public func max_number_with_n_bits( n : Nat, raised_to_power: Nat ) : async Nat {
        var mn : Nat = n**raised_to_power;
        return mn;
        
    } **/

    // *** Challenge 3 : ***
    // Write a function decimal_to_bits that takes a Nat n and returns a Text 
    // corresponding to the binary representation of this number.
    //Note : decimal_to_bits(255) -> "11111111".
    public func decimal_to_bits(n : Nat) : async Text {
        if (n == 0) {
            return "0";
        };
        // set the value to hold the bits to empty
        var number_in_bits : Text = "";
        var decimal_number : Nat = n; // assign the value of n to a decimal holder

        // checking if n value is perfect for computing
        while (decimal_number != 1) {
            let m = decimal_number % 2;
            decimal_number := decimal_number / 2;
            number_in_bits := Nat.toText(m) # number_in_bits;
            
        };
        
        number_in_bits := "1" # number_in_bits;
        return number_in_bits;
    };

// *****************************************************

    // *** Challenge 4 : ***
    // Write a function capitalize_character that takes a Char c and 
    // returns the capitalized version of it.
    public func capitalize_character(c : Char) : async Text {
        let x : Nat32 = Char.toNat32(c) - 32; // 32 is constant
    	let char : Char = Char.fromNat32(x);
    	return(Char.toText(char));
    };

// *****************************************************

    // *** Challenge 5 : ***
    // Write a function capitalize_text that takes a Text t and returns the capitalized version of it.
    public func capitalize_text(t : Text) : async Text {
        var text_to_capitalize : Text = "";
        for( each_char in t.chars()) {
            let transform_chars : Nat32 = Char.toNat32(each_char) - 32; // 32 is constant
            text_to_capitalize := text_to_capitalize # Char.toText(Char.fromNat32(transform_chars))
        };
        
    	// let char : Char = Char.fromNat32(x);
    	return text_to_capitalize;
    };

// *****************************************************

    // *** Challenge 6 : ***
    /** Write a function is_inside that takes two arguments : a Text t and a Char c and 
    returns a Bool indicating if c is inside t .**/
    public func is_inside(t : Text, c : Char) : async Bool {
        let char_to_search : Text.Pattern = #char(c);
        return (Text.contains(t, char_to_search));
    };

// *****************************************************

    // *** Challenge 7 : ***
    // Write a function trim_whitespace that takes a text t and returns the trimmed version of t. 
    // Note : Trim means removing any leading and trailing spaces from the text : trim_whitespace(" Hello ") -> "Hello".
    public func trim_whitespace(t : Text) : async Text {
        let normal_text : Text.Pattern = #text(" ");
        let trim_text : Text = Text.trim(t,normal_text);
        return trim_text;
    };

// *****************************************************

    // *** Challenge 8 : ***
    /**Write a function duplicated_character that takes a Text t and returns the 
    first duplicated character in t converted to Text. Note : The function should 
    return the whole Text if there is no duplicate character : 
    duplicated_character("Hello") -> "l" & duplicated_character("World") -> "World". **/
    public func duplicated_character(t : Text) : async Text {
        var chars_in_text : [Char] = Iter.toArray(t.chars());
        var char_index : Nat = chars_in_text.size() - 1;

        for ( i in Iter.range( 0, char_index )) {
            for( j in Iter.range( i + 1, char_index ) ) {
                if ( Char.equal( chars_in_text[i], chars_in_text[j] )) {
                    return Char.toText(chars_in_text[i]);
                };
            };
        };
        return t;
    };

    // *** Challenge 9 : ***
    /** Write a function size_in_bytes that takes Text t and returns the number of 
    bytes this text takes when encoded as UTF-8. **/
    public func size_in_bytes(t : Text) : async Nat {
        let encode_text : Blob = Text.encodeUtf8(t);
        let text_size : Nat = encode_text.size();
        return text_size;
    };

    // *** Challenge 10 : ***
    /** Implement a function bubble_sort that takes an array of natural numbers and 
    returns the sorted array. **/
    public func bubble_sort(n : [Nat]) : async [Nat] {
        var array_to_sort : [var Nat] = Array.thaw(n);
        var mini_index: Nat = array_to_sort.size() -1;

        for( i in Iter.range( 0, mini_index )) {
            for( j in Iter.range( 0, mini_index - i - 1 )) {
                if( array_to_sort[j] > array_to_sort[ j + 1 ]) {
                    var temp_array = array_to_sort[j];
                    array_to_sort[j] := array_to_sort[j + 1];
                    array_to_sort[j + 1] := temp_array;
                };
            };
        };
        return Array.freeze(array_to_sort);
    };
}