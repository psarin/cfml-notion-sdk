component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="type" type="string";
    property name="text" cfc="Text";
    property name="annotations" cfc="Annotations";
	property name="plain_text" type="string";
	property name="href" type="string";

	public function init(){
		var values = arguments;
		if (values?.type eq "array"){
			values = values.array[1];
			values.name = arguments.name;
		}

		for (var key in values){
            if (StructKeyExists(values, key) and key neq "datetimeinserted" and key neq "datetimemodified" and key neq "useridmodifying" and key neq "useridinserting"){
				var newVal = values[key];
				if (!isStruct(newVal) and !isArray(newVal) and (newVal eq "''" or newVal eq '""' or newVal eq "" or IsNull(newVal))) {
					newVal = null;
				}
                if (key eq "text" and isStruct(newVal)){
                    this.setValue(values);
                }else if (isDate(newVal)){
                    variables[key] = newVal;
                }else{
                    variables[key] = newVal;
                }
            }
        }
        
		return this;
	}

}