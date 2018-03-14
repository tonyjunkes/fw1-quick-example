component displayname="Database Service"
	accessors=true
	output=false
{
	property SchemaBuilder;
	property Builder;

	void function create() {
		// Users
		if (!SchemaBuilder.hasTable("users")) {
			SchemaBuilder.create("users", function(table) {
				table.increments("id");
				table.string("username").unique();
				table.string("email").unique();
				table.string("password");
				table.timestamp("createdDate");
				table.timestamp("updatedDate");
			});
		}
	}

	void function populate() {
		// Author
		if (!SchemaBuilder.hasTable("users")) {
			create();
		}
		Builder.from("users").insert(
			values = {
				username: "jdoe",
				email: "jdoe@test.email",
				password: "tvBvOpODv4BiPGwCcPFeenYIVFis6LuDgqX",
				createdDate: now(),
				updatedDate: now()
			}
		);
	}

	void function clear() {
		SchemaBuilder.dropIfExists("users");
	}
}
