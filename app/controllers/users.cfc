component displayname="User Controller"
    accessors=true
    output=false
{
    property User;

    public void function show(struct rc) {
        param name="id" default=0;
        param name="user" default={};
        // this finds the User with an id of 1 and retrieves it
        rc.user = variables.User.findOrFail( rc.id );
    }
}
