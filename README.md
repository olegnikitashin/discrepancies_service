# DiscrepanciesService
## Assumptions
* For the sake of simplicity no db has been used, local data is loaded from `.json` file 
* The service uses mocked external API to get campaigns

## Expected output
### Discrepancies present:

```ruby
[
  {
    "remote_reference": "1",
    "discrepancies": [
      "status": {
        "remote": "enabled",
        "local": "disabled"
      },
      "description": {
        "remote": "Description new",
        "local": "Description old"
      }
    ]
  }
]
```
### No discrepancies:
```ruby
[]
```

## App setup
Build containers:

`docker-compose build`

## Run tests
`docker-compose run --rm web rspec`
