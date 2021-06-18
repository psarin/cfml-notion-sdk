component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */

	property name="start" type="date";
	property name="end" type="date";

    

	public function init(){

        for (var key in arguments){
            if (StructKeyExists(arguments, key) and key neq "datetimeinserted" and key neq "datetimemodified" and key neq "useridmodifying" and key neq "useridinserting"){
				var newVal = arguments[key];

				if (isArray(newVal)){
					newVal = arrayToList(newVal);
				}
				if (not isStruct(newVal) and (newVal eq "''" or newVal eq '""' or newVal eq "" or IsNull(newVal))) {
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

    public function getText(){
        if (!isNull(this.getStart)){
            return this.getStart();
        }
    }
}