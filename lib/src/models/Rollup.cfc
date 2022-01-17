component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="relation_property_name" type="string";
	property name="relation_property_id" type="string";
	property name="rollup_property_name" type="string";
	property name="rollup_property_id" type="string";
	property name="function" type="string";

	public function init(){
        for (var key in arguments){
            if (StructKeyExists(arguments, key) and key neq "datetimeinserted" and key neq "datetimemodified" and key neq "useridmodifying" and key neq "useridinserting"){
				var newVal = arguments[key];
				if (!isStruct(newVal) and !isArray(newVal) and (newVal eq "''" or newVal eq '""' or newVal eq "" or IsNull(newVal))) {
					newVal = null;
				}
                if (key eq "type"){
                    variables[key] = newVal;
                }
            }
        }

        var type = arguments?.type;
        if (!isNull(type)){
            if (type eq "array"){
                this.setArray(arguments['array']);
            }else{
                // this.setValue(arguments);
            }
        }
        
		return this;
	}
    
    public function setArray(array_of_property_object){
        var results = [];
        for (var index=1; index <= arrayLen(array_of_property_object); index++){
            var property = array_of_property_object[index];

            var property_id = property?.id;
            var property_name = property?.name;
            var property_type = property?.type;

            var model = createObject("component", "models.#property_type#").init(argumentCollection = {
                id = property_id, 
                type = property_type, 
                name = property_name,
                value = property
            });

            arrayAppend( results, model);
        }

        variables.value = results;
        return results;
    }    
}