component SearchAPI {

    this.baseUrl = Application.baseUrl;

    function init (required httpService){
        this.httpService = httpService;

        return this;
    }

    public function search(
        String query,
        Struct sort,
        Struct filter,
        String start_cursor,
        Numeric page_size
    ) {
        return this.httpService(argumentCollection = {
            message: 'performing search',
            method: 'POST',
            url: '#this.baseUrl#/search',
            body: arguments
        });
    }
}
