component NotionClient {

    public function init (
        required String auth,
        String notionVersion = Application?.notion?.notionVersion,
        String baseUrl = Application?.notion?.baseUrl
    ) {
        this.auth = arguments.auth;
        this.notionVersion = arguments.notionVersion;
        this.baseUrl = arguments.baseUrl;

        this.databases = new src.DatabaseAPI(httpService: this.httpService());
        this.pages = new src.PageAPI(httpService: this.httpService());
        this.blocks = new src.BlockAPI(httpService: this.httpService());
        this.users = new src.UserAPI(httpService: this.httpService());
        this.search = new src.SearchAPI(httpService: this.httpService());

        return this;
    }

    public function httpService(){

        var httpService = new http(method = 'GET', charset = 'utf-8');
        httpService.addParam(type = 'header', name = 'Content-Type', value = 'application/json');
        httpService.addParam(type = 'header', name = 'Accept', value = 'application/json');
        httpService.addParam(type = 'header', name = 'Authorization', value = 'Bearer #this.auth#');
        httpService.addParam(type = 'header', name = 'Notion-Version', value = '#this.notionVersion#');

        return function (){
            for (var key in arguments){
                switch(key) {
                    case "method":
                        httpService.setMethod(arguments.method);
                    break;

                    case "body":
                        httpService.addParam(type="body", value = "#serializeJson(arguments.body)#");
					break;

                    case "url":
						var _url = this.baseUrl & "/" & arguments.url;

						if (!isNull(arguments.filter_properties)) {
							if (arguments.filter_properties?.len() > 0) {
								_url = _url & "?";
							}

							for (var propertyName in arguments.filter_properties) {
								_url = _url & "filter_properties=#propertyName#&";
							}
						}
                        httpService.setURL(_url);
                    break;

                }
            }

            var response = httpService.send().getPrefix();

            if (response.status_code != 200) {
                var message = arguments.message?:'Unknown';
                writeDump('error #message#');
                writedump(var=response);
            }else{
                return deserializeJSON(response.filecontent);
            }

        };
    }

    public function toMap() {
        return {
            'auth': this.auth,
            'notionVersion': this.notionVersion,
        };
    }
}