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
        // writeoutput("TRYING")
        // writeDump(property_object)
        var property_type = property_object.type;
        var property_values = property_object[property_type];

        // if values of property are structure, just use model
        // otherwise if array, create an array of models 
        if (isStruct(property_values)){
            try{
                value = createObject("component", "models.#property_type#").init(argumentCollection = property_values);
            }catch(any e){

                try{
                    var child_property_type = property_object[property_type]?.type;
                    value = createObject("component", "models.#child_property_type#").init(argumentCollection=property_object[property_type][child_property_type]);
                }catch(any e){
                    value = createObject("component", "models.Unsupported").init(argumentCollection={
                        "#property_type#": property_values                    
                    });
                }
            }

        }else if (isArray(property_values)){
            value = property_values.map( (obj) => {
                if (isStruct(obj)){
                    // if (!isNull(obj.type)){
                    //     writeoutput("OBJECT TYPE IS #property_type#, #obj.type#<BR/>");
                    // }
                    var obj_type =  property_type;//!isNull(obj.type)?obj.type:property_type;        
                    return createObject("component", "models.#obj_type#").init(argumentCollection=obj);
                }
            });
        }else if (!isArray(property_values) && !isStruct(property_values)){
            try{
                value = createObject("component", "models.#property_type#").init(argumentCollection = {
                    "#property_type#": property_values
                });
            }catch(any e){
                return createObject("component", "models.Unsupported").init(argumentCollection={
                    "#property_type#": property_values                    
                });
            }
        }

        variables.type = property_type;
        variables.value = value;
        return value;
    }

    // Master getDisplayText
    // Needs to account for all values of type array since arrays won't have getDisplayText
    public function getDisplayText(){
        var type = this.getType();
        var value = this.getValue();
        var displayText;
        
        if (isNull(value)){
            if (!isNull(this.getText)){
                displayText = this.getText()?:"";
            }else if (!isNull(this.getName)){
                if (!isNull(type)){
                    displayText = ((this.getName()?:"") & " is unsupported type " & type);
                }else{
                    displayText = this.getName();
                }
            }else if (!isNull(this.getString)){
                displayText = this.getString()?:"";
            }

            return displayText;
        }

        // if value object has a preferred display text, use that
        if (!isNull(value.getDisplayText)){
            displayText = value.getDisplayText();
        }

        // otherwise, do generic processing here to determine best display text
        switch(type){
            case 'rich_text':
            case 'files':
                if(isArray(value)){
                    displayText = "";
                    if (!arrayIsEmpty(value)){
                        value = value[1];
                        if (!isNull(value.getPlain_text)){
                            displayText = value.getPlain_Text();
                        }else if (!isNull(value.getName)){
                            displayText = value.getName();
                        }
                    }
                }
                break;

            case 'title':
                if (!isNull(value) && isArray(value) && !arrayIsEmpty(value)){
                    value = value[1];
                    if (!isNull(value.getPlain_text)){
                        displayText = value.getPlain_Text();
                    }
                }
                break;
            case 'people':
            case 'multi_select':
                if(isArray(value)){
                    displayText = arrayToList(value.map((obj) => obj.getName()).filter((obj) => !isNull(obj) && obj!=""), "; ");
                    displayText = listRemoveDuplicates(displayText, ';');
                }
                break;
            case 'relation':
            case 'array':
                if(isArray(value)){
                    displayText = arrayToList(value.map((obj) => obj.getDisplayText()).filter((obj) => !isNull(obj) && !isArray(obj) && obj!=""), "; ");
                    displayText = listRemoveDuplicates(displayText, ';');
                }
                break;
            case 'unsupported':
                displayText = "unsupported";
                break;
            default:
                break;
        }
 
        return displayText;
    }

    public function getDisplayHTML(){
        var type = this.getType();
        var value = this.getValue();
        var displayHTML;
        
        // If value is null, means we have no more children to examine
        if (isNull(value)){
            if (!isNull(this.getText)){
                displayHTML = (this.getText()?:"");
            }else if (!isNull(this.getName)){
                if (!isNull(type)){
                    displayHTML = ((this.getName()?:"") & " is unsupported type " & type);
                }else{
                    displayHTML = this.getName();
                }
            }else if (!isNull(this.getString)){
                displayHTML = this.getString()?:"";
            }

            if (isNull(displayHTML) or not compareNoCase(displayHTML, '')){
                return this.getDisplayText();
            }
        
            return '<span>#displayHTML#</span>';
        }

        // if value object has a preferred display text, use that
        if (!isNull(value.getDisplayHTML)){
            return value.getDisplayHTML(this);
        }

        return '<span>#displayHTML#</span>';
    }
}