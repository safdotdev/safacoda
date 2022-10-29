## Get started with pact

1. `cd ~/path-to-pact-nirvana/Step_01_WriteYourFirstPact`{{exec}}
2. `npm run test:consumer`{{exec}}
3. `cd ~/path-to-pact-nirvana/Step_02_VerifyYourFirstPactLocally`{{exec}}
4. `npm run test:provider`{{exec}}
5. `cd ~/path-to-pact-nirvana/Step_03_GetAPactBroker`{{exec}}
6. `docker-compose up -d`{{exec}}
7.  `cd ~/path-to-pact-nirvana/Step_04_PublishYourFirstPactLocally`{{exec}}
8.  `make publish_docker`{{exec}}
9.  `cd ~/path-to-pact-nirvana/Step_05_VerifyYourFirstPactFromABrokerLocally`
10. `npm run test:provider`{{exec}}
11. `cd ~/path-to-pact-nirvana/Step_06_PublishYourFirstPactFromCI`{{exec}}
12. `make ci`{{exec}}
13. `cd ~/path-to-pact-nirvana/Step_07_VerifyYourFirstPactFromCI`{{exec}}
14. `make ci`{{exec}}
15. `cd ~/path-to-pact-nirvana/Step_08_AddCanIDeployForProvider`{{exec}}
16. `make can_i_deploy`{{exec}}
17. `cd ~/path-to-pact-nirvana/Step_09_AddRecordDeploymentForProvider`{{exec}}
18. `make record_deployment`{{exec}}
19. `cd ~/path-to-pact-nirvana/Step_10_AddCanIDeployForConsumer`{{exec}}
20. `make can_i_deploy`{{exec}}
21. `cd ~/path-to-pact-nirvana/Step_11_AddRecordDeploymentForConsumer`{{exec}}
22. `make record_deployment`{{exec}}
23. `cd ~/path-to-pact-nirvana/Step_13_CompleteBuild`{{exec}}