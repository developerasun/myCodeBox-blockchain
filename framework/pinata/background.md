# Learning Pinata essentials

## URL vs CID

Matching URL for NFT can be a mistake since the URL can change over time. Imagine customers lost their NFTs by not being able to find a proper URL.
Not good.

This is where IPFS comes into play. IPFS handles the URL problem with content-addressable data. The data itself has a name. If data changes, the name also changes(Content Identifier, CID. Sometimes called hashes.)

By matching(locking) name to image(data), you would be able to prove if the data is changed.

The same URL can point to the different images.

![url-content](https://user-images.githubusercontent.com/83855174/174602142-c31e5197-a4b6-402b-bdaa-e3c3da51f144.png)

The CID can't point to the different images. The hash(CID) will only refer one exact image.

![cid-content](https://user-images.githubusercontent.com/83855174/174602163-fd0717b3-3d88-491f-a6a9-ddde22cdb1d5.png)

## Reference

- [Pinata](https://www.pinata.cloud/)
