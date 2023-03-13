# flutter_gql_spacex

Flutter web app to display SpaceX upcoming launches using a GraphQL API

API endpoint: [https://main--spacex-l4uc6p.apollographos.net/graphql](https://main--spacex-l4uc6p.apollographos.net/graphql)

API documentation: [https://docs.spacexdata.com/#e001c501-9c09-4703-9e29-f91fbbf8db7c](https://docs.spacexdata.com/#e001c501-9c09-4703-9e29-f91fbbf8db7c)

#### GraphQL query for useful data in this API

```json
{
  "mission_name": "FalconSat",
  "launch_date_local": "2006-03-25T10:30:00+12:00",
  "rocket": {
    "rocket_name": "Falcon 1"
  },
  "details": "Engine failure at 33 seconds and loss of vehicle",
  "links": {
    "mission_patch": null,
    "mission_patch_small": null
  }
}
```

- In this we are only getting mission_name, launch_date_local, rocket_name and details, rest all are always null, so just querying these 4 values and using them in UI.

- This query supports pagination (using limit and offset) but it's implementation is quite broken, which results in inconsistent results, so instead of that I implemented pagination on client side.

- I am fetching all data from the API and displaying 20 items per page, details text can be large so created a popup to show complete details of a launch, while the page shows truncated text.

- This is responsive for some common device breakpoints.

### Demo

<img width="1440" alt="Desktop page" src="https://user-images.githubusercontent.com/77770628/224601051-94b37cce-1990-4b80-b839-a4c8c4ebe14f.png">

<img width="1440" alt="Full details in popup desktop" src="https://user-images.githubusercontent.com/77770628/224601056-dd469bbf-e439-4f98-9a63-3854fd79a88f.png">

<img width="1440" alt="Desktop last page" src="https://user-images.githubusercontent.com/77770628/224601061-02f96909-6c4a-46cd-b8c4-1c78d457edd4.png">

<img width="749" alt="Tablet page" src="https://user-images.githubusercontent.com/77770628/224601062-aa5173a2-8fbe-405e-a117-ca6bd05939fa.png">

<img width="749" alt="Mobile page" src="https://user-images.githubusercontent.com/77770628/224601064-d9b19021-932d-4c43-aff2-dd238a3f0802.png">

<img width="749" alt="Full details in popup mobile" src="https://user-images.githubusercontent.com/77770628/224601066-be20ce21-3f85-42ae-803e-1b6a63cb3dc2.png">

Pagination buttons are horizontally scrollable

<img width="749" alt="Mobile last page" src="https://user-images.githubusercontent.com/77770628/224601068-519b801b-acd3-48ef-baa8-1a37e5c14380.png">
