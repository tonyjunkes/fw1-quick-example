component displayname="FW/1 Life Cycle Bootstrap" extends="framework.one"
	output=false
{
	// FW/1 settings
	variables.framework = {
		base: "/app",
		defaultSection: "main",
		defaultItem: "default",
		error: "main.error",
		diEngine: "di1",
		diLocations: ["/app/model"],
		diConfig: {
			loadListener: function(di1) {
				// Make qb builders available in base
				di1.declare("Builder").asValue(getBeanFactory("quick").getBean("QueryBuilder")).done()
				   .declare("SchemaBuilder").asValue(getBeanFactory("quick").getBean("SchemaBuilder"));
			}
		},
		routes: [
			{ "/db/populate" = "/database/populate" },
			{ "/db/clear" = "/database/clear" },
			{ "/users/:id" = "/users/show/id/:id" },
			{ "/" = "/main/default" }
		],
		subsystems: {
			// Define quick subsystem dependencies
			quick.diLocations: ["/models", "/modules"],
			quick.diConfig: {
				// cbjavaloader calls some ColdBox related things so ignore and manually fake below
				exclude: ["cbjavaloader"],
				// By convention, alias certain beans with prepended values based on folder
				singulars: {
					Relationships: "@quick",
					Query: "@qb",
					Grammars: "@qb"
				},
				loadListener: function(di1) {
					// WireBox facade to mask DI/1 as WireBox for quick
					di1.declare("WireBox").asValue(getDefaultBeanFactory().getBean("WireBoxFacade")).done()
					// quick collection
					   .declare("QuickCollection@quick").instanceOf("quick.models.QuickCollection").done()
					// str
					   .declare("Str").instanceOf("quick.modules.str.models.Str").done()
					// qb
					   .declare("BaseGrammar").instanceOf("quick.modules.qb.models.Grammars.BaseGrammar").done()
					   .declare("MySQLGrammar").instanceOf("quick.modules.qb.models.Grammars.MySQLGrammar").done()
					   .declare("QueryUtils").instanceOf("quick.modules.qb.models.Query.QueryUtils").done()
					   .declare("QueryBuilder").instanceOf("quick.modules.qb.models.Query.QueryBuilder")
					   .withOverrides({
						   grammar: di1.getBean("MySQLGrammar"),
						   utils: di1.getBean("QueryUtils"),
						   returnFormat: function(q) {
								return di1.getBean("QuickCollection@quick", { collection = q });
						   }
						}).done()
					   .declare("SchemaBuilder").instanceOf("quick.modules.qb.models.Schema.SchemaBuilder")
					   .asTransient()
					   .withOverrides({
						   grammar: di1.getBean("MySQLGrammar")
						});
				}
			}
		},
		trace: true,
		reloadApplicationOnEveryRequest: true
	};

	public void function setupRequest() {
		getBeanFactory().getBean("DataService").create();
	}

	public string function onMissingView(struct rc) {
		return "Error 404 - Page not found.";
	}
}
