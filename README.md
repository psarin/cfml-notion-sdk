<!-- markdownlint-disable -->
<div align="center">
    <h1>Notion SDK for CFML</h1>
    <p>
        <b>A CFML implemention for the <a href="https://developers.notion.com">Notion SDK</a></b>
    </p>
</div>
<!-- markdownlint-enable -->

This library is a **WIP** inspired by the official [JavaScript SDK](https://github.com/makenotion/notion-sdk-js) and the [Dart implementation](https://github.com/jpinz/notion_dart_api). We adhere to the API usage patterns of the JavaScript SDK wherever possible. The instructions below have been copied & modified from the JavaScript SDK [README.md](https://github.com/makenotion/notion-sdk-js/blob/main/README.md).

> This library is in beta, please report on
> [GitHub Issues](https://github.com/psarin/cfml-notion-sdk/issues) any issues
> you come across.

<!-- markdownlint-disable -->
## Usage

> Before getting started, [create an integration](https://www.notion.com/my-integrations) and find the token.
>
> [→ Learn more about authorization](https://developers.notion.com/docs/authorization).

### Initialization

Import and initialize a client using an **integration token** or an OAuth **access token**. The token can be imported from an Application / Session variable, the database, or an [environment variable](https://docs.lucee.org/guides/Various/system-properties.html) and best practice states it should **not** be hardcoded into the source code.

This library utilizes two config files that you can place in the `config/` directory. The first is `settings.json` to hold your Notion API settings and authorization, and the second is `databases.json` to hold mappings to databases & pages you may want to access in  your code. See the `examples/config/` folder for samples.

```js
// Best to import token from Application variable, database, or environment variable.
// See /examples/simple.cfm folder for examples how to use via Application variable.
var NOTION_TOKEN = 'secret_token';

// Initializing a client
var notion = new lib.NotionClient (auth: NOTION_TOKEN);
```

### Making requests

> See the complete list of endpoints in the [API reference](https://developers.notion.com/reference).

```js
// Request a list of users in workspace
var listUsersResponse = notion.users.list();

// Look at response
dump(listUsersResponse);
```

Each method returns the response as per Notion API specification.

<pre>
{
  results: [
    {
      object: 'user',
      id: 'd40e767c-d7af-4b18-a86d-55c61f1e39a4',
      type: 'person',
      person: {
        email: 'avo@example.org',
      },
      name: 'Avocado Lovelace',
      avatar_url: 'https://secure.notion-static.com/e6a352a8-8381-44d0-a1dc-9ed80e62b53d.jpg',
    },
    ...
  ]
}
</pre>

#### Endpoint parameters (e.g., filters, pagination)
Endpoint parameters for requests are grouped into a single object. You don't need to remember which parameters go in the path, query, or body as the library will take care of this for you.

```js
const myPage = notion.databases.query({
  database_id: "897e5a76-ae52-4b48-9fdf-e71f5945d1af",
  filter: {
    property: "Landmark",
    text: {
      contains: "Bridge",
    },
  },
})
```

### Displaying data retrieved from Notion

Data retrieved via the API can be converted to plain text or HTML easily by instantiating the blocks using the model representing the block. The library will attempt to transverse the block tree in order to convert all child blocks to their most appropriate representation.

### Sending data to Notion

Currently, the best way to add or edit objects in Notion is by manually constructing the PUT/PATCH/POST object specified in the Notion API and then using the library's BlockApi/PageApi/DatabaseApi/UserApi to send the data to Notion. The library does not convert your object to the schema required by Notion.

### Handling errors

If the API returns an unsuccessful response, the returned response returns a simple error and the HTTP error response from server.

TODO / NOT IMPLEMENTED: This library needs to better deal with error responses.

<pre style="font-size:10px;">
The error contains properties from the response, and the most helpful is `code`. You can compare `code` to the values in the `APIErrorCode` object to avoid misspelling error codes.

</pre>

## Configuration
### Client options

The `NotionClient` supports the following options on initialization. These options are all keys in the single constructor parameter.

| Option      | Default value              | Type         | Description                                                                                                                                                  |
| ----------- | -------------------------- | ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `auth`      | `undefined`                | `string`     | Bearer token for authentication. If left undefined, the `auth` parameter should be set on each request.                                                      |                                                                       |
| `baseUrl`   | `"https://api.notion.com"` | `string`     | The root URL for sending API requests. This can be changed to test with a mock server.                                                                       |

## Requirements

This package supports the following minimum versions:

- Runtime: `lucee >= 4.5 | acf >= 11`

Testing has been done on the [Lucee CFML engine](https://lucee.org).

## Getting help

If you have a question about the library, or are having difficulty using it, chat with the community in [Lucee Dev Forums](https://dev.lucee.org).

If you're experiencing issues with the Notion API, such as a service interruption or a potential bug in the platform, reach out to [Notion help](https://www.notion.com/Help-Support-e040febf70a94950b8620e6f00005004?target=intercom).