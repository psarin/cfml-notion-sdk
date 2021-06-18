<cfscript>
    void public function main() {

        var NOTION_TOKEN = Application.notion.auth;
        var notion = new lib.NotionClient (auth: NOTION_TOKEN);
        var not_renderable_text = "not renderable";

        writeOutput("<h1>Example of Database Retrieval</h1>");
        writeOutput("<h2>Use Notion API to retrieve and display rows in a database</h2>");

        writeOutput("<p>The app queries a database's properties and content, displaying the values of the database's properties for each row.</p>");

        var DATABASE_ID = Application.notion["DATABASE_ID"];
        // Retrieve database properties / structure from Notion and convert into our own database model
        var database_info = notion.databases.retrieve(argumentCollection={database_id: DATABASE_ID});
        var database_model = new models.Database().init(argumentCollection = database_info);

        // writedump(var = database_model);
        // abort;

        // Query the database for all rows (pages) contained in the database, returned as a list, and convert into our own list model
        // Note that for performance, Notion only returns X number of rows, with a key indicating if more rows are present in database
        // To retrieve additional data, another call must be made per Notion API
        var database_rows_list = notion.databases.query(argumentCollection={database_id: DATABASE_ID});
        var list_model = new models.List().init(argumentCollection = database_rows_list);

        // Now output a simple table to represent the results
        writeOutput("<table border=1>");

        // Output the header of table using the database_model
        writeOutput("<thead><tr>");
        for (var a=1; a <= arrayLen(database_model.properties); a++){
            writeOutput("<td>#database_model.properties[a].getName()#</td>");
        }
        writeOutput("</tr></thead>");

        // Output each row / page in the list representating the database queried (i.e., max number of rows pulled during initial call)
        writeOutput("<tbody>");
        for (var i=1; i <= arrayLen(list_model.results); i++){
            // Each row is a page represented by our page model
            var page = list_model.results[i];
            var page_properties = page.getProperties();

            writeOutput("<tr>");
            // For each property (column) in database, attempt to render out the most logical output
            // Spit out not renderable text warning if object displayText is not currently supported
            for (var j=1; j <= arrayLen(database_model.properties); j++){
                var property_id = database_model.properties[j].getID();

                var property_index = page_properties.find( (obj) => {
                    return obj.id == property_id;
                });
                if (property_index > 0){
                    var property_value = page_properties[property_index];
                    if (isNull(property_value.getDisplayText())){
                        writeOutput("<td>#not_renderable_text#</td>");                        
                    }else{
                        writeOutput("<td>#(property_value.getDisplayText()?:"&nbsp;")#</td>");
                    }
                }else{
                    writeOutput("<td>&nbsp;</td>");
                }
            }
            writeOutput("</tr>");
        }
        writeOutput("</tbody>");
        writeOutput("</table>");

    }

    main();

</cfscript>