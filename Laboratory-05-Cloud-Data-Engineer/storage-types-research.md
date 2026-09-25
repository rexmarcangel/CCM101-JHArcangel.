## Cloud storage has different types depending on how the data will be used. The three common types are Block Storage, File Storage, and Object Storage.

| Storage Type   | Description                                                                      | Primary Use Case                                                           | Cloud Provider Example |
| -------------- | -------------------------------------------------------------------------------- | -------------------------------------------------------------------------- | ---------------------- |
| Block Storage  | Stores data in blocks and works like a disk that can be attached to a server.    | Operating systems, databases, and applications that need fast disk access. | AWS EBS                |
| File Storage   | Stores files and folders in a shared file system.                                | Sharing files and folders between different users or servers.              | AWS EFS                |
| Object Storage | Stores files as objects together with metadata inside containers called buckets. | Images, videos, backups, documents, and other large unstructured data.     | Amazon S3              |

## Why Object Storage is Suitable

For the client's photo-sharing application, I would use Object Storage because it is designed for storing large amounts of files such as photos. It can also handle a large number of objects and can grow as more users upload images.

