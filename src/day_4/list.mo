module {

    public type List<T> = ?(T, List<T>);

    // *** Challenge 7 : ***
    /** Write a function is_null that takes l of type List<T> and 
    returns a boolean indicating if the list is null . 
    Tips : Try using a switch/case. **/
    public func is_null<T>( l : List<T>) : Bool {
        return switch(l) {
            case(null) return true;
            case(?l) return false;
        }
    };

// *****************************************************

    // *** Challenge 8 : ***
    /** Write a function last that takes l of type List<T> and returns 
    the optional last element of this list. **/
    public func last<T>( l : List<T> ) : List<T> {
        switch(l) {
            case(null) return null;
            case(?l) {
                let lx = l.1;
                switch(lx) {
                    case(null) ?l;
                    case(?lx) last<T>(?lx);
                }
            }
        }
    };

// *****************************************************

    // *** Challenge 9 : ***
    /**Write a function size that takes l of type List<T> and returns 
    a Nat indicating the size of this list.
    Note : If l is null , this function will return 0. **/
    public func size<T>(list: List<T>): Nat {
        switch(list){
            case(null) return 0;
            case(?list){
                let (_,l) = list;
                return size(l) + 1;
            };
        };       
    };

// *****************************************************

    // *** Challenge 10 : Write a function get that takes two arguments : l of type List<T> 
    /** and n of type Nat this function should return the optional value at rank n in the list. **/
    public func get<T>(l: List<T>, n: Nat): List<T> {
        return switch(l) {
            case(null) {
                null;
            }; case(?l) {
                switch(n) {
                    case(0) {
                        ?l;
                    }; case(_) {
                        get<T>(l.1, n-1);
                    }
                }
            }
        }
    };

// *****************************************************

    // *** Challenge 11 : **
    // Write a function reverse that takes l of type List and returns the reversed list.
    public func reverse<T>( l : List<T>) : List<T> {
        if (is_null(l)) return null;
        var idx: Nat = size<T>(l)-1;
        var list_reversed: List<T> = null;
        while (idx >= 0) {
            let list_items: List<T> = get<T>(l, idx);
            switch(list_items) {
                case(null) return null;
                case(?list_items) {
                   list_reversed := ?(list_items.0, list_reversed);
                }
            };
            idx -= 1;
        };
        return list_reversed;
    };
}