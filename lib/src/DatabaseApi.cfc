component DatabaseAPI {

    this.baseUrl = Application.baseUrl;

    function init (required httpService){
        this.httpService = httpService;

        return this;
    }

    public function list() {
        return this.httpService(argumentCollection = {
            message: 'listing the databases',
            method: 'GET',
            url: '#this.baseUrl#/databases'
        });
    }    

    public function retrieve(String database_id) {
        return this.httpService(argumentCollection = {
            message: 'getting the database',
            method: 'GET',
            url: '#this.baseUrl#/databases/#database_id#'
        });
    }    

    public function query(String database_id) {
        return this.httpService(argumentCollection = {
            message: 'querying the database',
            method: 'POST',
            url: '#this.baseUrl#/databases/#database_id#/query',
            body: {page_size: 5}
        });
    }
}
