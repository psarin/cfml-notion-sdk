component {

	this.name="notion_sdk_cfml";
	
	this.clientmanagement="true";
	this.sessionmanagement="true";
	this.setclientcookies="true";
	this.setdomaincookies="false";
	this.sessiontimeout=createTimeSpan(0,2,0,0);
	this.applicationtimeout=createTimeSpan(1,0,0,0);
	this.loginstorage="session";

    this.mappings["/lib"] = getDirectoryFromPath(getCurrentTemplatePath()) & "lib";
	this.mappings["/models"] = getDirectoryFromPath(getCurrentTemplatePath()) & "lib/src/models";

	/*
		this.datasource = "db_notion";
		this.ormEnabled = true;
		this.ormsettings = {cfclocation = this.mappings["/models"],
							eventhandling = true,
							flushatrequestend = false,
							//secondarycacheenabled = true, Cacheprovider = "EHCache",
							logsql="false"};
	*/
	this.triggerDataMember=true;
	this.invokeImplicitAccessor=true;

	function onApplicationStart()
	{
		// Default Notion settings
		Application.notion = {
			notionVersion: "2021-05-13",
			baseUrl: "https://api.notion.com/v1"
		}

	}

	function onRequestStart()
	{
		// If settings.json file exists, read Notion settings from file.
		try{
			var settings = deserializeJson(fileRead('./settings.json'));
			if (!isNull(settings)){
				for (var key in settings){
					Application.notion[key] = settings[key];
				}	
			}
		}catch (any e){
			if (!findnocase('does not exist', e.Message)){
				writeOutput("<div style='background-color:red; color: white; width:90%; padding:10px; top:0px; left:0px;'>Settings.json file exists but contains errors. Default settings to be used. <BR/><BR/>#e.Message#<BR/></div>");
			}
		}
	}
}