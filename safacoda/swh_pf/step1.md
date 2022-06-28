# Create your API definition in SwaggerHub

1. [Login](https://app.swaggerhub.com/login) into Swaggerhub, either SSO, GitHub, or Email.
2. Get your [API Key](https://app.swaggerhub.com/settings/apiKey) and select `Copy API Key`
3. Type `npx swaggerhub-cli configure`{{execute}}
   1. If you have a custom SwaggerHub URL, enter it when asked, otherwise press enter, to select the default `https://api.swaggerhub.com`
   2. When asked for your `API Key`, paste the token from step 2 in.
4. Set an environment variable with your SwaggerHub Org name. Note this is case sensitive (or needs to be uppercased)
   1. `export SWAGGERHUB_ORG=<enter your org here>`
   2. Click me in Tab1 - `export SWAGGERHUB_ORG=`{{execute}}
5. Click me in Tab1 - `npx swaggerhub-cli api:create $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 --visibility=public -f oas/products_v1.0.0.yml`{{execute}}
6. Click me in Tab1 - `swaggerhub integration:create $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 -f integrations/api_auto_mocking.json`{{execute}}
