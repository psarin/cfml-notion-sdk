component name="Results" {

    function init (
      String object = 'list',
      Array blocks = [],
      Array page = [],
      String nextCursor = '',
      Boolean hasMore = false
    ){
        this.object = object;
        this.blocks = blocks;
        this.page = page;
        this.nextCursor = nextCursor;
        this.hasMore = hasMore;
  
        return this;
    }
    
    public function fromJson(String json) {
      json = deserializeJSON(json);

      this.object = json['object'];
      if (json['results'] != null) {
        json['results'].forEach((v) {
          if (v['object'] == 'block') {
            blocks!.add(Block.fromJson(v));
          }
          if (v['object'] == 'page') {
            page!.add(Page.fromJson(v));
          }
        });
      }
      this.nextCursor = json['next_cursor'];
      this.hasMore = json['has_more'];
    }
  
    public function toJson() {
      var data = {};
      data['object'] = this.object;
      if (this.blocks != null) {
        data['block'] = this.blocks!.map((v) => v.toJson()).toList();
      }
      data['next_cursor'] = this.nextCursor;
      data['has_more'] = this.hasMore;
      return serializeJdata;
    }
  }
  