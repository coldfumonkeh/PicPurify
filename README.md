[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/available-on-forgebox.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/compatibility-lucee-45.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/compatibility-lucee-5.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/compatibility-coldfusion-2018.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/uses-cfml.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/built-with-love.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/kinda-sfw.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/pretty-risque.svg)](https://cfmlbadges.monkehworks.com)

# PicPurify

A CFML wrapper to interact with the PicPurify content moderation API.

## Installation

This component can be installed as standalone or as a ColdBox Module. Either approach requires a simple CommandBox command:

```js
box install picpurify
```

### ColdBox Module
This package is also a ColdBox module. The module can be configured by creating a `picpurify` configuration structure in your application configuration file (`config/Coldbox.cfc`) with the following settings:

```js
picpurify = {
     apiKey = '<YOUR_API_KEY_GOES_HERE>' // Your PicPurify API Key
};
```

Then you can inject the CFC via Wirebox:

```js
property name="picpurify" inject="picpurify@picpurify";
```

## Usage

Instantiate the component:
```js
picpurify = new picpurify( APIKey = '<YOUR_API_KEY_GOES_HERE>' );
```
### picpurify.analysePicture()

Returns a CFML struct from the API response
```js
var stuResponse = picpurify.analysePicture(
    task      = 'porn_moderation,suggestive_nudity_moderation',
    url_image = '<REMOTE URL FOR IMAGE FILE>'
);
```

### picpurify.analysePicture()

Returns a CFML struct from the API response
```js
var stuResponse = picpurify.analyseVideo(
    task      = 'porn_moderation,suggestive_nudity_moderation',
    url_video = '<REMOTE URL FOR VIDEO FILE>'
);
```

### picpurify.isNSFW(text)

`isNFSW()` is a helper mathod added to this component.

Pass in the CFML struct response from the API request.

Returns a boolean for whether or not the image / video is NSFW (Not Safe For Work)
```js
var isNSFW = picpurify.isNSFW(
    apiResponse = stuResponse
);
```

## Acknowledgements

`PicPurify` is based on the official [PicPurify API](https://www.picpurify.com/api-services.html).
