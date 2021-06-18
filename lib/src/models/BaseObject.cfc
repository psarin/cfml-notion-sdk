component persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="id" type="string" fieldtype="id";
    property name="name" type="string";
    property name="type" type="string";
    property name="value" type="any";

	public function init(){
        for (var key in arguments){
            if (StructKeyExists(arguments, key) and key neq "datetimeinserted" and key neq "datetimemodified" and key neq "useridmodifying" and key neq "useridinserting"){
				var newVal = arguments[key];

				if (!isStruct(newVal) and !isArray(newVal) and (newVal eq "''" or newVal eq '""' or newVal eq "" or IsNull(newVal))) {
					newVal = null;
				}
                if (key eq "value" and isStruct(newVal)){
                    this.setValue(newVal);
                }else if (isDate(newVal)){
                    variables[key] = newVal;
                }else{
                    variables[key] = newVal;
                }
            }
        }
        
		return this;
	}
    public function setValue(property_object){

        var value = null;
        var property_type = property_object.type;
        var property_values = property_object[property_type];

        // if values of property are structure, just use model
        // otherwise if array, create an array of models 
        if (isStruct(property_values)){
            value = createObject("component", "models.#property_type#").init(argumentCollection = property_values);

        }else if (isArray(property_values) && !arrayIsEmpty(property_values)){
            value = property_values.map( (obj) => {
                if (isStruct(obj)){
                    return createObject("component", "models.#property_type#").init(argumentCollection=obj);
                }
            })     
        }else if (!isStruct(property_values) && !isArray(property_values)){
            value = createObject("component", "models.#property_type#").init(argumentCollection = {
                "#property_type#": property_values
            });
        }

        variables.value = value;
        return value;
    }

    public function getDisplayText(){
        var value = this.getValue();

        if (isNull(value)){
            return
        }

        if ((this.getType() == "rich_text" || this.getType() == "files") && isArray(value) && !arrayIsEmpty(value)){
            value = value[1];
            if (!isNull(value.getPlain_text)){
                return value.getPlain_Text();
            }else if (!isNull(value.getName)){
                return value.getName();
            }
        }
        else if (this.getType() == "url" && !isArray(value)){
            return value.getURL();
        }
        else if (this.getType()=="title" && !isNull(value) && isArray(value) && !arrayIsEmpty(value)){
            value = value[1];
            if (!isNull(value.getPlain_text)){
                return value.getPlain_Text();
            }    
        }else if (!isArray(value) && !isNull(value.getText)){
            return value.getText();
        }else if (!isArray(value) && !isNull(value.getName)){
            return value.getName();
        }
 
        return;
    }
}