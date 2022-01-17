component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */

	property name="object" type="string";
	// property name="id" type="string" fieldtype="id";

    property name="created_time" type="date" ormtype="timestamp" sqltype="timestamp with time zone";
    property name="last_edited_time" type="date" ormtype="timestamp" sqltype="timestamp with time zone";

    property name="has_children" type="boolean" default="false";


	public function init(){
        for (var key in arguments){
            if (StructKeyExists(arguments, key) and key neq "datetimeinserted" and key neq "datetimemodified" and key neq "useridmodifying" and key neq "useridinserting"){
				var newVal = arguments[key];

				if (!isStruct(newVal) and !isArray(newVal) and (newVal eq "''" or newVal eq '""' or newVal eq "" or IsNull(newVal))) {
					newVal = null;
				}
                if (key eq "type"){
                    this.setValue(newVal, arguments["#newVal#"]);
                }else if (isDate(newVal)){
                    variables[key] = newVal;
                }else{
                    variables[key] = newVal;
                }
            }
        }
        
		return this;
	}

    public function setValue(block_type, block){

        var value = [];

		try{
			var model = createObject("component", "models.#block_type#").init(argumentCollection = block);
			model.setType(block_type);
			variables.value = model;	
		}catch (e){
			writeOutput("<HR/><h1>Error in Block.cfc</h1>");
			writeOutput("<p>#e.message#</p>");
			writedump(var=block_type);	
			writedump(var=block);
			writeOutput("<HR/>");                
		}


		// if (!isNull(block.text)){
		// 	for (var notion_object in block.text){
		// 		var model = createObject("component", "models.#notion_object.type#").init(argumentCollection = notion_object);
		// 		arrayAppend( value, model);
		// 	}

		// }
		// variables.value = value;
        return value;
    }  

}