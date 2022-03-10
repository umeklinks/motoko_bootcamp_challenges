import Custom "custom";
import Animal "animal";
import List "mo:base/List";
import FromListBase "mo:base/List";

actor {

    // Animal instantiation
    public type Animal = Animal.Animal;

    // Challenge 2 : (continuation) 
    //...create a variable that will store an animal
    let animals : Animal = {
           specie = "Cat";
           energy = 98;
       };

    // ** Challenge 1 : (Completion) ***
    /** ...and import it in your main.mo file. 
    In main, create a public function fun that takes no argument but 
    return a value of your custom type.
    Note : Be creative **/
    // customized 
    public type Custom = Custom.StudentDetails;

    let details: Custom = {
        name = " Abraham Kalu Ume";
        nationality = " Nigerian";
        profession = " Software Developer";
        level = " Beginner";
        descript = {
            height_cm = 176;
            color = " Chocolate";  
        };
    };

    public func fun() : async Custom {
        return details;
    };

// *****************************************************

    // *** Challenge 4 : ***
    /** In main.mo create a public function called create_animal_then_takes_a_break 
    that takes two parameter : a specie of type Text, an number of energy point of type Nat 
    and returns an animal. This function will create a new animal based on the parameters 
    passed and then put this animal to sleep before returning it ! zzz **/
    public func create_animal_then_takes_a_break( specie : Text, energy : Nat ) : async Animal {

        let animals : Animal = {
            specie = specie;
            energy = energy;
        };
        return animals;
    };

// *****************************************************

    // *** Challenge 5 : ***
    /** In main.mo, import the type List from 
    the base Library and create a list that stores animal. **/
    var animal_list = List.nil<Animal>();

// *****************************************************

    // *** Challenge 6 : ***
    /**In main.mo : create a function called push_animal that takes an animal
     as parameter and returns nothing this function should add this animal to 
     your list created in challenge 5. Then create a second functionc called get_animals 
     that takes no parameter but returns an Array that contains all animals stored in the list. **/
    public func push_animal( animal : Animal) : async () {
        animal_list := List.push<Animal>(animal, animal_list);
    };

    public func get_animals() : async [Animal] {
        return List.toArray<Animal>(animal_list);
    };

}