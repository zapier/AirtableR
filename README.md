# AirtableR
R wrapper to the Airtable API 

For more information on the Airtable API see: http://api.airtable.com/

## Quick Start

### Installation
```r
> devtools::install_github("jsng/AirtableR")
> library(AirtableR)
```

### Set API key
Firstly, you should enter your Airtable API key.
```r
> airtable <- Airtable(
    app = "<YOUR APP NAME>", 
    tables = c("archive", "items")
  )

Couldn't find env var AIRTABLE_KEY. See ?airtable_key for more details.
Please enter your KEY and press enter:
```

You can set Airtable API Key in `.Renviron` file.
```r
AIRTABLE_KEY=<YOUR API KEY HERE>
```

## Basic Usage
### List all Records
```r
> airtable$archive$list_records()
```

### Retrieve a Record
```r
> airtable$archive$retrieve_record("<RECORD_ID>")
```

### Create a Record
```r
> airtable$archive$create_record(fields = list(field_name = "foo"))
```

### Update
```r
> airtable$archive$update_record("<RECORD_ID>", fields = list(field_name = "bar"))
> airtable$archive$update_record("<RECORD_ID>", fields = list(field_name = "foobar"), method = "put")
```
