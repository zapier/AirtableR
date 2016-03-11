# Airtable.R
R wrapper to the Airtable API 

For more information on the Airtable API see: http://api.airtable.com/

## Quick Start

### Installation
```r
> devtools::install_github("jsng/Airtable.R")
> library(Airtable.R)
```

### Authentication
Firstly, you should enter your Airtable API key.
```r
> airtable <- Airtable(
    app = "<YOUR APP NAME>", # e.g "appZNrwXN7bsOU0ta"
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

### Update a Record
```r
> airtable$archive$update_record("<RECORD_ID>", fields = list(field_name = "bar"))
```

```r
> airtable$archive$update_record("<RECORD_ID>", fields = list(field_name = "foobar"), method = "put")
```
