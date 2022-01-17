component persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="id" type="string" fieldtype="id";
    property name="object" type="string";
    property name="created_time" type="string";
    property name="last_edited_time" type="string";
    property name="title" type="array" fieldtype="one-to-many" cfc="Title";
    property name="properties" type="array" fieldtype="one-to-many";

	public function init(){
        // writeDump(var=arguments)?
        for (var key in arguments){
            if (StructKeyExists(arguments, key) and key neq "datetimeinserted" and key neq "datetimemodified" and key neq "useridmodifying" and key neq "useridinserting"){
				var newVal = arguments[key];

				if (!isStruct(newVal) and !isArray(newVal) and (newVal eq "''" or newVal eq '""' or newVal eq "" or IsNull(newVal))) {
					newVal = null;
				}
                if (key eq "title"){
                    this.setTitle(newVal);
                }else if (key eq "properties"){
                    this.setProperty(newVal);
                }else if (isDate(newVal)){
                    variables[key] = newVal;
                }else{
                    variables[key] = newVal;
                }
            }
        }
        
		return this;
	}

    public function setTitle(property_object){

        var value = [];
        if (!isArray(property_object)){
            property_object = [property_object];
        }
        for (var a=1; a <= arrayLen(property_object); a++){
            arrayAppend(value, new models.Title().init(argumentCollection = property_object[a]));
        }
        variables.title = value;
        return value;
    }

    public function setProperty(property_object){

        var value = [];

        var keys = structKeyArray(property_object);
        for (var key in keys){
            try{
                var property = property_object[key];
                var property_type = property.type;

                for (var subkey in property[property_type]){
                    property[subkey] = property[property_type][subkey];
                }
                property.name = key;
                arrayAppend( value, createObject("component", "models.#property_type#").init(argumentCollection = property));
                if (property_type eq "select"){
                    // writeoutput("MASDE I THERE<BR/>");
                    // writeDump(var=property)
                    // writeDump(var=createObject("component", "models.#property_type#").init(argumentCollection = property));
                    // abort;
                }
            }catch (e){
                arrayAppend( value, createObject("component", "models.Unsupported").init(argumentCollection = property));   
                // writeDump(var=e.message);
                // writeDump(property);
                // writeDump(property_type);
            }
        }

        variables.properties = value;
        return value;
    }    
}