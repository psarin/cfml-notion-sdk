component persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="id" type="string" fieldtype="id";
    property name="object" type="string";
    property name="has_more" type="boolean";
    property name="next_cursor" type="string";
    property name="results" type="array" fieldtype="one-to-many";

	public function init(){
        for (var key in arguments){
            if (StructKeyExists(arguments, key) and key neq "datetimeinserted" and key neq "datetimemodified" and key neq "useridmodifying" and key neq "useridinserting"){
				var newVal = arguments[key];

				if (!isStruct(newVal) and !isArray(newVal) and (newVal eq "''" or newVal eq '""' or newVal eq "" or IsNull(newVal))) {
					newVal = null;
				}
                if (key eq "results"){
                    this.setResults(newVal);
                }else if (isDate(newVal)){
                    variables[key] = newVal;
                }else{
                    variables[key] = newVal;
                }
            }
        }
        
		return this;
	}

    public function setResults(results_object){

        var value = [];

        for (var a=1; a <= arrayLen(results_object); a++){
            var result = results_object[a];
            var model = createObject("component", "models.#result.object#").init(argumentCollection = result);
            arrayAppend (value, model);
        }

        variables.results = value;
        return value;
    }    
}