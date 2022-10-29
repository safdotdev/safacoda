## Get started with pact

1. `cd ~/path-to-pact-nirvana/Step_01_WriteYourFirstPact`{{exec}}
2. `npm run test:consumer`{{exec}}
3. `cd ~/path-to-pact-nirvana/Step_02_VerifyYourFirstPactLocally`{{exec}}
4. `npm run test:provider`{{exec}}
5. `cd ~/path-to-pact-nirvana/Step_03_GetAPactBroker`{{exec}}
6. `docker-compose up -d`{{exec}}
   1. In a few moments, the new web interface will be available. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents.
7.  `cd ~/path-to-pact-nirvana/Step_04_PublishYourFirstPactLocally`{{exec}}
8.  `make publish_docker`{{exec}}
9.  `cd ~/path-to-pact-nirvana/Step_05_VerifyYourFirstPactFromABrokerLocally`{{exec}}
10. `npm run test:provider`{{exec}}
11. `cd ~/path-to-pact-nirvana/Step_06_PublishYourFirstPactFromCI`{{exec}}
12. `make ci`{{exec}}
13. `export PACT_BROKER_PUBLISH_VERIFICATION_RESULTS=true`{{exec}}
14. `cd ~/path-to-pact-nirvana/Step_07_VerifyYourFirstPactFromCI`{{exec}}
15. `make ci`{{exec}}
16. `cd ~/path-to-pact-nirvana/Step_08_AddCanIDeployForProvider`{{exec}}
17. `make can_i_deploy_docker`{{exec}}
18. `cd ~/path-to-pact-nirvana/Step_09_AddRecordDeploymentForProvider`{{exec}}
19. `make record_deployment_docker`{{exec}}
20. `cd ~/path-to-pact-nirvana/Step_10_AddCanIDeployForConsumer`{{exec}}
21. `make can_i_deploy_docker`{{exec}}
22. `cd ~/path-to-pact-nirvana/Step_11_AddRecordDeploymentForConsumer`{{exec}}
23. `make record_deployment_docker`{{exec}}
24. `cd ~/path-to-pact-nirvana/Step_13_CompleteBuild`{{exec}}
25. `make ci_consumer`{{exec}}
26. `make ci_provider`{{exec}}
27. `make ci_provider_contract_requiring_verification`{{exec}}