component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */

	property name="database_id" type="string";
	property name="synced_property_name" type="string";
	property name="synced_property_id" type="string";

	property name="to_retrieve" type="boolean" default=true;
	property name="properties_key_name" type="string";
	
	public function init(){
        for (var key in arguments){
            if (StructKeyExists(arguments, key) and key neq "datetimeinserted" and key neq "datetimemodified" and key neq "useridmodifying" and key neq "useridinserting"){
				var newVal = arguments[key];
				if (!isStruct(newVal) and !isArray(newVal) and (newVal eq "''" or newVal eq '""' or newVal eq "" or IsNull(newVal))) {
					newVal = null;
				}
                if (key eq "type"){
                    variables[key] = newVal?:'unknown';
                }else{
					variables[key] = newVal;
				}
            }
        }

        var type = arguments?.type;
        if (!isNull(type)){
            if (type eq "array" && isArray(arguments['array'])){
                this.setArray(arguments['array']);
            }else{
                this.setValue(arguments);
            }
        }
        
		return this;
	}

	public function setValue(property_object){

        var value = null;
        var property_type = property_object.type;
        var property_values = property_object[property_type];
		var property_values_as_array = [];

        // if values of property are structure, just use model
        // otherwise if array, create an array of models 
        if (isStruct(property_values)){
			property_values = property_values.map( (key, value) => {
				value.name = key;
				return value
			});
			property_values = structValueArray(property_values);
			// writeDump(property_type);
			// writeDump(property_values);
        }
		
		if (isArray(property_values)){
			value = this.setArray(property_values);
            // value = property_values.map( (obj) => {
            //     if (isStruct(obj)){
			// 		property_type = obj.type;
			// 		try{
			// 			return createObject("component", "models.#property_type#").init(argumentCollection=obj);
			// 		}catch(any e){
			// 			return createObject("component", "models.Unsupported").init(argumentCollection={
			// 				"#property_type#": property_values                    
			// 			});
			// 		}
            //     }
            // });
        }

        // variables.type = property_type;
        variables.value = value;
        return value;
    }

    public function setArray(array_of_property_object){
        var results = [];
        for (var index=1; index <= arrayLen(array_of_property_object); index++){
			var model;
            var property = array_of_property_object[index];

            var property_id = property?.id;
            var property_name = property?.name;
            var property_type = property?.type;
			var property_values = property[property_type];

			try{
				// writeOutput("tRYING .#property_type#.<BR/>");
				// writeDump(property);
				// model = createObject("component", "models.#property_type#").init(argumentCollection = property);
				try{
					model = createObject("component", "models.#property_type#").init(argumentCollection = {
						name: property_name,
						"type": "array",
						"array": property_values});
				}catch(any e){
	
					try{
						var child_property_type = property_object[property_type]?.type;
						model = createObject("component", "models.#child_property_type#").init(argumentCollection=property_object[property_type][child_property_type]);
					}catch(any e){
						model = createObject("component", "models.Unsupported").init(argumentCollection={
							name: property_name,
							"#property_type#": property_values                    
						});
					}
				}				
				// writeDump(model);
				// writeOutput("tRYING DONE");
			}catch(any e){
                model = createObject("component", "models.Unsupported").init(argumentCollection = {
					id = property_id, 
					type = property_type, 
					name = property_name,
					"#property_type#" = property
				});
            }

			if (!isNull(model)){
				arrayAppend( results, model);
			}
        }

        variables.value = results;
        return results;
    }    

    public function getDisplayText(){
		var properties_key_name = this.getproperties_key_name();
        var value = this.getValue();

		if (!isNull(properties_key_name) && isArray(value)){
			var propertyToUseIndex = value.find( (property) => {
				return property.getName() eq properties_key_name
			});
			value = value[propertyToUseIndex]?.plain_text;
		}
		if (isNull(value)){
			value = this.getID() & ">>>>" & this.getto_retrieve(); 
		}
		return value;
	}
}