component DatabaseAPI {

    function init (required httpService){
        this.httpService = arguments.httpService;

        return this;
    }

    public function list() {
        return this.httpService(argumentCollection = {
            message: 'listing the databases',
            method: 'GET',
            url: '/databases'
        });
    }    

    public function retrieve(String database_id) {
        return this.httpService(argumentCollection = {
            message: 'getting the database',
            method: 'GET',
            url: '/databases/#arguments.database_id#'
        });
    }    

    public function query(String database_id, numeric page_size = 10, String start_cursor, Array sorts = [], Struct filter) {

        return this.httpService(argumentCollection = {
            message: 'querying the database',
            method: 'POST',
            url: '/databases/#arguments.database_id#/query',
            body: {
                page_size: arguments.page_size
            }
        });
    }
}
