# Create your API definition in SwaggerHub

1. [Login](https://app.swaggerhub.com/login) into Swaggerhub, either SSO, GitHub, or Email.
2. Get your [API Key](https://app.swaggerhub.com/settings/apiKey) and select `Copy API Key`
3. Type `npx swaggerhub-cli configure`{{execute}}
   1. If you have a custom SwaggerHub URL, enter it when asked, otherwise press enter, to select the default `https://api.swaggerhub.com`
   2. When asked for your `API Key`, paste the token from step 2 in.
4. Set an environment variable with your SwaggerHub Org name. Note this is case sensitive (or needs to be uppercased)
   1. Click to copy me `export SWAGGERHUB_ORG=` and paste in Tab 1 followed by your ORG name.
5. `npx swaggerhub-cli api:create $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 --visibility=public -f oas/products_v1.0.0.yml`{{execute}}
6. `npx swaggerhub-cli integration:create $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 -f integrations/api_auto_mocking.json`{{execute}}
7. `npx swaggerhub-cli integration:list $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 | tail -n 1 | cut -f1,2 -d' ' | xargs echo $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 | sed -e "s/ /\//g" | xargs npx swaggerhub-cli integration:execute`{{execute}}
8. `mocked_endpoint=$(npx swaggerhub-cli api:get $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 --json | jq -r '.servers[0].url')`{{execute}}
   1. `curl -s $mocked_endpoint/products | jq .`{{execute}}
   2. `curl -s $mocked_endpoint/product/42 | jq .`{{execute}}
9. `endpoint=$mocked_endpoint yq -i '.endpoint = strenv(endpoint)' dredd.yml`{{execute}}
10. `$npx -y dredd $mocked_endpoint`{{execute}}
11. `$npx swaggerhub-cli api:get $SWAGGERHUB_ORG/pactflow-demo/v1.0.1 > oas/products_v1.0.1.yml`{{execute}}
