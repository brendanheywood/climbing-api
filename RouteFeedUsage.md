# Introduction #


## Pre processing tools ##

Currently large amounts of route data is stores in unstructured text in legacy guide books, wikis, word documents.

This project aims to create tools that will at least partially automate the conversion of free text into a structured xml file, ready for importing into a compliant route database.


## Syncing with offline databases ##

A mobile device can subscribe to multiple route feeds, from multiple data sources. Whenever the device has connectivity it will request the set of changes from the last update and merge these into its internal database.

The device may also be capable of creating new routes or modifying existing routes. These will be pushed back to the central database via a seperate spec. This spec is intended to be the AtomPub spec.

This project aims to create a pure javascript based offline capable client for subscribing to multiple route feeds.





## Export and import of data ##

Potentially there may be multiple database / website products for storing and manipulating climbing data. If both can import and export their data as a climbing xml document then migrating from one product to another would be fairly painless.

In reality there is a very small market of such products, with a few large proprietary web sites that store structured data and a large number of small independent clubs, groups, etc that manage largely unstructured data.

This project aims to create an open source reference implementation web application for storing and managing route data and serving these as route feeds.

## Syndication of route data ##

Say a small climbing club want to manage their own climbing data but have that data  available in various places. Eg managed locally but published to the Australian climbing association listing as well as climbing.com etc. They could publish their data as a feed and those other sites could syndicate the data.

The syndicating databases must behave well in a couple of respects:
**They must store the original atom:id of an entry so that updates to routes merge and do not duplicate data** They must handle deletions of data - even if just flagging it as removed without deleting it

The syndicating site _could_ republish this as a new feed as long as the original id an timestamps are retained so that a client subscribing to both feed knows they are the same data.

This project aims to enable the reference implementation mentioned above to also consume and aggregate climbing feeds from other compliant feed producers.