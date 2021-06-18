component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="id" type="string" fieldtype="id";
	property name="object" type="string";
    property name="name" type="string";
    property name="avatar_url" type="string";
	property name="type" type="string";
	property name="person" type="struct" field-type="one-to-one" cfc="Person";

	

	public function init(){

        for (var key in arguments){
            if (StructKeyExists(arguments, key) and key neq "datetimeinserted" and key neq "datetimemodified" and key neq "useridmodifying" and key neq "useridinserting"){
				var newVal = arguments[key];

				if (isArray(newVal)){
					newVal = arrayToList(newVal);
				}
				if (!isStruct(newVal) and (newVal eq "''" or newVal eq '""' or newVal eq "" or IsNull(newVal))) {
					newVal = null;
				}
                if (isDate(newVal)){
                    variables[key] = newVal;
                }else{
                    variables[key] = newVal;
                }
            }
        }

		return this;
	}

}