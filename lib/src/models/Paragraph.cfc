component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
    property name="text" type="array";


	// public function init(){
    //     for (var key in arguments){
    //         if (StructKeyExists(arguments, key) and key neq "datetimeinserted" and key neq "datetimemodified" and key neq "useridmodifying" and key neq "useridinserting"){
	// 			var newVal = arguments[key];

	// 			if (!isStruct(newVal) and !isArray(newVal) and (newVal eq "''" or newVal eq '""' or newVal eq "" or IsNull(newVal))) {
	// 				newVal = null;
	// 			}
    //             if (key eq "value" and isStruct(newVal)){
    //                 this.setValue(newVal);
    //             }else if (key eq "text" and isArray(newVal)){
    //                 this.setResults(newVal);
    //             }else if (isDate(newVal)){
    //                 variables[key] = newVal;
    //             }else{
    //                 variables[key] = newVal;
    //             }
    //         }
    //     }
        
	// 	return this;
	// }

    
    // public function setResults(results_object){

    //     var value = [];

    //     for (var a=1; a <= arrayLen(results_object); a++){
	// 		try{
	// 			var result = results_object[a];
	// 			var model = createObject("component", "models.#result.type#").init(argumentCollection = result);
	// 			arrayAppend (value, model);	
	// 		}catch (e){
	// 			// writeDump(var=e);
	// 		}
    //     }

    //     variables.value = value;
    //     return value;
    // }	
}