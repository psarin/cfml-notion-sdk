<cfscript>
    void public function main() {

        var NOTION_TOKEN = Application.notion.auth;
        var notion = new lib.NotionClient (auth: NOTION_TOKEN);

        // Get list of users
        writeoutput("Getting list of users<BR/>");
        var userslist = notion.users.list().results;
        writedump(var=userslist);
        writeoutput("<HR/>");

        // Get user info by userid
        if (!arrayIsEmpty(userslist)){
            writeoutput("Getting user info by userid<BR/>");
            var userinfo = notion.users.retrieve(userslist[1].id); 
            writedump(var=userinfo);
            writeoutput("<HR/>");    
        }

        // Simple search
        writeoutput("Performing a simple search<BR/>");
        writedump(var=notion.search.search(argumentCollection = {
            query: 'cardiac',
            sort: {
              direction: 'ascending',
              timestamp: 'last_edited_time',
            },
        }));
        writeoutput("<HR/>");

        // Query a database and get content for first page
        writeoutput("Querying a database, retrieving a page from database, and retrieving blocks for a page<BR/>");
        var DATABASE_ID = Application.notion.DATABASE_ID?:'';     
        var resultDB = notion.databases.query(argumentCollection={database_id: DATABASE_ID});
        writeoutput("Database results<BR/>");
        writedump(var = resultDB);
        writeoutput("<HR/>");

        for (var i=1; i <= arrayLen(resultDB.results); i++){
            var result = resultDB.results[i];
            
            if (result.object eq 'page'){
                var id = result.id;
                var resultPage = notion.pages.retrieve(id);
                var resultPageTitle = resultPage.properties.Title.title[1].plain_text;

                writeoutput("Page results for page with title <u>#resultPageTitle#</u> and id #resultPage.id#<BR/>");
                writedump(var=resultPage);
                writeoutput("<HR/>");
                
                var resultBlocks = notion.blocks.children.list(id).results;
                writeoutput("Blocks for page with title <u>#resultPageTitle#</u> and id #resultPage.id#<BR/>");
                writedump(var=resultBlocks);
                writeoutput("<HR/>");
                break;
            }
        }
        writeoutput("FINISHED!<BR/>");    
    }

    main();

</cfscript>