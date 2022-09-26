component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */

	property name="id" type="string" fieldtype="id";

	property name="name" type="string" default="";
	property name="color" type="string";

	property name="options" type="array";

	public function getDisplayHTML(Struct parent){
		var type = parent?.type;
		var classes = this.getColor()?:'';
		var displayText = this.getDisplayText();

		if (!isNull(type)){
			classes = 'notion-' & type & ' ' & classes;
		}

		return '<div class="#classes#">#displayText#</div>';
	}

}