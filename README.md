This is a web application for workers.

## Make `credentials.yml.enc`
```
$ EDITOR="vim" bin/rails credentials:edit
```

## `credentials.yml.enc` Sample
```
timecrowd:
  client_id: "CLIENT_ID"
  client_secret: "CLIENT_SECRET"
  site: "https://timecrowd.net/"
misoca:
  client_id: "CLIENT_ID"
  client_secret: "CLIENT_SECRET"
```
