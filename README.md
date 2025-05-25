# OWASP-10-A03-Injection I

SQL injection penetration testing lab using sqlmap statements against OWASP WebGoat project

First lab of a two deliveries series on injections

## Resources

* RTFM - Read Team Field Manual. Provides sqlmap statement templates.
* WebGoat - A deliberately vulnerable web application provided by OWASP

## Description

In this present lab, we lean on WebGoat application as the target for our investigations. 

First, we have learned how to bootstrap WebGoat following the official docs: https://github.com/WebGoat/WebGoat

Then, a little investigation around the application was necessary in order to understand workflows and services exposed.

Lastly, we execute sqlmap following the RTFM indications for the penetration testing. We faced many errors on the course of the process. As a result, we have tailored the outcomes and explanations for deeper understanding.

## Output

1. Custom sqlmap statements for successful results.
2. README.md with extended explanations about the potential issues that can appear during the analysis phase.

## Navigating through WebGoat

The WebGoat project is just not a vulnerable application. It is also a whole infrastructure for teaching purposes. What we find once we log in is a main menu divided by the categories of the OWASP principal vulnerabilities. In each of those items, you can find submenus with explanations and lessons, both theoretical and practical.

### Tips for launching

Launching it is quite easy. You just need to go to the official github repo and follow a few instructions. 

In our case, we did the following.

1. Launch the docker image to run the application

```docker run -it -p 127.0.0.1:8080:8080 -p 127.0.0.1:9090:9090 webgoat/webgoat```

2. Access through the browser. If it returns a not found page, try http://localhost:8080/WebGoat/login

3. Create a new user and access the application

### Manual endpoint enumeration

What we did is actually quite easy. And totally open. We used the inspector tab to gather information about the connections to the WebGoat API. By linking the lessons and the endpoints hit, we extracted the urls.

Additionally, the fact of knowing what the paths are allows you to perform a deeper search in the source code. GitHub has a cool search engine for this. Go to the source code and try with a path. You will probably obtain a few matches. 

Here's an example

```
  @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public List<Server> sort(@RequestParam String column) throws Exception {
    List<Server> servers = new ArrayList<>();

    try (var connection = dataSource.getConnection()) {
      try (var statement =
          connection.prepareStatement(
              "select id, hostname, ip, mac, status, description from SERVERS where status <> 'out"
                  + " of order' order by "
                  + column)) {
        try (var rs = statement.executeQuery()) {
          while (rs.next()) {
            Server server =
                new Server(
                    rs.getString(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getString(6));
            servers.add(server);
          }
        }
      }
    }
    return servers;
  }
}
```

REST API controllers are quite eloquent. Even if you are not a Java developer, you can quickly recognize attributes, tags, behaviors, structures or entry points.

Setting off from this point, it is easy to analyze the code and draw conclusions. 

As you are probably guessing, this can be extended widely: you can search for database migrations, configurations, third party libraries and a long etc.

## Potential issues and explanations when executing sqlmap against WebGoat

### Endpoint enumeration.

A recognition phase is necessary at first to gather input details for the sqlmap statements. 

### Redirection caused by lack of authentication.

The access to the inner endpoints for the lessons is proxied by a required login. Therefore, automation hits this first barrier when starting the analysis.

### Authentication cookie missing.

Skipping the redirects is not enough, as the validation for the session will be there. That's the second step. By navigating to the cookies section in the inspector, you can grab the cookie session and patch the statement accordingly.

### 400 HTTP errors.

Bad request, validation errors are another form of walls that can get in the way of a smoother detection phase. Ensure required parameters are provided to get the expected server response.
