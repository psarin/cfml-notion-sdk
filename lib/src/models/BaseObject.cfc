component displayName="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
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
                }else if (key eq "results" and isArray(newVal)){
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
    
    public function setValue(property_object){

        var value = null;
        var property_type = property_object.type;
        var property_values = property_object[property_type];

        // if values of property are structure, just use model
        // otherwise if array, create an array of models 
        if (isStruct(property_values)){
            value = createObject("component", "models.#property_type#").init(argumentCollection = property_values);

        }else if (isArray(property_values)){
            value = property_values.map( (obj) => {
                if (isStruct(obj)){
                    return createObject("component", "models.#property_type#").init(argumentCollection=obj);
                }
            })     
        }else if (!isArray(property_values) && !isStruct(property_values)){
            value = createObject("component", "models.#property_type#").init(argumentCollection = {
                "#property_type#": property_values
            });
        }

        variables.value = value;
        return value;
    }

    // Master getDisplayText
    // Needs to account for all values of type array since arrays won't have getDisplayText
    public function getDisplayText(){
        var value = this.getValue();
        
        if (isNull(value)){
            if (!isNull(this.getText)){
                return this.getText()?:"";
            }else if (!isNull(this.getName)){
                return this.getName()?:"";
            }else if (!isNull(this.getString)){
                return this.getString()?:"";
            }
            return
        }

        // if value object has a preferred display text, use that
        if (!isNull(value.getDisplayText)){
            return value.getDisplayText();
        }

        // otherwise, do generic processing here to determine best display text
        if ((this.getType() == "rich_text" || this.getType() == "files") && isArray(value)){
            if (arrayIsEmpty(value)){
                return "";
            }
            value = value[1];
            if (!isNull(value.getPlain_text)){
                return value.getPlain_Text();
            }else if (!isNull(value.getName)){
                return value.getName();
            }
        }
        else if (this.getType()=="title" && !isNull(value) && isArray(value) && !arrayIsEmpty(value)){
            value = value[1];
            if (!isNull(value.getPlain_text)){
                return value.getPlain_Text();
            }    
        }else if (this.getType() == "people" && isArray(value)){
            return arrayToList(value.map((obj) => obj.getName()).filter((obj) => !isNull(obj)), "; ");
        }else if (this.getType() == "multi_select" && isArray(value)){
            return arrayToList(value.map((obj) => obj.getName()).filter((obj) => !isNull(obj)), "; ");
        }else if (this.getType() == "relation" && isArray(value)){
            return arrayToList(value.map((obj) => obj.getDisplayText()).filter((obj) => !isNull(obj)), "; ");
        }
 
        return;
    }
}