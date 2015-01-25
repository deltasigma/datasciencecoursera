library("httr")

oauth_endpoints("github")

app <- oauth_app("github",
                 key = "663aabb8ff4aa9cad9d5",
                 secret = "15597dff2f76440fa7d673d9d038d38a74c00418")

github_token <- oauth2.0_token(oauth_endpoints("github"),app)

gtoken <- config(token = github_token)

req <- GET('https://api.github.com/users/jtleek/repos',gtoken)
stop_for_status(req)
json1 <- content(req)
json2 <- jsonlite::fromJSON(toJSON(json1))