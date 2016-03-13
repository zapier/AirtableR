# AirtableR
R wrapper to the Airtable API 

For more information on the Airtable API see: http://api.airtable.com/

## Quick Start

### Installation
```r
> devtools::install_github("jsng/AirtableR")
> library(AirtableR)
```

### Authentication
Firstly, you should enter your Airtable API key.
```r
> airtable <- Airtable(
    base = "<YOUR BASE NAME>", # e.g "appZNrwXN7bsOU0ta"
    tables = c("archive", "items") # table names
  )
```
```r
Couldn't find env var AIRTABLE_KEY. See ?airtable_key for more details.
Please enter your KEY and press enter:
```

You can also set Airtable API Key in `.Renviron` file.
```r
AIRTABLE_KEY=<YOUR API KEY HERE>
```

## Basic Usage
### List all Records
```r
> records <- airtable$archive$list_records()
```

```r
> str(records)

List of 363
 $ :List of 3
  ..$ id         : chr "rec0E97Ze9J6iyLBW"
  ..$ fields     :List of 19
  .. ..$ permalink               : chr "nogarifilm"
  .. ..$ is_live                 : chr "true"
  .. ..$ amount                  : int 700000
  .. ..$ count                   : int 13
  .. ..$ start_date              : chr "2016-02-02"
```

### Retrieve a Record
```r
> record <- airtable$archive$retrieve_record("rec0E97Ze9J6iyLBW")
```

```r
> str(record)

List of 3
 $ id         : chr "rec0E97Ze9J6iyLBW"
 $ fields     :List of 19
  ..$ permalink               : chr "nogarifilm"
  ..$ is_live                 : chr "true"
  ..$ amount                  : int 700000
  ..$ count                   : int 13
  ..$ start_date              : chr "2016-02-02"

```

### Create a Record
```r
> airtable$archive$create_record(fields = list(field_name = "foo"))
```

```
Response [https://api.airtable.com/v0/<YOUR BASE NAME>/archive/<RECORD_ID>]
  Date: 2016-03-13 12:57
  Status: 200
  Content-Type: application/json; charset=utf-8
  Size: 41 B
```

### Update a Record
```r
# Issuing a PATCH request
> airtable$archive$update_record("<RECORD_ID>", fields = list(field_name = "bar"))
```

```
Response [https://api.airtable.com/v0/<YOUR BASE NAME>/archive/<RECORD_ID>]
  Date: 2016-03-13 12:57
  Status: 200
  Content-Type: application/json; charset=utf-8
  Size: 41 B
```

```r
# Issuing a PUT request
> airtable$archive$update_record("<RECORD_ID>", fields = list(field_name = "foobar"), method = "put")
```

```
Response [https://api.airtable.com/v0/<YOUR BASE NAME>/archive/<RECORD_ID>]
  Date: 2016-03-13 12:57
  Status: 200
  Content-Type: application/json; charset=utf-8
  Size: 41 B
```

### Delete a Record
```r
> airtable$archive$delete_record("<RECORD_ID>")
```

```
Response [https://api.airtable.com/v0/<YOUR BASE NAME>/archive/<RECORD_ID>]
  Date: 2016-03-13 12:57
  Status: 200
  Content-Type: application/json; charset=utf-8
  Size: 41 B
```

