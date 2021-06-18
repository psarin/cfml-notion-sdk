component persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="id" type="string" fieldtype="id";
    property name="object" type="string";
    property name="created_time" type="string";
    property name="last_edited_time" type="string";
    property name="archived" type="boolean";
    // property name="title" type="array" fieldtype="one-to-many" cfc="Title";
    property name="parent" type="struct" fieldtype="one-to-one" cfc="Parent";
    property name="properties" type="array" fieldtype="one-to-many";

	public function init(){
        for (var key in arguments){
            if (StructKeyExists(arguments, key) and key neq "datetimeinserted" and key neq "datetimemodified" and key neq "useridmodifying" and key neq "useridinserting"){
				var newVal = arguments[key];

				if (!isStruct(newVal) and !isArray(newVal) and (newVal eq "''" or newVal eq '""' or newVal eq "" or IsNull(newVal))) {
					newVal = null;
				}
                if (key eq "parent"){
                    this.setParent(newVal);
                }else if (key eq "properties"){
                    this.setProperties(newVal);
                }else if (isDate(newVal)){
                    variables[key] = newVal;
                }else{
                    variables[key] = newVal;
                }
            }
        }
        
		return this;
	}

    public function setParent(parent_object){

        variables.parent = new models.Parent().init(argumentCollection = parent_object);
        return variables.parent;
    }

    public function setProperties(property_object){

        var value = [];

        var keys = structKeyArray(property_object);
        for (var property_name in keys){
            var property = property_object[property_name];

            var property_id = property.id;
            var property_type = property.type;

            var model = new models.BaseObject().init(argumentCollection = {
                id = property_id, 
                type = property_type, 
                name = property_name,
                value = property
            });


            arrayAppend( value, model);
        }

        variables.properties = value;
        return value;
    }    
}