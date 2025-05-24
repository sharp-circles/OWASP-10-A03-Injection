# OWASP-10-A03-Injection

SQL injection penetration testing lab using sqlmap statements against OWASP WebGoat project

## Resources

* RTFM - Read Team Field Manual. Provides sqlmap statement templates.
* WebGoat - A deliberately vulnerable web application provided by OWASP

## Description

In this present lab, we lean on WebGoat application as the target for our investigations. 

First, we have learned how to bootstrap WebGoat following the official docs: https://github.com/WebGoat/WebGoat

Then, a little investigation around the application was necessary in order to understand workflows and services exposed.

Then, we execute sqlmap following the RTFM indications for the penetration testing. We faced many errors on the course of the process. As a result, we have tailored the outcomes and explanation for deeper understanding.

## Output

1. Custom sqlmap statements for successful results.
2. README.md with extended explanations about the potential issues that can appear during the analysis phase. 

## Potential issues and explanations when executing sqlmap against WebGoat

1. Endpoint enumeration.

Explain here.

2. Redirection caused by lack of authentication.

The access to the inner endpoints for the lessons is proxied by a required login. Therefore, automation hits this first barrier when starting the analysis.

3. Authentication cookie missing.

Skipping the redirects is not enough, as the validation for the session will be there. That's the second step. By navigating to the cookies section in the inspector, you can grab the cookie session and patch the statement accordingly.

4. 400 HTTP errors.

Bad request, validation errors are another form of walls that can get in the way of a smoother detection phase. Ensure required parameters are provided to get the expected server response.
