# Data Lake SQL Proxy

This repo has a simple Makefile and Dockerfile to facilitate access through a proxy to our Postgres server in GCP.


## Make commands

To run the proxy, you'll need to login to google through gcloud sdk. 
Make will automate this process through the following command:

> Remember to run this inside the repo

```sh
make proxy-login
```

Once you've logged in, run the bellow command to start the proxy.

```bash
make proxy-run
```

Now the database will be open for connections on **localhost:5432**
