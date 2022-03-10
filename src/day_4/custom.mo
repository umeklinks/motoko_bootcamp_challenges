module {
    // Challenge 1: 
    /** Create two files called custom.mo and main.mo, 
    create your own type inside custon.mo (check main.mo for continuation) **/
    public type StudentDetails = {
        name : Text;
        nationality: Text;
        profession : Text;
        level : Text;
        descript : {
            height_cm : Nat;
            color : Text;  
        };
        
    };

}