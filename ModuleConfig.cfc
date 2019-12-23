/**
* Matt Gifford, Monkeh Works
* https://www.monkehworks.com
* ---
* This module introduces PicPurify, a CFML wrapper to interact with the PicPurify content moderation API, to your ColdBox application.
**/
component {

	// Module Properties
	this.title 				= "PicPurify";
	this.author 			= "Matt Gifford";
	this.webURL 			= "https://www.monkehworks.com";
	this.description 		= "A CFML wrapper to interact with the PicPurify content moderation API";
	this.version			= "@version.number@+@build.number@";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= false;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = false;
	this.modelNamespace		= 'picpurify';
	this.cfmapping			= 'picpurify';
	this.autoMapModels 		= true;

	/**
	 * Configure
	 */
	function configure(){
        // Settings
        settings = {
            apiKey = ''
        }
    }

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
        parseParentSettings();
        var picPurifySettings = controller.getConfigSettings().picpurify;
		// Map Library
        binder.map( "picpurify@picpurify" )
            .initArg( name="apiKey", value=picPurifySettings.apiKey );
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
    function onUnload(){}
    
    /**
	* parse parent settings
	*/
	private function parseParentSettings(){
		var oConfig      = controller.getSetting( "ColdBoxConfig" );
		var configStruct = controller.getConfigSettings();
		var picPurifyDSL = oConfig.getPropertyMixin( "picpurify", "variables", structnew() );

		//defaults
		configStruct.picpurify = variables.settings;

		// incorporate settings
		structAppend( configStruct.picpurify, picPurifyDSL, true );
	}

}