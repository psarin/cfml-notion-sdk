component NotionClient {

    public function init (
        required String auth,
        String notionVersion = Application.notion.notionVersion,
        String baseUrl = Application.notion.baseUrl
    ) {
        this.auth = arguments.auth;
        this.notionVersion = arguments.notionVersion;
        this.baseUrl = arguments.baseUrl;

        this.databases = new lib.src.DatabaseAPI(httpService: this.httpService());
        this.pages = new lib.src.PageAPI(httpService: this.httpService());
        this.blocks = {
            children: new lib.src.BlockAPI(httpService: this.httpService())
        };
        this.users = new lib.src.UserAPI(httpService: this.httpService());
        this.search = new lib.src.SearchAPI(httpService: this.httpService());

        return this;
    }

    public function httpService(){

        var httpService = new http(method = 'GET', charset = 'utf-8');
        httpService.addParam(type = 'header', name = 'Content-Type', value = 'application/json');
        httpService.addParam(type = 'header', name = 'Accept', value = 'application/json');
        httpService.addParam(type = 'header', name = 'Authorization', value = 'Bearer #this.auth#');
        httpService.addParam(type = 'header', name = 'NotionVersion', value = '#this.notionVersion#');
        
        return function (){
            for (var key in arguments){
                switch(key) {
                    case "method":
                        httpService.setMethod(arguments.method);
                    break;
    
                    case "url":
                        httpService.setURL(this.baseUrl & "/" & arguments.url);
                    break;
    
                    case "body":
                        httpService.addParam(type="body", value = "#serializeJson(arguments.body)#");
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