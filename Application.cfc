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
		this.triggerDataMember=true;
		this.invokeImplicitAccessor=true;
	*/

	function onApplicationStart()
	{
        Application.baseUrl = 'https://api.notion.com/v1';
	}

	function onRequestStart()
	{
	}

	function getRequestSettings(){
	}
}