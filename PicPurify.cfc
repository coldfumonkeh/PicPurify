/**
 * Name: PicPurify.cfc
 * Author: Matt Gifford (matt@monkehworks.com)
 * Purpose: A CFML wrapper for the PicPurify content moderation API.
 */
component accessors="true" {

    property name="APIKey" type="string" default="";
    property name="APIBaseURI" type="string" default="";

    /**
     * Constructor method
     *
     * @APIKey The API key
     */
    public PicPurify function init(
        required string APIKey,
        required string apiBaseURI = 'https://www.picpurify.com/'
    ){
        setAPIKey( arguments.APIKey );
        setAPIBaseURI( arguments.apiBaseURI );
        return this;
    }

    /**
     * Returns a boolean value on whether or not the API response is NSFW (Not Safe For Work).
     *
     * @apiResponse The CFML struct response from the API equest.
     */
    public boolean function isNSFW(
        required struct apiResponse
    ){
        return ( apiResponse[ 'final_decision' ] EQ 'KO' ) ? true : false;
    }

    /**
     * Analyses the given image (local file or URL) for content moderation
     * Image formats: JPG / JPEG, PNG, BMP, TIFF, RAW, PDF, ICO, GIF
     * GIF Support (for animated GIF, only the first frame will be processed)
     * Max image size: 4096*4096 | 16 MB
     * 
     * @task A task name (or a list of tasks separated by comma). Moderation tasks: porn_moderation suggestive_nudity_moderation gore_moderation money_moderation weapon_moderation drug_moderation hate_sign_moderation obscene_gesture_moderation qr_code_moderation. Detection tasks: face_detection face_age_detection face_gender_detection face_gender_age_detection
     * @file_image Path to the image in your local file system
     * @url_image URL of the image publicly accessible from internet. Only for tests, can increase latency
     * @reference_id Optional A unique reference associated to the image in your information system
     * @origin_id Optional A reference to retrieve the origin of the image, profile id, account id ...
     * @asStruct Boolean value whether or not to return the API response as a CFML struct. Defaults to true.
     */
    public function analysePicture(
        required string task,
        string file_image,
        string url_image,
        string reference_id,
        string origin_id,
        boolean asStruct = true
    ){
        var arrParams = buildParamArray( argScope = arguments );
        var apiResponse = makeRequest(
            endpoint = 'analyse/1.1',
            params   = arrParams
        );
        return ( arguments.asStruct ) ? deserializeJSON( apiResponse.fileContent ) : apiResponse.fileContent;
    }

    /**
     * Analyses the given video (local file or URL) for content moderation
     * 
     * @task A task name (or a list of tasks separated by comma). Moderation tasks: porn_moderation suggestive_nudity_moderation gore_moderation money_moderation weapon_moderation drug_moderation hate_sign_moderation obscene_gesture_moderation qr_code_moderation. Detection tasks: face_detection face_age_detection face_gender_detection face_gender_age_detection
     * @file_video PPath to the video in your local file system
     * @url_video URL of the video publicly accessible from internet. Only for tests, can increase latency
     * @frame_interval Decimal	Interval in seconds between the analyzed images. The default value is 1, which means that one frame every second will be analyzed. Values less than 1 can be used. For example 0.1 means an image every 100 ms
     * @reference_id Optional A unique reference associated to the image in your information system
     * @origin_id Optional A reference to retrieve the origin of the image, profile id, account id ...
     * @asStruct Boolean value whether or not to return the API response as a CFML struct. Defaults to true.
     */
    public function analyseVideo(
        required string task,
        string file_video,
        string url_video,
        string frame_interval = 1,
        string reference_id,
        string origin_id,
        boolean asStruct = true
    ){
        var arrParams = buildParamArray( argScope = arguments );
        var apiResponse = makeRequest(
            endpoint = 'analyse_video.php',
            params   = arrParams
        );
        return ( arguments.asStruct ) ? deserializeJSON( apiResponse.fileContent ) : apiResponse.fileContent;
    }

    private function makeRequest(
        required string endpoint,
        required array params
    ){
        cfhttp( url="#getAPIBaseURI()##arguments.endpoint#", method='POST', result="apiResult" ){
            cfhttpparam( type="formfield", name="API_KEY", value="#getAPIKey()#" );
            for( item in arguments.params ){
                cfhttpparam( type="formfield", name="#item[ 'name' ]#", value="#item[ 'value' ]#" );
            }
        }
        return apiResult;
    }

    /**
     * I loop through a struct to convert to query params for the URL
     * Returns an array of name / value pairs to use when building the request params
     * 
     * @argScope The struct containing arguments to send to the request
     */
    private array function buildParamArray(
        required struct argScope
    ){
        var arrParams = [];
        var stuParams = arguments.argScope;
        for( key in stuParams ){
            if( len( stuParams[ key ] ) ){
                arrayAppend( arrParams, {
                    'name': key,
                    'value': stuParams[ key ]
                }, true );
            }
        }
        return arrParams;
    }

}