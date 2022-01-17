<cfscript>
    void public function main() {

        var NOTION_TOKEN = Application.notion.auth;
        var notion = new lib.NotionClient (auth: NOTION_TOKEN);
        var useDatabaseKey = "projects";
        var DATABASE_ID = Application.notion["databases"][useDatabaseKey]?.DATABASE_ID;

        // Get list of users
        writeOutput("Getting list of users<BR/>");
        var usersList = notion.users.list().results;
        // writeDump(var=usersList);
        writeOutput("<HR/>");

        // Get user info by userid
        if (!arrayIsEmpty(userslist)){
            writeOutput("Getting user info by userid<BR/>");
            var userInfo = notion.users.retrieve(userslist[1].id); 
            // writeDump(var=userInfo);
            writeOutput("<HR/>");    
        }

        // Simple search
        writeOutput("Performing a simple search<BR/>");
        // writeDump(var=notion.search.search(argumentCollection = {
        //     query: 'cardiac',
        //     sort: {
        //       direction: 'ascending',
        //       timestamp: 'last_edited_time',
        //     },
        // }));
        writeOutput("<HR/>");

        // Query a database and get content for first page
        writeOutput("Querying a database, retrieving a page from database, and retrieving blocks for a page<BR/>");
        var DATABASE_ID = DATABASE_ID?:'';     
        var resultDB = notion.databases.query(argumentCollection={database_id: DATABASE_ID});
        writeOutput("Database results<BR/>");
        // writeDump(var = resultDB);
        writeOutput("<HR/>");

        for (var i=1; i <= arrayLen(resultDB.results); i++){
            var result = resultDB.results[i];
            
            if (result.object eq 'page'){
                var id = result.id;
                var resultPage = notion.pages.retrieve(id);
                writeDump(var=resultPage);
                var resultPageTitle = resultPage.properties.Slug.title[1].plain_text;

                writeOutput("Page results for page with title <u>#resultPageTitle#</u> and id #resultPage.id#<BR/>");
                writeOutput("<HR/>");
                var resultBlocks = notion.blocks.retrieve(resultPage.id);
                // var resultBlocks = notion.blocks.children.list(id).results;
                writeOutput("Blocks for page with title <u>#resultPageTitle#</u> and id #resultPage.id#<BR/>");
                writeDump(var=resultBlocks?.results);
                writeOutput("<HR/>");
                break;
            }
        }
        writeOutput("FINISHED!<BR/>");    
    }

    main();

</cfscript>