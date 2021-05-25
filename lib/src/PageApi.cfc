component PageAPI {

    function init (required httpService){
        this.httpService = httpService;

        return this;
    }

    public function retrieve(String page_id) {
        return this.httpService(argumentCollection = {
            message: 'getting the page',
            method: 'GET',
            url: '/pages/#page_id#'
        });
    }

    public function create(Struct page) {
        if (!isNull(page) and !isNull(page.parent) and !isNull(page.properties) ){
            return this.httpService(argumentCollection = {
                message: 'creating the page',
                method: 'POST',
                url: '/pages',
                body: page
            });    
        }
        return;
    }

    public function update(String page_id, Struct properties) {    
        if (!isNull(page) and !isNull(page.parent) and !isNull(page.properties) ){
            return this.httpService(argumentCollection = {
                message: 'updating the page',
                method: 'PATCH',
                url: '/pages/#page_id#',
                body: properties
            });    
        }
        return;
    }
}
