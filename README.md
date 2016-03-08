# AirtableR
R wrapper to the Airtable API 

For more information on the Airtable API see: http://api.airtable.com/

## Quick Start

### Installation
```r
> install.packages("AirtableR")
> library(AirtableR)
```

### Set API key
Firstly, you should enter your Airtable API key.
```r
> airtable <- Airtable("<YOUR APP NAME>", "<YOUR TABLE NAME>")

Couldn't find env var AIRTABLE_KEY. See ?airtable_key for more details.
Please enter your KEY and press enter:
```

## Basic Usage
### List all Records
```r
> list_records(airtable)
```

### Retrieve a Record
```r
> retrieve_record(airtable, "<RECORD_ID>")
```

### Create a Record
```r
> create_record(airtable, fields = list(field_name = "foo"))
```

### Update
```r
> update_record(airtable, "<RECORD_ID>", fields = list(field_name = "bar"))
> update_record(airtable, "<RECORD_ID>", fields = list(field_name = "foobar"), method = "put")
```
