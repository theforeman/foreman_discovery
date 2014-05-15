# foreman\_discovery api

The most up-to-date API information should be documented in the api cache on your Foreman server. However, this may serve as a useful reference.

# GET /api/v2/discovered_hosts

gives an index of discovered hosts:

```
{
  "total": 1,
  "subtotal": 1,
  "page": 1,
  "per_page": 20,
  "search": null,
  "sort": {
    "by": null,
    "order": null
  },
  "results": [
  {
    "name":"mac52540007aa4d",
    "id":754,
    "ip":"192.168.124.50",
    "mac":"11:22:33:44:55:66",
    ...
  }]
}
```

# GET /api/v2/discovered_hosts/:id

gives a more detailed view of a discovered host, including known facts:

```
{
  "name":"mac52540007aa4d",
  "id":754,
  "ip":"192.168.124.50",
  "mac":"11:22:33:44:55:66",
  ...
  "facts_hash":{
    "macaddress":"11:22:33:44:55:66",
    ...
  }
}
```

# POST /api/v2/discovered_hosts

Create a new discovered host. Name, mac, and IP is the minimum. Wrap data in
a 'discovered_host' root node, such as:

```
{
  "discovered_host": {
    "name": "mac52540007aa4d",
    "mac": "11:22:33:44:55:66",
    "ip": "192.168.124.50"
  }
}
```

# PUT /api/v2/discovered_hosts/:id

Provision a discovered host into a real managed host. All the same requirements as for
normal managed hosts apply. Wrap the data in a 'discovered_host' root node, such as:

```
{
  "discovered_host": {
    "name": "mac52540007aa4d",
    "mac": "11:22:33:44:55:66",
    "ip": "192.168.124.50",
    "hostgroup_id": "6",
    "root_pass": "12345678",
    "subnet_id": "2"
  }
}
```

# DELETE /api/v2/discovered_hosts/:id

Deletes the requested discovered host.
