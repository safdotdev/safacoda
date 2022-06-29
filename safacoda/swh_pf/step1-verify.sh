[ -f pact-broker ] && echo "done"

if npx -y dredd $mocked_endpoint; then pactflow publish-provider-contract \
    oas/products_v1.0.0.yml \
    --provider swh-pf-demo-provider \
    --provider-app-version 1234 \
    --branch testbranch \
    --content-type 'application/yaml' \
    --verification-success \
    --verification-results output/report.md \
    --verification-results-content-type 'plain/text' \
    --verifier 'dredd'; else pactflow publish-provider-contract \
        oas/products_v1.0.0.yml \
        --provider swh-pf-demo-provider \
        --provider-app-version 1234 \
        --branch testbranch \
        --content-type 'application/yaml' \
        --verification-failure \
        --verification-results output/report.md \
        --verification-results-content-type 'plain/text' \
        --verifier 'dredd'; fi

pactflow publish-provider-contract \
    oas/products_v1.0.0.yml \
    --provider swh-pf-demo-provider \
    --provider-app-version 1234 \
    --branch testbranch \
    --content-type 'application/yaml' \
    --verification-exit-code=0 \
    --verification-results output/report.md \
    --verification-results-content-type 'plain/text' \
    --verifier 'dredd'
