component BlockAPI {

    function init (required httpService){
        this.httpService = httpService;

        return this;
    }

    public function retrieve(String block_id) {
        return this.httpService(argumentCollection = {
            message: 'getting the block',
            method: 'GET',
            url: '/blocks/#block_id#/children'
        });
    }

    public function appendBlock(String block_id, Struct child = {}) {
        return this.httpService(argumentCollection = {
            message: 'appending a block',
            method: 'PATCH',
            body: {
                'children': [child]
            },
            url: '/blocks/#block_id#/children'
        });
    }
    
    public function append(String block_id, array children = []) {
        return this.httpService(argumentCollection = {
            message: 'appending blocks',
            method: 'PATCH',
            body: {
                'children': children
            },
            url: '/blocks/#block_id#/children'
        });
    }

}
