component UserAPI {

    this.baseUrl = Application.baseUrl;

    function init (required httpService){
        this.httpService = httpService;

        return this;
    }

    public function retrieve(String user_id) {
        return this.httpService(argumentCollection = {
            message: 'getting the user',
            method: 'GET',
            url: '#this.baseUrl#/users/#user_id#'
        });
    }

    public function list() {
        return this.httpService(argumentCollection = {
            message: 'listing the users',
            method: 'GET',
            url: '#this.baseUrl#/users',
        }); 
    }
}
