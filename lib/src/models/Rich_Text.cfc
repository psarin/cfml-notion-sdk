component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="type" type="string";
    // property name="text" cfc="Text";
    property name="annotations" cfc="Annotations";
	property name="plain_text" type="string";
	property name="href" type="string";	

    // public function getText(){
    //     var value = this.getValue();

    //     if (!isNull(value) && isArray(value) && !arrayIsEmpty(value)){
    //         value = value[1];
    //         if (!isNull(value.getPlain_text)){
    //             return value.getPlain_Text();
    //         }else{
    //             return "NOTHING";
    //         }
    
    //     }
    // }
}